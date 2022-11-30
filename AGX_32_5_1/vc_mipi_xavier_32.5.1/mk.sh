#!/bin/bash
# @echo off

#...... Include variable names
. jetson_vars.sh

echo ------------------------------------------------------------------
echo "   Compile Jetson $JETSON_NAME $L4T_VERS kernel on host Ubuntu-64"
echo "Usage:"
echo "   $0 [-c]"
echo "where:"
echo "   -c = Clean all before build"
echo -------------------------------------------------------------------

function pause(){
   read -p "$*"
}

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

echo ------ Make kernel Image
make -C kernel/kernel-4.9/  O=$KERNEL_OUT -j2 --output-sync=target Image
    if [[ $rc != 0 ]]; then exit $rc; fi
    # pause "Press Enter to continue"

cd $L4T_DIR

echo ------ Copying kernel files
echo $HOST_PASSWORD | sudo -S cp -rfv $JETSON_KERNEL_SOURCE/build/arch/arm64/boot/Image kernel/

echo "--- Exit ---"

