#!/bin/bash
echo -------------------------------------------
echo "     Synchronize VC MIPI driver files"
echo -------------------------------------------

# set -u
# set -e

# include variable names
. jetson_vars.sh

set -x

# Modify the next files to add new MIPI modules:
cp Makefile              $JETSON_KERNEL_SOURCE/kernel/nvidia/drivers/media/i2c/
cp camera_common.c       $JETSON_KERNEL_SOURCE/kernel/nvidia/drivers/media/platform/tegra/camera/
cp sensor_common.c       $JETSON_KERNEL_SOURCE/kernel/nvidia/drivers/media/platform/tegra/camera/

cp vi5_formats.h         $JETSON_KERNEL_SOURCE/kernel/nvidia/drivers/media/platform/tegra/camera/vi/
cp vi5_fops.c            $JETSON_KERNEL_SOURCE/kernel/nvidia/drivers/media/platform/tegra/camera/vi/
cp csi4_fops.c           $JETSON_KERNEL_SOURCE/kernel/nvidia/drivers/media/platform/tegra/camera/csi/

cp j20.c                 $JETSON_KERNEL_SOURCE/kernel/nvidia/drivers/media/i2c/
cp imx296.c              $JETSON_KERNEL_SOURCE/kernel/nvidia/drivers/media/i2c/
cp vc_mipi.h             $JETSON_KERNEL_SOURCE/kernel/nvidia/drivers/media/i2c/

# Device-tree files:
cp tegra194-p2888-0001-p2822-0000.dts $JETSON_KERNEL_SOURCE/hardware/nvidia/platform/t19x/galen/kernel-dts/

cp j20.dtsi              $JETSON_KERNEL_SOURCE/hardware/nvidia/platform/t19x/common/kernel-dts/t19x-common-modules/
cp imx296.dtsi           $JETSON_KERNEL_SOURCE/hardware/nvidia/platform/t19x/common/kernel-dts/t19x-common-modules/
cp imx392.dtsi           $JETSON_KERNEL_SOURCE/hardware/nvidia/platform/t19x/common/kernel-dts/t19x-common-modules/