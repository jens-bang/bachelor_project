<map version="0.9.0">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1306344324742" ID="ID_1837357520" MODIFIED="1307182347587" TEXT="Sections">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1306788177772" ID="ID_205614699" MODIFIED="1306788196604" POSITION="right" TEXT="Abstract"/>
<node CREATED="1306788188156" ID="ID_937011081" MODIFIED="1307463664440" POSITION="right" TEXT="Introduction">
<icon BUILTIN="prepare"/>
</node>
<node CREATED="1306788096475" ID="ID_49885604" MODIFIED="1307273593539" POSITION="right" TEXT="Theory">
<node CREATED="1306863574846" FOLDED="true" ID="ID_1757864738" MODIFIED="1307463570371" TEXT="Lattice Boltzmann Model">
<icon BUILTIN="prepare"/>
<node CREATED="1306358812897" ID="ID_1378010538" MODIFIED="1306863518412" TEXT="Assumptions about supplied formuli">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1306358757238" ID="ID_362919353" MODIFIED="1306788060346" TEXT="Initial domain analysis">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1306358763230" ID="ID_1838370157" MODIFIED="1306788060346" TEXT="Splitting into subproblems">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node CREATED="1306863599158" ID="ID_1170055576" MODIFIED="1307463671552" TEXT="CPU versus GPU">
<icon BUILTIN="stop"/>
<node CREATED="1307025543645" ID="ID_434992428" MODIFIED="1307025552765" TEXT="Description of each architecture"/>
<node CREATED="1307025537349" ID="ID_1377464455" MODIFIED="1307025540757" TEXT="Comparison"/>
<node CREATED="1307025554069" ID="ID_266563684" MODIFIED="1307025564381" TEXT="Key areas of usage"/>
<node CREATED="1306358795025" ID="ID_1110533807" MODIFIED="1306967573258" TEXT="SIMT/SIMD discussion">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node CREATED="1306863556069" ID="ID_146522185" MODIFIED="1307453069107" TEXT="Parallel Processing">
<icon BUILTIN="prepare"/>
</node>
<node CREATED="1306863475803" FOLDED="true" ID="ID_997041134" MODIFIED="1307463566083" TEXT="CUDA">
<icon BUILTIN="prepare"/>
<node CREATED="1306863481363" ID="ID_1523120664" MODIFIED="1307463563838" TEXT="CUDA Programming model">
<node CREATED="1307024945417" ID="ID_1258621819" MODIFIED="1307024950465" TEXT="Kernel"/>
<node CREATED="1307024929705" ID="ID_1441186919" MODIFIED="1307024936746" TEXT="Grid"/>
<node CREATED="1307024937273" ID="ID_1559606501" MODIFIED="1307024940346" TEXT="Block"/>
<node CREATED="1307024940985" ID="ID_531569228" MODIFIED="1307024943930" TEXT="Thread"/>
<node CREATED="1306358569658" ID="ID_1039543034" MODIFIED="1306788060347" TEXT="One datapoint per thread">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node CREATED="1306344366536" ID="ID_718428397" MODIFIED="1307453053564" TEXT="CUDA Data model">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1306358584466" ID="ID_639943365" MODIFIED="1307463563837" TEXT="Loading to memory">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1307024915738" ID="ID_103830459" MODIFIED="1307463563838" TEXT="Memory types">
<node CREATED="1307047055759" ID="ID_1314682582" MODIFIED="1307047060710" TEXT="Shared"/>
<node CREATED="1307047061215" ID="ID_1838868361" MODIFIED="1307047063350" TEXT="Constant"/>
<node CREATED="1307047063991" ID="ID_1111569343" MODIFIED="1307047065558" TEXT="Texture"/>
</node>
</node>
</node>
</node>
<node CREATED="1306344324742" FOLDED="true" ID="ID_358141911" MODIFIED="1307463653599" POSITION="right" STYLE="fork" TEXT="Implementation">
<font NAME="SansSerif" SIZE="12"/>
<icon BUILTIN="prepare"/>
<node CREATED="1306358686444" ID="ID_894867539" MODIFIED="1307219656816" TEXT="Matlab implementation analysis">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1306358692404" ID="ID_91160181" MODIFIED="1306967635931" TEXT="Variable analysis">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1306358704861" ID="ID_1049591668" MODIFIED="1306967635931" TEXT="Procedure analysis">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node CREATED="1306862114485" ID="ID_1974571051" MODIFIED="1307219655476" TEXT="NumPy">
<node CREATED="1306866653069" ID="ID_1674103458" MODIFIED="1306967622978" TEXT="Only single CPU core"/>
<node CREATED="1306839698274" ID="ID_1094897470" MODIFIED="1306967622978" TEXT="ndarray">
<node CREATED="1306859351761" ID="ID_400168049" MODIFIED="1306859358934" TEXT="Allocation"/>
</node>
<node CREATED="1306661069484" ID="ID_29777006" MODIFIED="1306967622978" TEXT="Array">
<node CREATED="1306661124957" ID="ID_1177556427" MODIFIED="1306839718056" TEXT="Array wrapping"/>
<node CREATED="1306661076372" ID="ID_1337827802" MODIFIED="1306858939565" TEXT="Column major"/>
</node>
<node CREATED="1306661175718" ID="ID_655880519" MODIFIED="1306967622977" TEXT="Used commands"/>
</node>
<node CREATED="1306862120118" ID="ID_213558880" MODIFIED="1307219653920" TEXT="PyCUDA">
<node CREATED="1306613360385" ID="ID_1225231471" MODIFIED="1307177651612" TEXT="Source Module">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1307119543965" ID="ID_68984952" MODIFIED="1307119553563" TEXT="Give an example of a source module"/>
<node CREATED="1307119556309" ID="ID_302555561" MODIFIED="1307119593309" TEXT="How is it used"/>
<node CREATED="1307119562070" ID="ID_1843300289" MODIFIED="1307119581412" TEXT="Passing parameters by string replacement (metaprogramming)"/>
</node>
<node CREATED="1306660933569" ID="ID_1611661724" MODIFIED="1307177651613" TEXT="Memory allocation">
<node CREATED="1306660940424" ID="ID_950074866" MODIFIED="1306788060348" TEXT="Global"/>
<node CREATED="1306660943440" ID="ID_1565705126" MODIFIED="1306788060348" TEXT="Texture/Constant"/>
</node>
<node CREATED="1306613333897" ID="ID_1588802465" MODIFIED="1307177651613" TEXT="GPUArrays">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1306613347809" ID="ID_661325531" MODIFIED="1307177615394" TEXT="Basic usage"/>
<node CREATED="1306613343649" ID="ID_236673371" MODIFIED="1307048308385" TEXT="Pros/Cons">
<node CREATED="1306614196557" ID="ID_771691688" MODIFIED="1307054883526" TEXT="Easy handling"/>
<node CREATED="1306614186796" ID="ID_58742051" MODIFIED="1306788060348" TEXT="Simple linear algebra"/>
<node CREATED="1307177623060" ID="ID_972140802" MODIFIED="1307177627869" TEXT="No custom elementwise"/>
</node>
</node>
</node>
<node CREATED="1306344385669" ID="ID_485062575" MODIFIED="1307219652866" TEXT="Design choices">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1306661210145" ID="ID_459702" MODIFIED="1307219671859" TEXT="Data layout">
<node CREATED="1306661273915" ID="ID_901134186" MODIFIED="1306788060349" TEXT="9 matrices accessed by first index">
<node CREATED="1306661404390" ID="ID_1288462327" MODIFIED="1306788060349" TEXT="Differs from matlab code"/>
<node CREATED="1306841537945" ID="ID_522343182" MODIFIED="1306841543456" TEXT="numpy.add.reduce"/>
</node>
<node CREATED="1306661379117" ID="ID_558729400" MODIFIED="1306788060349" TEXT="nx by ny matrices"/>
</node>
<node CREATED="1306655039389" ID="ID_238793524" MODIFIED="1307219671859" TEXT="NumPy Implementation">
<node CREATED="1306860104516" ID="ID_92178518" MODIFIED="1306860122589" TEXT="Differences with matlab version"/>
<node CREATED="1307139551279" ID="ID_1828491609" MODIFIED="1307139565599" TEXT="Wrapping via slicing"/>
<node CREATED="1307139565872" ID="ID_1107522141" MODIFIED="1307139584639" TEXT="Bounce back"/>
</node>
<node CREATED="1306359179009" ID="ID_845743183" MODIFIED="1307219671859" TEXT="PyCUDA Implementation">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1306357665471" ID="ID_589171550" MODIFIED="1307135770473" TEXT="Separation into blocks">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1306358499320" ID="ID_1870165178" MODIFIED="1307134942664" TEXT="Proposed lbm3d structure">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1306358557713" ID="ID_768287640" MODIFIED="1307103127890" TEXT="Linear index lbm3d">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node CREATED="1306359339681" ID="ID_489705390" MODIFIED="1307134942665" TEXT="Limitation of threads per block">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1306358485392" ID="ID_1192138329" MODIFIED="1307134969651" TEXT="Initial testing structure">
<font NAME="SansSerif" SIZE="12"/>
<icon BUILTIN="stop"/>
</node>
<node CREATED="1306358491496" ID="ID_609799021" MODIFIED="1307134942665" TEXT="Lbm2d structure">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1306358536001" ID="ID_1054287753" MODIFIED="1307103199662" TEXT="Linear index lbm2d">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node CREATED="1307117626558" ID="ID_1935836350" MODIFIED="1307117637348" TEXT="Calculating amount of blocks"/>
</node>
<node CREATED="1306359065911" ID="ID_457893012" MODIFIED="1307135775644" TEXT="Multiple kernels">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1306359071111" ID="ID_7169341" MODIFIED="1307134883854" TEXT="Propagate">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1306357646205" ID="ID_1815675642" MODIFIED="1306867452627" TEXT="Wrapping method">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1306358523769" ID="ID_954975820" MODIFIED="1306867451745" TEXT="Modulus">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1306358907284" ID="ID_1397143332" MODIFIED="1306788060350" TEXT="Modulus with negative integer in CUDA"/>
<node CREATED="1306502142332" ID="ID_1001057041" MODIFIED="1306788060350" TEXT="Slow integer division (cuda best practices)"/>
</node>
<node CREATED="1306358527001" ID="ID_322121" MODIFIED="1306788060350" TEXT="Conditional">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
</node>
<node CREATED="1306359077967" ID="ID_1415171003" MODIFIED="1306788060351" TEXT="Density">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1306359083720" ID="ID_1259171689" MODIFIED="1306788060351" TEXT="Equilibrium">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1306359089871" ID="ID_1010656415" MODIFIED="1306788060351" TEXT="Bounceback">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
</node>
</node>
<node CREATED="1306358952421" ID="ID_802949066" MODIFIED="1307219651987" TEXT="Correctness and accuracy">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1306654996109" ID="ID_186101834" MODIFIED="1306788060351" TEXT="Are the CPU and GPU versions the same"/>
<node CREATED="1306358959877" ID="ID_1876322110" MODIFIED="1306788060351" TEXT="Standard setup which produces same output">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1306358991118" ID="ID_845460870" MODIFIED="1306788060351" TEXT="Visual inspection">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1306613620078" ID="ID_1449861586" MODIFIED="1306788060352" TEXT="Floating point issue">
<font NAME="SansSerif" SIZE="12"/>
<icon BUILTIN="full-1"/>
</node>
</node>
<node CREATED="1306357865037" ID="ID_549201120" MODIFIED="1307219661954" TEXT="Optimization">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1306357888646" ID="ID_1376202006" MODIFIED="1306788060351" TEXT="Better memory strategy">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1306359044119" ID="ID_101241147" MODIFIED="1307219624156" TEXT="Further splitting into subproblems">
<font NAME="SansSerif" SIZE="12"/>
<icon BUILTIN="stop"/>
</node>
</node>
<node CREATED="1306613615414" ID="ID_302183263" MODIFIED="1307219662899" TEXT="Issues/Bugs">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1306357871885" ID="ID_1166356378" MODIFIED="1307173858493" TEXT="Block indexing bug">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
</node>
<node CREATED="1306358831602" FOLDED="true" ID="ID_1284435912" MODIFIED="1307463656277" POSITION="right" TEXT="Testing">
<font NAME="SansSerif" SIZE="12"/>
<icon BUILTIN="prepare"/>
<node CREATED="1306613662423" ID="ID_571752444" MODIFIED="1306788060352" TEXT="System description">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1306613467283" ID="ID_1762874017" MODIFIED="1307453554523" TEXT="Test design">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1306358884123" ID="ID_1844636981" MODIFIED="1306788060352" TEXT="Avoid initialization procedures in test">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1307453554855" ID="ID_1085405647" MODIFIED="1307453562873" TEXT="One scenario"/>
</node>
<node CREATED="1306358853082" ID="ID_1584880604" MODIFIED="1307454356016" TEXT="Timing">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1307454356017" ID="ID_57268725" MODIFIED="1307454359221" TEXT="NumPy"/>
<node CREATED="1307454360027" ID="ID_1962014199" MODIFIED="1307454361747" TEXT="PyCUDA"/>
</node>
<node CREATED="1307453537111" ID="ID_1132514713" MODIFIED="1307453539931" TEXT="Scenarios">
<node CREATED="1306613473075" ID="ID_262535277" MODIFIED="1306788060352" TEXT="Lid driven cavity">
<font NAME="SansSerif" SIZE="12"/>
<icon BUILTIN="full-2"/>
</node>
</node>
</node>
<node CREATED="1307463580447" ID="ID_765848449" MODIFIED="1307463678482" POSITION="right" TEXT="Results"/>
<node CREATED="1306788168084" ID="ID_929605920" MODIFIED="1306788170566" POSITION="right" TEXT="Conclusion"/>
<node CREATED="1306788175547" ID="ID_1067501729" MODIFIED="1307380535850" POSITION="right" TEXT="Appendix">
<node CREATED="1306788155227" ID="ID_1619002262" MODIFIED="1306788157900" TEXT="Code"/>
</node>
<node CREATED="1306358599851" ID="ID_1118231868" MODIFIED="1306919340842" POSITION="left" TEXT="References">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1306611388157" ID="ID_1198913889" MODIFIED="1306788060346" TEXT="CUDA Best Practices">
<font NAME="SansSerif" SIZE="12"/>
<icon BUILTIN="full-1"/>
</node>
<node CREATED="1306614910390" ID="ID_1617628631" MODIFIED="1306788060346" TEXT="CFD Online (Lid driven cavity)">
<font NAME="SansSerif" SIZE="12"/>
<icon BUILTIN="full-2"/>
</node>
</node>
</node>
</map>
