#!/bin/bash

OTA_DIR=/ota

# Package initramfs cpio
cd initramfs
find . | cpio -o -H newc > ../boot/initramfs.cpio
# If use inird
#gzip initrd.cpio
cd ../

# Copy OS image to specific directory
IMAGE=`ls *img | tail -1`
mkdir -p $OTA_DIR
mv $IMAGE $OTA_DIR/

# Backup config.txt and cmdline.txt
cp /etc/fstab $OTA_DIR/
cp /boot/config.txt $OTA_DIR/
cp /boot/cmdline.txt $OTA_DIR/

# Copy cmdline and config.txt to load initramfs
cp boot/* /boot/

sync
echo "Prepare finished. Reboot to OTA firmware"
reboot
