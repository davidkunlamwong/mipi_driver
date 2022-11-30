#!/bin/bash
# @echo off

#...... Include variable names
. jetson_vars.sh

echo ---------------------------------------------------------------------
echo "   Build Jetson $JETSON_NAME $L4T_VERS device tree on host Ubuntu-64"
echo "Usage:"
echo "   $0"
echo ---------------------------------------------------------------------

function pause(){
   read -p "$*"
}

# set -x
# set -u
# set -e

rc=$?


cd $JETSON_KERNEL_SOURCE

echo ------ Config by tegra_defconfig
make -C kernel/kernel-4.9/  O=$KERNEL_OUT tegra_defconfig
    if [[ $rc != 0 ]]; then exit $rc; fi
    # pause "Press Enter to continue"

echo ------ Make dtbs
make -C kernel/kernel-4.9/  O=$KERNEL_OUT  dtbs
    if [[ $rc != 0 ]]; then exit $rc; fi
#    pause "Press Enter to continue"

cd $L4T_DIR

echo ------ Copy your dtb files ...
echo $HOST_PASSWORD | sudo -S cp -rfv $JETSON_KERNEL_SOURCE/build/arch/arm64/boot/dts/*.dtb kernel/dtb/

echo "--- Exit ---"