# openthos在qemu上的自动测试
##用qemu-system-x86_64测试
###Live CD模式
```
qemu-system-x86_64 -enable-kvm -m 4G -cdrom android_x86.iso -vga std -serial stdio
```
###安装模式
参考[在QEMU上运行](http://www.android-x86.org/documents/qemuhowto)和[在virtualbox上运行](http://www.android-x86.org/documents/virtualboxhowto#Advanced)的官方文档，创建一个磁盘镜像
```
qemu-img create -f raw android.img 8G
qemu-system-x86_64 -enable-kvm -m 4G -cdrom android_x86.iso -vga std -serial stdio -hda android.img -boot d
```
进入debug mode  

1. "fdisk /dev/sda", then type:
 1. "n" (new partition)  
 2. "p" (primary partition)  
 3. "1" (1st partition)  
 4. "1" (first cylinder)  
 5. "xx" (choose the last cylinder, leaving room for a 2nd partition)  
 6. "w" (write the partition)  
2. Repeat #1, but call it partition 2, and use the remaining cylinders.
3. "mdev -s"  
4. "mke2fs -j -L DATA /dev/sda1"  
5. "mke2fs -j -L SDCARD /dev/sda2"  
6. Reboot ("reboot -f")  
7. 进入安装模式，安装在第一个分区，安装grub，但不要选择安装uefi  

安装完成后，关闭qemu，重新运行
```
qemu-system-x86_64 -enable-kvm -m 4G -vga std -serial stdio -hda android.img
```

###开机自动运行脚本
将img文件，挂载到系统上，在/system/etc/init.sh文件的return 0前面加入自动执行的语句即可。  

###自动拷贝文件脚本
见copy.sh  
`fdisk -l android.raw`  
查看扇区情况，假设第一个扇区的起点是63，计算出63×512=32256，要挂载到/home/cscw/mnt1，欲拷贝文件为kernel，拷贝到/home/cscw/mnt1/android-2016-02-29/kernel，则以如下命令执行脚本  
`./copy.sh android.raw 32256 /home/cscw/mnt1 kernel android-2016-02-29/kernel`

`kvm -m 4G -hda android-x86-6.0.1.raw -net nic -net user,hostfwd=tcp::12346-:5555`端口转发adb
