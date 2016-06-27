#!/bin/sh
raw=/home/cscw/android-x86-6.0.raw
mount=/home/cscw/mnt1
result=/home/crdong/result
testcase=ebizzy
testarg=200%-4x-10s
host=kvm
rootfs=android
kconfig=android_x86
cc=gcc
kernel=6.0
no=0
export LKP_SRC=/home/cscw/lkp-tests-master

mount $raw -o loop,offset=32256 $mount
cp /home/cscw/ebizzy-0.3/ebizzy $mount/android-2016-02-29/data/
cp /home/cscw/init.sh $mount/android-2016-02-29/system/etc
umount $mount
kvm -m 4G $raw
mount $raw -o loop,offset=32256 $mount
cat $mount/android-2016-02-29/data/result | $LKP_SRC/stats/ebizzy > $testcase/$testarg/$host/$rootfs/$kconfig/$cc/$kernel/$no/ebizzy.time
umount $mount
