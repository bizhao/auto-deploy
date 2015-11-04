#!/bin/bash

SRC=/tmp/tftp_config
echo TFTP_USERNAME="\"tftp\"" > $SRC
echo TFTP_DIRECTORY="\"/builds/esxi/${esxi_build}/extract\"" >> $SRC
echo TFTP_ADDRESS="\"[::]:69\"" >> $SRC
echo TFTP_OPTIONS="\"--secure --verbose\"" >> $SRC

cp $SRC /etc/default/tftpd-hpa
service tftpd-hpa restart

for host in $target_hosts; do
    echo PXE-booting host $host
    ipmitool -I lan -H $host -U $ilo_username -P $ilo_password chassis bootdev pxe
    ipmitool -I lan -H $host -U $ilo_username -P $ilo_password power reset
    sleep 120
    echo "Wait 120 seconds to start the next host installation"
done

echo "Wait 480 seconds to let the installation finishes."
sleep 480
