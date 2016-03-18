#!/bin/bash -x



ip_linux="192.168.2.16"
ip_android="192.168.2.34"

# ./my_android_x86_iso_install.sh  $android_ip
# ./my_android_x86_uefi_install.sh  $android_ip
# ./my_fastboot.sh $android_ip  reboot 

./android_tool.sh ${ip_linux} android_x86_uefi_install.sh


################
##通过source即可以，包含IP进来
##source ./ENVIR.sh
###下面就是根据实际情况编写了

#######通过web 上传测试用例还有测试材料。

./android_tool.sh ${ip_linux} android_x86_iso_install.sh
./android_tool.sh ${ip_linux} fastboot.sh reboot

##test ip  reacheable
sleep 120
####pause press anykey to continue


./adb connect ${ip_android}



./adb install ./fndxn2_yoyou.com.apk
./adb install ./net.jishigou.t2.8.0.pak
./adb shell am start -n net.jishigou.t/net.jishigou.t.StartActivity
#./adb push  ./xxx/x   /x/x/x/
#./adb shell /x/x/x/x
#mkdir ./test_result
#./adb pull  ./xxx/*  ./test_result

#tar zcvf ./test_result ./test_result.tar.gz  #通过web下载测试用例。
#rm -rf ./test_result


./adb reboot












