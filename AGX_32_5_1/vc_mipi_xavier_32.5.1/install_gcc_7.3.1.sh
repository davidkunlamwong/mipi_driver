#!/bin/bash

#...... Include variable names
. jetson_vars.sh

echo ------------------------------------------------------------------------------
echo Download and install GCC Linaro 7.3.1 cross-compiler for 64 bit BSP and Kernel 
echo ------------------------------------------------------------------------------

if [ ! -d "$HOME_DIR" ]; then
mkdir $HOME_DIR
fi

cd $HOME_DIR

wget https://developer.nvidia.com/embedded/dlc/l4t-gcc-7-3-1-toolchain-64-bit -O gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu.tar.xz
tar -xvf gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu.tar.xz 