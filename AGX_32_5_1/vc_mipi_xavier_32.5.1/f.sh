#!/bin/bash
# @echo off

#...... Include variable names
. jetson_vars.sh


echo ------------------------------------------------------------------
echo "   Flash Jetson $JETSON_NAME $L4T_VERS kernel, DTB and root FS"
echo ------------------------------------------------------------------

function pause(){
   read -p "$*"
}

rc=$?

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
     
# Flash kernel, DTB and file system (complete flash)
# pause "----- Press Enter to start flashing ..." 

if [ "$JETSON_MODEL" == "xavier" ]
then
echo ------ Flashing Xavier ...
echo $HOST_PASSWORD | sudo -S ./flash.sh jetson-xavier mmcblk0p1
fi

echo --- Exit ---
