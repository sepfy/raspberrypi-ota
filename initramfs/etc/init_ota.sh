#!/bin/sh

ROOTFS_DIR=/mnt/roofs
BOOT_DIR=/mnt/boot
OTA_DIR=$ROOTFS_DIR/ota
OTA_ROOTFS_DIR=$ROOTFS_DIR/ota/rootfs/
OTA_BOOT_DIR=$ROOTFS_DIR/ota/boot/

ota_mount_image() {

  echo "Mount SD card image"
  mkdir -p $ROOTFS_DIR
  mkdir -p $BOOT_DIR
  mount /dev/mmcblk0p1 $BOOT_DIR
  mount /dev/mmcblk0p2 $ROOTFS_DIR

  echo "Mount new OS image file"
  cd $OTA_DIR
  mkdir -p rootfs
  mkdir -p boot
  IMAGE=`ls *img | tail -1`
  losetup -P /dev/loop0 $IMAGE
  mount /dev/loop0p1 $OTA_BOOT_DIR
  mount /dev/loop0p2 $OTA_ROOTFS_DIR

}

ota_update_rootfs() {

  echo "Update rootfs partition"

  cd $ROOTFS_DIR

  # Remove original file system except OTA folder
  for d in * ; do
    if [ $d != "ota" ]
    then
      rm -rf $d
    fi
  done 

  # Copy new file system
  cp -rp $OTA_ROOTFS_DIR/* $ROOTFS_DIR/

  # Copy origin fstab for mounting SD card
  cp -rp $OTA_DIR/fstab $ROOTFS_DIR/etc/

}

ota_update_boot() {

  echo "Update boot partition"

  cd $BOOT_DIR

  # Remove original boot files
  rm -rf *

  # Copy new boot files
  cp -rp $OTA_BOOT_DIR/* $BOOT_DIR/

  # Copy origin cmdline.txt and config.txt
  cp -rp $OTA_DIR/cmdline.txt $BOOT_DIR/
  cp -rp $OTA_DIR/config.txt $BOOT_DIR/

}


ota_finished() {

  sync

  echo "Update finished"

  for i in 5 4 3 2 1
  do
    echo "Reboot after $i second !!!"
    #echo -en "Update finished. Reboot after $i second !!!\r"
    sleep 1
  done
  reboot -f

}

main() {
  sleep 3
  echo "Start to Update OS image!!! Do not poweroff"
  ota_mount_image
  ota_update_rootfs
  ota_update_boot
  ota_finished
}

main &

