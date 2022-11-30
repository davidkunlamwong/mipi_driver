subdir-ccflags-y += -Werror -Wno-error=date-time -Wno-date-time

ccflags-y += -I$(srctree)/drivers/media/platform/tegra
ccflags-y += -I$(srctree)/drivers/video/tegra/camera

obj-$(CONFIG_VIDEO_LC898212) += lc898212.o
obj-$(CONFIG_VIDEO_OV5693) += ov5693.o

obj-$(CONFIG_VIDEO_OV9281) += imx296.o

obj-$(CONFIG_VIDEO_J20) += j20.o 
obj-$(CONFIG_VIDEO_OV10823) += ov10823.o
obj-$(CONFIG_VIDEO_OV23850) += ov23850.o
obj-$(CONFIG_I2C_IOEXPANDER_PCA9570) += pca9570.o
obj-$(CONFIG_VIDEO_TC358840) += tc358840.o
obj-$(CONFIG_I2C_IOEXPANDER_SER_MAX9295) += max9295.o
obj-$(CONFIG_I2C_IOEXPANDER_DESER_MAX9296) += max9296.o