#!/bin/bash

#...... Include variable names
. jetson_vars.sh

ip=192.168.0.154
if [ "$1" != "" ]; then ip=$1; fi
echo ip=$ip

echo ---------------------------------------------------------------
echo "   Flash (copy) Jetson $JETSON_NAME $L4T_VERS kernel image"
echo "Usage:"
echo "   $0 [ip]"
echo "where:"
echo "   ip = Jetson $JETSON_NAME IP address: $ip"
echo ---------------------------------------------------------------

function pause(){
   read -p "$*"
}

# set -x
# set -u
# set -e

rc=$?


echo Copying $L4T_DIR/kernel/Image to $JETSON_NAME /boot ...

sshpass -p $JETSON_PASSWORD scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $L4T_DIR/kernel/Image  $JETSON_USER@$ip:/home/$JETSON_USER
if [[ $rc != 0 ]]; then exit $rc; fi
echo "------ Success ------"

sshpass -p $JETSON_PASSWORD ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $JETSON_USER@$ip "echo $JETSON_PASSWORD | sudo -S cp Image /boot"
if [[ $rc != 0 ]]; then exit $rc; fi

echo ""
echo "------ Success ------"