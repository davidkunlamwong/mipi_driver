#!/bin/bash

. jetson_vars.sh

echo -----------------------------------------------------------------------------
echo Download Jetson $JETSON_NAME $L4T_VERS kernel files to $HOME_DIR/$JETSON_DIR
echo -----------------------------------------------------------------------------

if [ ! -d "$HOME_DIR" ]; then
mkdir $HOME_DIR
fi

cd $HOME_DIR
mkdir $JETSON_DIR

cd $JETSON_DIR

echo "Get L4T Driver Package (BSP)(Jetpack $JETPACK_VERS)"
wget https://developer.nvidia.com/embedded/l4t/r32_release_v5.1/r32_release_v5.1/t186/tegra186_linux_r32.5.1_aarch64.tbz2

echo "Get Sample Root Filesystem"
wget https://developer.nvidia.com/embedded/l4t/r32_release_v5.1/r32_release_v5.1/t186/tegra_linux_sample-root-filesystem_r32.5.1_aarch64.tbz2

echo "Get L4T Driver Package (BSP) Sources (L4T 32.2 kernel files)"
wget https://developer.nvidia.com/embedded/l4t/r32_release_v5.1/r32_release_v5.1/sources/t186/public_sources.tbz2


