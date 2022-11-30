# Set Jetson variable names

# Target Jetson
export JETSON_USER=agxN
export JETSON_PASSWORD=agxN

# Host PC
export JETSON_MODEL=xavier
export JETSON_NAME=Xavier
export L4T_VERS=32.5.1
export JETPACK_VERS=4.5.1

export HOME_DIR=[path]/mipi_driver/AGX_32_5_1
export HOST_USER=[user_name]
export HOST_PASSWORD=[password]

export JETSON_DIR=$JETSON_MODEL\_$L4T_VERS
export CROSS_COMPILE=$HOME_DIR/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-
export JETSON_KERNEL_SOURCE=$HOME_DIR/$JETSON_DIR/Linux_for_Tegra/source/public
export L4T_DIR=$HOME_DIR/$JETSON_DIR/Linux_for_Tegra

export KERNEL_OUT=$JETSON_KERNEL_SOURCE/build
export KERNEL_MODULES_OUT=$JETSON_KERNEL_SOURCE/modules
export ARCH=arm64
export LOCALVERSION=-tegra
