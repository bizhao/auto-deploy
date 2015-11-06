#!/bin/bash

# Extract ESXi iso

mkdir /tmp/iso_mount_point
fuseiso $1 /tmp/iso_mount_point

mkdir extract
cp -R /tmp/iso_mount_point/* extract/

touch build.ready
fusermount -u /tmp/iso_mount_point

# Create pxelinux.cfg folder and default file
mkdir extract/pxelinux.cfg
cd extract/pxelinux.cfg

filename=$1
VERSION_BUILD=${filename:25:13}

echo "DEFAULT menu.c32
MENU TITLE ESXi-${VERSION_BUILD}-full Boot Menu
NOHALT 1
PROMPT 0
TIMEOUT 80
LABEL install
 KERNEL mboot.c32
  APPEND -c boot.cfg
MENU LABEL ESXi-${VERSION_BUILD} ^Installer
LABEL hddboot
LOCALBOOT 0x80
MENU LABEL ^Boot from local disk
" > default

rm -rf /tmp/iso_mount_point
