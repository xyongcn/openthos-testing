#!/bin/sh
iso=/mnt/freenas/OTO/work/out/target/product/x86_64/android_x86_64-5.1.iso
raw=/mnt/freenas/android-x86.raw
mount=/mnt/freenas/mnt2
result=/home/crdong/result
testcase=ebizzy
testarg=200%-4x-10s
host=kvm
rootfs=android
kconfig=android_x86
cc=gcc
kernel=6.0
no=0
export LKP_SRC=/home/crdong/lkp-tests

#./compile.sh
./autoTest.sh v install localhost $raw "-p android.acceleration --disable-reboot" $iso
mount $raw -o loop,offset=32256 $mount
cp /home/crdong/ebizzy $mount/android*/data/
sed -i '/return 0/i/data/ebizzy > /data/result\npoweroff' $mount/android*/system/etc/init.sh
umount $mount
kvm -m 4G $raw
mount $raw -o loop,offset=32256 $mount
mkdir -p $result/$testcase/$testarg/$host/$rootfs/$kconfig/$cc/$kernel/$no
cat $mount/android*/data/result | $LKP_SRC/stats/ebizzy > $result/$testcase/$testarg/$host/$rootfs/$kconfig/$cc/$kernel/$no/ebizzy.time
umount $mount
