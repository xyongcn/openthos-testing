#! /bin/bash
ntpdate cn.ntp.org.cn
cd /mnt/freenas/OTO/work
source build/envsetup.sh
lunch android_x86_64-eng
make iso_img -j4 > report
mv /mnt/freenas/OTO/work/out/target/product/x86_64/android_x86_64.iso /mnt/freenas/OTO/work/out/target/product/x86_64/android_x86_64-5.1.iso
