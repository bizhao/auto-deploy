#!/bin/bash

# Extract ESXi iso

rm -rf /tmp/mnt
mkdir /tmp/mnt
sudo mount -t iso9660 $1 /tmp/mnt

mkdir extract
cp -R /tmp/mnt/* extract/

touch build.ready
sudo umount /tmp/mnt
