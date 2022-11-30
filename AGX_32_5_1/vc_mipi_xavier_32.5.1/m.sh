#!/bin/bash
# @echo off

#...... Include variable names
. jetson_vars.sh

echo ---------------------------------------------------------------
echo " Build Jetson $JETSON_NAME $L4T_VERS kernel on host Ubuntu-64"
echo "Usage:"
echo "   $0 [-c]"
echo "where:"
echo "   -c = Clean all before build"
echo ---------------------------------------------------------------

function pause(){
   read -p "$*"
}

# BASH_VAR="Bash Script"
# echo $BASH_VAR

# set -x
# set -u
# set -e

rc=$?

cd $JETSON_KERNEL_SOURCE

# Cleaning is done on three levels.
# make clean     Delete most generated files
#                Leave enough to build external modules
# make mrproper  Delete the current configuration, and all generated files
# make distclean Remove editor backup files, patch leftover files and the like

if [ "$1" == "-c" ]
then
echo ------ Clean all before build
# make -C kernel/kernel-4.9/ clean
make -C kernel/kernel-4.9/ mrproper
pause "Press Enter to continue"
fi

echo ------ Config by tegra_defconfig
make -C kernel/kernel-4.9/  O=$KERNEL_OUT tegra_defconfig
    if [[ $rc != 0 ]]; then exit $rc; fi
    # pause "Press Enter to continue"

#echo ------ Menuconfig
#make -C kernel/kernel-4.9/  O=$KERNEL_OUT menuconfig # if is required to change the default configuration
#    if [[ $rc != 0 ]]; then exit $rc; fi
##   pause "Press Enter to continue" 

echo ------ Make kernel Image
make -C kernel/kernel-4.9/  O=$KERNEL_OUT -j2 --output-sync=target Image
    if [[ $rc != 0 ]]; then exit $rc; fi
    # pause "Press Enter to continue"

echo ------ Make dtbs
make -C kernel/kernel-4.9/  O=$KERNEL_OUT  --output-sync=target dtbs
    if [[ $rc != 0 ]]; then exit $rc; fi
    # pause "Press Enter to continue"

echo ------ Make modules
make -C kernel/kernel-4.9/  O=$KERNEL_OUT -j2 --output-sync=target modules
    if [[ $rc != 0 ]]; then exit $rc; fi
    # pause "Press Enter to continue"

echo ------ Make modules_istall
make -C kernel/kernel-4.9/  O=$KERNEL_OUT INSTALL_MOD_PATH=$KERNEL_MODULES_OUT modules_install 
    if [[ $rc != 0 ]]; then exit $rc; fi
    # pause "Press Enter to continue"
    
#echo ------ nvbuild
#export CROSS_COMPILE_AARCH64_PATH=$HOME_DIR/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu
#./nvbuild.sh -o $KERNEL_OUT


echo ------ Copying files
cd $L4T_DIR

# Copy kernel generated
echo ------ Copy kernel image file ...
echo $HOST_PASSWORD | sudo -S cp -rfv $JETSON_KERNEL_SOURCE/build/arch/arm64/boot/Image kernel/

# Copy device tree generated
echo ------ Copy dtb files ...
# echo sudo cp $JETSON_KERNEL_SOURCE/build/arch/arm64/boot/dts/*.dtb kernel/dtb/
echo $HOST_PASSWORD | sudo -S cp -rfv $JETSON_KERNEL_SOURCE/build/arch/arm64/boot/dts/*.dtb kernel/dtb/

echo --------- Copy new modules
echo $HOST_PASSWORD | sudo -S cp -arfv  $JETSON_KERNEL_SOURCE/modules/lib rootfs/
# echo $HOST_PASSWORD | sudo -S chown -R root:root rootfs

echo --------- Apply binaries in root FS
echo $HOST_PASSWORD | sudo -S ./apply_binaries.sh

echo "------ Exit ------"

