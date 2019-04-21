
DCC888 - First Project - Bytecodes to dot file
Students: Angélica Moreira (2018718236) & Pedro Barbosa (2014015958)

------------------
Compiling the pass
------------------

The Makefile for this pass should be generated using CMake. We provide the CMakeLists.txt file within. 

To generate a Makefile, execute the build.sh script which is inside the folder that contains the source code of the this 
first project, which is TP1/CfgGenerator/src, indicating the root path where your llvm is installed, as follows:

./build.sh path/to/llvm # you should run this command inside the folder src

This script will execute the following comand: cmake -DBUILD_SHARED_LIBS=ON $LLVM_BUILD_DIR ..

After that the Makefile should be generated and the shared library can be built by simply running a "make" command, which is
being executed in our build.sh script as folllows: make -j8
 
After running the build.sh it  will also generate a build folder and inside a shared library called [libCfgGenerator], which is our compiled pass. 
Pay attention that this library may have either the extension .dylib (if your OS is MacOS) or .so (if your OS is linux). 

--------------------------------
Running the pass on a given file
--------------------------------

To run our pass on a .cpp or .c file, execute the execute.sh script (which is inside the TP1/CfgGenerator/src folder), passing the path to the file, as follows:

./execute.sh [path/to/file.cpp or path/to/file.c]

The execute.sh script will execute the following comands:

clang++ -Xclang -disable-O0-optnone -S -emit-llvm -o $program_ll $program_file
opt -mem2reg $program_ll -o $program_ll
opt -load $cfg_generator -cfg-generator -debug-only=CfgGenerator -o=$program_ll < $program_ll

After that, you should be able to see the dot files generated inside the folder dot_files in the same folder of the execute.sh script.
Pay attention that a folder with the name of the program being analysed will be created inside the folder dot_files and all the dot files
generated for this program will be inside this folder. Those files can be visualized if you have installed the graphviz tool but if you
don't you can convert it by executing the following comamnd: dot -Tpdf [file_name].dot -o [file_name].pdf.

Obs.: The example program of the first project description is inside the folder TP1/CfgGenerator/src/TestFiles/Test and the benchmarks 
are inside the folder TP1/CfgGenerator/src/TestFiles/standford

Obs2.: The source code of our pass is inside the folder TP1/CfgGenerator/src/lib/CFG_Generator and it was registered 
with the name: cfg-generator.
