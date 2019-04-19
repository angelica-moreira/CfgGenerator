#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 [Path] [Program]";
  exit 1;
fi

dir=$1;
if [ ! -d "$dir" ]; then
  echo "Invalid path: ${dir}";
  exit 1;
fi

script_path="$( cd "$(dirname "$0")" ; pwd -P )"
dynamic_lib_path="$(dirname "$script_path")"

program=${2%.*}

program_ll=${program}.ll
program_cpp=${program}.cpp
program_instr_ll=${program}-instr.ll
cfg_generator=${dynamic_lib_path}/build/libCfgGenerator.dylib

#emitts
clang++ -Xclang -disable-O0-optnone -S -emit-llvm -o $program_ll $program_cpp
#
opt -mem2reg $program_ll -o $program_ll
opt -load $cfg_generator -cfg-generator -debug-only=CfgGenerator -o=$program_instr_ll <  $program_ll
#compiles
#clang++ -o $program $program_instr_ll

#creates a directory that will be the respository for the profile result files
#directory_name=${program}_results
#if [ ! -d "$directory_name" ]; then
#  mkdir -p $directory_name
#fi

#in case the static profile result file exists move it to the correct directory
#static_profile_file=static.csv
#if [ -f $static_profile_file ]; then
#  mv $static_profile_file $directory_name
#fi

#executes
./$program 1 10 3 6

#in case the dynamic profile result file exists move it to the correct directory
#dynamic_profile_file=prof.csv
#if [ -f $dynamic_profile_file ]; then
#  mv $dynamic_profile_file $directory_name
#fi
