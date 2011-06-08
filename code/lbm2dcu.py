'''
Created on May 16, 2011

@author: Jacob Salomonsen
'''

import numpy as np
import pycuda.driver as cuda
import pycuda.autoinit
from pycuda.compiler import SourceModule

' Simulation attributes '
nx = 23
ny = 23
it = 900

' Constants '
omega   = 1.0
density = 1.0
t1      = 4/9.0
t2      = 1/9.0
t3      = 1/36.0
deltaU  = 1e-7
c_squ   = 1/3.0

' Create the main arrays '
F           = np.zeros((9,nx,ny), dtype=float).astype(np.float32)
F[:,:,:]   += density/9.0
T           = np.copy(F)
FEQ         = np.copy(F)
BOUNCEBACK  = np.zeros(F.shape, dtype=float).astype(np.float32)
DENSITY     = np.zeros((nx,ny), dtype=float).astype(np.float32)
UX          = np.copy(DENSITY)
UY          = np.copy(DENSITY)
BOUND       = np.copy(DENSITY)

' Create the scenery '
scenery = 0

# Tunnel
if scenery == 0:
    BOUND  [0,:] = 1.0
# Circle
elif scenery == 1:
    for i in xrange(nx):
        for j in xrange(ny):
            if ((i-4)**2+(j-5)**2+(5-6)**2) < 6:
                BOUND  [i,j] = 1.0
    BOUND  [:,0] = 1.0
# Random porous domain
elif scenery == 2:
    BOUND  = np.random.randint(2, size=(nx,ny)).astype(np.float32)
# Lid driven cavity
elif scenery == 3:
    BOUND  [-1,:]  = 1.0
    BOUND  [1:,0]  = 1.0
    BOUND  [1:,-1] = 1.0

''' CUDA specific '''
' Calculate block and grid dimensions '
#threadsPerBlock = 256
#blocksPerGrid   = (nx*ny + threadsPerBlock - 1) / threadsPerBlock
dim         = 16
blockDimX   = min(nx,dim)
blockDimY   = min(ny,dim)
gridDimX    = (nx+dim-1)/dim
gridDimY    = (ny+dim-1)/dim

' Allocate memory on the GPU '
F_gpu       = cuda.mem_alloc(F.size * F.dtype.itemsize)
T_gpu       = cuda.mem_alloc(T.size * F.dtype.itemsize)
FEQ_gpu     = cuda.mem_alloc(FEQ.size * FEQ.dtype.itemsize)

BOUND_gpu   = cuda.mem_alloc(BOUND.size * BOUND.dtype.itemsize)
BOUNCEBACK_gpu = cuda.mem_alloc(BOUNCEBACK.size * BOUNCEBACK.dtype.itemsize)
DENSITY_gpu = cuda.mem_alloc(DENSITY.size * DENSITY.dtype.itemsize)
UX_gpu      = cuda.mem_alloc(UX.size * UX.dtype.itemsize)
UY_gpu      = cuda.mem_alloc(UY.size * UY.dtype.itemsize)

U_SQU_gpu   = cuda.mem_alloc(DENSITY.size * DENSITY.dtype.itemsize)
U_C2_gpu    = cuda.mem_alloc(DENSITY.size * DENSITY.dtype.itemsize)
U_C4_gpu    = cuda.mem_alloc(DENSITY.size * DENSITY.dtype.itemsize)
U_C6_gpu    = cuda.mem_alloc(DENSITY.size * DENSITY.dtype.itemsize)
U_C8_gpu    = cuda.mem_alloc(DENSITY.size * DENSITY.dtype.itemsize)

' Copy constants and variables to the gpu ' 
cuda.memcpy_htod(F_gpu, F)
cuda.memcpy_htod(FEQ_gpu, FEQ)

cuda.memcpy_htod(BOUND_gpu, BOUND)
cuda.memcpy_htod(BOUNCEBACK_gpu, BOUNCEBACK)
cuda.memcpy_htod(DENSITY_gpu, DENSITY)
cuda.memcpy_htod(UX_gpu, UX)
cuda.memcpy_htod(UY_gpu, UY)

cuda.memcpy_htod(U_SQU_gpu, DENSITY)
cuda.memcpy_htod(U_C2_gpu, DENSITY)
cuda.memcpy_htod(U_C4_gpu, DENSITY)
cuda.memcpy_htod(U_C6_gpu, DENSITY)
cuda.memcpy_htod(U_C8_gpu, DENSITY)

' Definition of kernels '
propagateKernel = """
    // F4  F3  F2
    //   \ |  /
    // F5--F0--F1
    //   / |  \
    // F6  F7  F8
    
    __global__ void propagateKernel(float *F, float *T) {
        int x     = threadIdx.x + blockIdx.x * blockDim.x;
        int y     = threadIdx.y + blockIdx.y * blockDim.y;
        int nx    = %(WIDTH)s;
        int ny    = %(HEIGHT)s;
        int size  = nx * ny;
        int cur   = x + y * nx;        // current position
        
        if(x < nx && y < ny) {
            // nearest neighbours
            int F1 = (x==0?nx-1:x-1) + y * nx; // +x
            int F3 = x + (y==0?ny-1:y-1) * nx; // +y
            int F5 = (x==nx-1?0:x+1) + y * nx; // -x
            int F7 = x + (y==ny-1?0:y+1) * nx; // -y
            
            // next-nearest neighbours
            int F2 = (x==0?nx-1:x-1) + (y==0?ny-1:y-1) * nx; //+x+y
            int F4 = (x==nx-1?0:x+1) + (y==0?ny-1:y-1) * nx; //-x+y
            int F6 = (x==nx-1?0:x+1) + (y==ny-1?0:y+1) * nx; //-x-y
            int F8 = (x==0?nx-1:x-1) + (y==ny-1?0:y+1) * nx; //+x-y

            // propagate nearest
            F[1*size + cur] = T[1*size + F1];
            F[3*size + cur] = T[3*size + F3];
            F[5*size + cur] = T[5*size + F5];
            F[7*size + cur] = T[7*size + F7];
            
            // propagate next-nearest
            F[2*size + cur] = T[2*size + F2];
            F[4*size + cur] = T[4*size + F4];
            F[6*size + cur] = T[6*size + F6];
            F[8*size + cur] = T[8*size + F8];
        }
    }"""
propagateKernel = propagateKernel % {
    'WIDTH': nx,
    'HEIGHT': ny 
}

densityKernel = """
    __global__ void densityKernel(float *F, float *BOUND, float * BOUNCEBACK, 
                                  float *D, float *UX, float *UY) {
        int x     = threadIdx.x + blockIdx.x * blockDim.x;
        int y     = threadIdx.y + blockIdx.y * blockDim.y;
        int nx    = %(WIDTH)s;
        int ny    = %(HEIGHT)s;
        int size  = nx * ny;
        int cur   = x + y * nx;
        
        if(x < nx && y < ny) {
            if(BOUND[cur] == 1.0f) {
                BOUNCEBACK[1*size + cur] = F[5*size + cur];
                BOUNCEBACK[2*size + cur] = F[6*size + cur];
                BOUNCEBACK[3*size + cur] = F[7*size + cur];
                BOUNCEBACK[4*size + cur] = F[8*size + cur];
                BOUNCEBACK[5*size + cur] = F[1*size + cur];
                BOUNCEBACK[6*size + cur] = F[2*size + cur];
                BOUNCEBACK[7*size + cur] = F[3*size + cur];
                BOUNCEBACK[8*size + cur] = F[4*size + cur];
            }
            
            float DENSITY = F[0*size + cur] + 
                            F[1*size + cur] +
                            F[2*size + cur] +
                            F[3*size + cur] +
                            F[4*size + cur] +
                            F[5*size + cur] +
                            F[6*size + cur] +
                            F[7*size + cur] +
                            F[8*size + cur];
            
            D[cur] = DENSITY;
            
            UX[cur] = ((F[1*size + cur] + F[2*size + cur] + F[8*size + cur]) -
                       (F[4*size + cur] + F[5*size + cur] + F[6*size + cur]))
                        / DENSITY;
                     
            UY[cur] = ((F[2*size + cur] + F[3*size + cur] + F[4*size + cur]) -
                       (F[6*size + cur] + F[7*size + cur] + F[8*size + cur])) 
                        / DENSITY;
            
            if (%(SCENERY)s == 3){
                // For lid driven cavity
                if(y == 0) {
                    UX[cur] += 0.04f;
                }
            } else {
                if(x == 0) {
                    UX[cur] += %(DELTAU)sf;
                }
            }
            
            if(BOUND[cur] == 1.0f) {
                D[cur] = 0.0f;
                UX[cur] = 0.0f;
                UY[cur] = 0.0f;
            }
        }
    }
    """
densityKernel = densityKernel % {
    'WIDTH': nx,
    'HEIGHT': ny,
    'SCENERY': scenery, 
    'DELTAU': deltaU
}

eqKernel = """
    __global__ void eqKernel(float *F, float* FEQ, float *DENSITY, float *UX, 
                             float *UY, float *U_SQU, float *U_C2, float *U_C4, 
                             float *U_C6, float *U_C8) {
        int x     = threadIdx.x + blockIdx.x * blockDim.x;
        int y     = threadIdx.y + blockIdx.y * blockDim.y;
        int nx    = %(WIDTH)s;
        int ny    = %(HEIGHT)s;
        int size  = nx * ny;
        int cur   = x + y * nx;
        
        if(x < nx && y < ny) {
            // constants
            float t1 = %(T1)s;
            float t2 = %(T2)s;
            float t3 = %(T3)s;
            float c_squ = %(C_SQU)s;
            float omega = %(OMEGA)s;
            
            if(x < %(WIDTH)s || y < %(HEIGHT)s) {
                U_SQU[cur] = UX[cur]*UX[cur] + UY[cur]*UY[cur];
                U_C2[cur]  = UX[cur]+UY[cur];
                U_C4[cur]  = -UX[cur]+UY[cur];
                U_C6[cur]  = -U_C2[cur];
                U_C8[cur]  = -U_C4[cur];
                
                // Calculate equilibrium distribution: stationary
                FEQ[0*size + cur] = t1*DENSITY[cur]*(1-U_SQU[cur]/(2*c_squ));
                
                // nearest-neighbours
                FEQ[1*size + cur] = t2*DENSITY[cur]*(1+UX[cur]/c_squ+0.5f*
                         (UX[cur]/c_squ)*(UX[cur]/c_squ)-U_SQU[cur]/(2*c_squ));
                FEQ[3*size + cur] = t2*DENSITY[cur]*(1+UY[cur]/c_squ+0.5f*
                         (UY[cur]/c_squ)*(UY[cur]/c_squ)-U_SQU[cur]/(2*c_squ));
                FEQ[5*size + cur] = t2*DENSITY[cur]*(1-UX[cur]/c_squ+0.5f*
                         (UX[cur]/c_squ)*(UX[cur]/c_squ)-U_SQU[cur]/(2*c_squ));
                FEQ[7*size + cur] = t2*DENSITY[cur]*(1-UY[cur]/c_squ+0.5f*
                         (UY[cur]/c_squ)*(UY[cur]/c_squ)-U_SQU[cur]/(2*c_squ));
                
                // next-nearest neighbours
                FEQ[2*size + cur] = t3*DENSITY[cur]*(1+U_C2[cur]/c_squ+0.5f*
                     (U_C2[cur]/c_squ)*(U_C2[cur]/c_squ)-U_SQU[cur]/(2*c_squ));
                FEQ[4*size + cur] = t3*DENSITY[cur]*(1+U_C4[cur]/c_squ+0.5f*
                     (U_C4[cur]/c_squ)*(U_C4[cur]/c_squ)-U_SQU[cur]/(2*c_squ));
                FEQ[6*size + cur] = t3*DENSITY[cur]*(1+U_C6[cur]/c_squ+0.5f*
                     (U_C6[cur]/c_squ)*(U_C6[cur]/c_squ)-U_SQU[cur]/(2*c_squ));
                FEQ[8*size + cur] = t3*DENSITY[cur]*(1+U_C8[cur]/c_squ+0.5f*
                     (U_C8[cur]/c_squ)*(U_C8[cur]/c_squ)-U_SQU[cur]/(2*c_squ));
                
                F[0*size + cur] = omega*FEQ[0*size + cur] +
                                                     (1-omega)*F[0*size + cur];
                F[1*size + cur] = omega*FEQ[1*size + cur] +
                                                     (1-omega)*F[1*size + cur];
                F[2*size + cur] = omega*FEQ[2*size + cur] +
                                                     (1-omega)*F[2*size + cur];
                F[3*size + cur] = omega*FEQ[3*size + cur] +
                                                     (1-omega)*F[3*size + cur];
                F[4*size + cur] = omega*FEQ[4*size + cur] +
                                                     (1-omega)*F[4*size + cur];
                F[5*size + cur] = omega*FEQ[5*size + cur] +
                                                     (1-omega)*F[5*size + cur];
                F[6*size + cur] = omega*FEQ[6*size + cur] +
                                                     (1-omega)*F[6*size + cur];
                F[7*size + cur] = omega*FEQ[7*size + cur] +
                                                     (1-omega)*F[7*size + cur];
                F[8*size + cur] = omega*FEQ[8*size + cur] +
                                                     (1-omega)*F[8*size + cur];
            }
        }
    }
    """
eqKernel = eqKernel % {
    'WIDTH': nx,
    'HEIGHT': ny,
    'T1': t1,
    'T2': t2,
    'T3': t3,
    'C_SQU': c_squ,
    'OMEGA': omega
}

bouncebackKernel = """
    __global__ void bouncebackKernel(float *F, float *BOUNCEBACK, 
                                     float *BOUND) {
        int x     = threadIdx.x + blockIdx.x * blockDim.x;
        int y     = threadIdx.y + blockIdx.y * blockDim.y;
        int nx    = %(WIDTH)s;
        int ny    = %(HEIGHT)s;
        int size  = nx * ny;
        int cur   = x + y * nx;
        
        if(x < nx && y < ny) {
            if (BOUND[cur] == 1.0f) {
                F[1*size + cur] = BOUNCEBACK[1*size + cur];
                F[2*size + cur] = BOUNCEBACK[2*size + cur];
                F[3*size + cur] = BOUNCEBACK[3*size + cur];
                F[4*size + cur] = BOUNCEBACK[4*size + cur];
                F[5*size + cur] = BOUNCEBACK[5*size + cur];
                F[6*size + cur] = BOUNCEBACK[6*size + cur];
                F[7*size + cur] = BOUNCEBACK[7*size + cur];
                F[8*size + cur] = BOUNCEBACK[8*size + cur];
            }
        }
    }
    """
bouncebackKernel = bouncebackKernel % {
    'WIDTH': nx,
    'HEIGHT': ny
}

' Get kernel handles '
mod         = SourceModule(propagateKernel + densityKernel + 
                           eqKernel + bouncebackKernel)
prop        = mod.get_function("propagateKernel")
density     = mod.get_function("densityKernel")
eq          = mod.get_function("eqKernel")
bounceback  = mod.get_function("bouncebackKernel")

def loop(iterations):
    ts = 0
    while(ts<iterations):
        ' To avoid overwrites a temporary copy is made of F '
        T[:] = F
        cuda.memcpy_htod(T_gpu, T)
        
        ' Propagate '
        prop(F_gpu, T_gpu, 
             block=(blockDimX,blockDimY,1), grid=(gridDimX,gridDimY))
        
        ' Calculate density and get bounceback from obstacle nodes '
        density(F_gpu, BOUND_gpu, BOUNCEBACK_gpu, DENSITY_gpu, UX_gpu, UY_gpu,
                block=(blockDimX,blockDimY,1), grid=(gridDimX,gridDimY))
        
        ' Calculate equilibrium '
        eq(F_gpu, FEQ_gpu, DENSITY_gpu, UX_gpu, UY_gpu, U_SQU_gpu, U_C2_gpu, 
           U_C4_gpu, U_C6_gpu, U_C8_gpu, block=(blockDimX,blockDimY,1), 
           grid=(gridDimX,gridDimY))
        
        ' Transfer bounceback to obstacle nodes '
        bounceback(F_gpu, BOUNCEBACK_gpu, BOUND_gpu,
                   block=(blockDimX,blockDimY,1), grid=(gridDimX,gridDimY))
                              
        ' Copy F to host for copy to T in beginning of loop '
        cuda.memcpy_dtoh(F, F_gpu)
        
        ts += 1

' Run the loop '
loop(it)

' Copy UX and UY back to host '
cuda.memcpy_dtoh(UX, UX_gpu)
cuda.memcpy_dtoh(UY, UY_gpu)

' Plot '
import matplotlib.pyplot as plt
UY *= -1
plt.hold(True)
plt.xlabel('x')
plt.ylabel('y')
plt.title('Flow field after %sdt' % it)
plt.quiver(UX,UY, pivot='middle', color='blue')
plt.imshow(BOUND, interpolation='nearest', cmap='gist_yarg')
#plt.imshow(np.sqrt(UX*UX+UY*UY)) # fancy rainbow plot
plt.show()