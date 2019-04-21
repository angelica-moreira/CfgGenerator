
DCC888 - First Project - Bytecodes to dot file
Students: Angélica Moreira (2018718236) & Pedro Barbosa (2014015958)

------------------
Compiling the pass
------------------

The Makefile for this pass should be generated using CMake. We provide the CMakeLists.txt file within. 

To generate a Makefile, execute the build.sh script which it is inside the folder that contains the source code of the this 
first project, which is TP1/CfgGenerator/src,  indicating the root path where your llvm is installed, as follows:

./build.sh path/to/llvm # you should run this command inside the folder src

This script will execute the following comand: cmake -DBUILD_SHARED_LIBS=ON $LLVM_BUILD_DIR ..

After that the Makefile should be generated and the and the shared library can be built by simply running "make" command. 
This will also generate a build folder and inside a shared library called [libCfgGenerator], which is our compiled pass. 
Pay attention that this library may have either the extension dylib (if your SO is MacOS) or so (if your SO is linux). 

------------------------------------
Running the pass on a given cpp file
------------------------------------

To run our pass on a .cpp or .c file, execute the src/execute.sh script, passing the path to the .cpp .c file, as follows:

./src/testFiles/execute.sh path/to/file.cpp

The execute.sh script will execute the following comands:

clang++ -Xclang -disable-O0-optnone -S -emit-llvm -o $program_ll $program_file
opt -mem2reg $program_ll -o $program_ll
opt -load $cfg_generator -cfg-generator -debug-only=CfgGenerator -o=$program_ll < $program_ll

After that, you should be able to see the dot files generated inside the folder dot_files in the same folder of the execute.sh script.
Pay attention that a folder with the name of the program being analysed will be created inside the folder do_files and all the dot files
generated for this program will be inside this folder. Those files can be visualized if you have installed the graphviz tool but if you
don't you can convert it buy executing the following comamnd: dot -Tpdf [file_name].dot -o [file_name].pdf.
