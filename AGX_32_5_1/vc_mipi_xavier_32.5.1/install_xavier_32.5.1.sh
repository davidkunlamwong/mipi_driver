#!/bin/bash

. jetson_vars.sh

echo ----------------------------------------------------------------------------
echo Install Jetson $JETSON_NAME $L4T_VERS kernel files in $HOME_DIR/$JETSON_DIR
echo ----------------------------------------------------------------------------

function pause(){
   read -p "$*"
}
 
echo "You must have downloaded the kernel installation files to $HOME_DIR/$JETSON_DIR"
pause "Press Enter to continue ..."

cd $HOME_DIR/$JETSON_DIR

echo "Install L4T Driver Package (BSP) - Jetpack $JETPACK_VERS"
tar -xvf tegra186_linux_r32.5.1_aarch64.tbz2

echo "Install Sample Root Filesystem"
echo $HOST_PASSWORD | sudo -S tar -xvf tegra_linux_sample-root-filesystem_r32.5.1_aarch64.tbz2 -C Linux_for_Tegra/rootfs

echo "Install L4T Driver Package (BSP) Sources - L4T $L4T_VERS kernel files"
tar -xvf public_sources.tbz2
cd Linux_for_Tegra/source/public
tar -xvf kernel_src.tbz2