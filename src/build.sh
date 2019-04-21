#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 [Path]";
  exit 1;
fi

dir=$1;
if [ ! -d "$dir" ]; then
  echo "Invalid path: ${dir}";
  exit 1;
fi

# the llvm build folder
export LLVM_BUILD_DIR=${dir}/build
# the cmake folder inside the build folder
export LLVM_DIR=$LLVM_BUILD_DIR/lib/cmake

rm -rf build
mkdir build
cd build 
cmake -DBUILD_SHARED_LIBS=ON $LLVM_BUILD_DIR ..
make -j8


