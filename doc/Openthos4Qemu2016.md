# openthos在qemu上的自动测试
##用qemu-system-x86_64测试
###Live CD模式
```
qemu-system-x86_64 -enable-kvm -m 4G -cdrom android_x86.iso -vga std -serial stdio
```
###安装模式
参考[在QEMU上运行](http://www.android-x86.org/documents/qemuhowto)和[在virtualbox上运行](http://www.android-x86.org/documents/virtualboxhowto#Advanced)的官方文档，创建一个磁盘镜像
```
qemu-img create -f qcow2 android.img 8G
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
