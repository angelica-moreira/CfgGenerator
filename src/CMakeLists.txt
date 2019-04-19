cmake_minimum_required (VERSION 3.0)

project (CFG_Generator)

find_package(LLVM REQUIRED CONFIG)

execute_process (COMMAND llvm-config --cxxflags --ldflags OUTPUT_VARIABLE LLVM_CONFIG_N)

include_directories(${LLVM_INCLUDE_DIRS})

string (REPLACE "\n" " " LLVM_CONFIG "${LLVM_CONFIG_N}")

set (CMAKE_CXX_FLAGS "-O3 -g ${LLVM_CONFIG} -undefined dynamic_lookup")

include_directories (include)
add_library (CfgGenerator SHARED
lib/CFG_Generator/CfgGenerator.cpp
)
