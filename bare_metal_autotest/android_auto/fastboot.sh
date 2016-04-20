#!/bin/bash -x
###################### 
#
#fastboot.sh
#####################
cd  ~/android_auto


mkdir ./android_disk
umount ./android_disk
#mount /dev/{sda3}   ./android_disk
mount /dev/sda4   ./android_disk

#mkdir  ./android_disk/{android-2016-02-29}/
mkdir  ./android_disk/android-2016-02-29/
mkdir -p ./android_disk/android-2016-02-29/system
mkdir -p ./android_disk/android-2016-02-29/data

echo $1
sleep 2
if [ "$1" = "flashall" ]
then
cp  ./kernel        ./android_disk/android-2016-02-29/kernel
cp  ./initrd.img    ./android_disk/android-2016-02-29/initrd.img
cp  ./ramdisk.img   ./android_disk/android-2016-02-29/ramdisk.img

mkdir   ./system_tmp
sleep 2
umount ./system_tmp
mount ./system.img ./system_tmp
rm -rf ./android_disk/android-2016-02-29/system/*
cp   -Ra ./system_tmp/*   ./android_disk/android-2016-02-29/system
umount ./system_tmp
fi


if [ "$1" = "kernel" ]
then
cp  ./kernel        ./android_disk/android-2016-02-29/kernel
fi



if [ "$1" = "initrd" ]
then
cp  ./initrd.img    ./android_disk/android-2016-02-29/initrd.img
fi



if [ "$1" = "ramdisk" ]
then
cp  ./ramdisk.img   ./android_disk/android-2016-02-29/ramdisk.img
fi



if [ "$1" = "system" ]
then
mkdir   ./system_tmp
umount ./system_tmp
mount ./system.img ./system_tmp
rm -rf ./android_disk/android-2016-02-29/system/*
cp   -Ra ./system_tmp/*   ./android_disk/android-2016-02-29/system
umount ./system_tmp
fi



if [ "$1" = "reboot" ]
then
#efibootmgr -n {4}
efibootmgr -n 1
reboot
fi



if [ "$1" = "reboot-bootloader" ]
then
reboot
fi
