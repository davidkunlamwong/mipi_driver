#!/bin/bash
# @echo off

#...... Include variable names
. jetson_vars.sh

echo ------------------------------------------------------------------
echo "   Flash Jetson $JETSON_NAME $L4T_VERS device tree"
echo "Usage:"
echo "   $0"
echo ------------------------------------------------------------------  


function pause(){
   read -p "$*"
}

# Make sure Jetson is in recovery mode
echo Power off Jetson $JETSON_NAME and enter recovery mode.
echo The Jetson board should be connected to the host computer via USB,
echo "check for reset/recovery mode by:"
echo "   lsusb"
echo "You should see something NVidia USB device, for example:"
echo "   Bus 001 Device 002: ID 0955:7c18 NVidia Corp."
echo " " 
   
echo cd $L4T_DIR     
     cd $L4T_DIR     
echo lsusb
     lsusb

# pause "----- Press Enter to start DTB flashing ..."

if [ "$JETSON_MODEL" == "xavier" ]
then
echo ------ Flashing Xavier DTB ...
# echo $HOST_PASSWORD | sudo -S ./flash.sh -r -k kernel-dtb jetson-xavier mmcblk0p1
echo $HOST_PASSWORD | sudo -S ./flash.sh -k kernel-dtb jetson-xavier mmcblk0p1
fi

# pause "Press Enter to exit"
echo --- Exit ---
