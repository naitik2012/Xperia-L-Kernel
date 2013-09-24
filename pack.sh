#Kernel Pack Script
#Rachit Rawat- XDA
cd ../

if test -d out
then
echo " Working directory found! \n "
echo " Cleaning working directory \n "
rm -rf out/*
else 
echo " Working directory not found! Creating it \n"
mkdir out
fi

echo " Getting compiled modules \n"
rm -rf meta/system/lib/modules/*
cd meta/system/lib/modules
mkdir prima
cd ../../../../
cp prima_legacy/wlan.ko meta/system/lib/modules/prima/prima_wlan.ko
find /home/rachit/android/taoshan/kernel -name '*ko' -exec cp '{}' meta/system/lib/modules \;
    mv meta/system/lib/modules/cfg80211.ko meta/system/lib/modules/prima/cfg80211.ko
   # mv Modules/system/lib/modules/wlan.ko Modules/system/lib/modules/prima/prima_wlan.ko

# Make Ramdisks
echo " Creating ramdisk \n "
cd ramdisk
find ./ | cpio --quiet -H newc -o > ../ramdisk.cpio
xz -qe ../ramdisk.cpio
cd ../
cp ramdisk.cpio.xz ramdisks/sbin/ramdisk.cpio.xz
#cp ramdisk.cpio.xz ramdiskd/sbin/ramdisk.cpio.xz
rm ramdisk.cpio.xz
cd recovery-cwm
find ./ | cpio --quiet -H newc -o > ../recovery-cwm.cpio
xz -qe ../recovery-cwm.cpio
cd ../
cp recovery-cwm.cpio.xz ramdisks/sbin/recovery-cwm.cpio.xz
#cp recovery-cwm.cpio.xz ramdiskd/sbin/recovery-cwm.cpio.xz
rm recovery-cwm.cpio.xz
#cd recovery-twrp
#find ./ | cpio --quiet -H newc -o > ../recovery-twrp.cpio
#xz -qe ../recovery-twrp.cpio
#cd ../
#cp recovery-twrp.cpio.xz ramdiskd/sbin/recovery-twrp.cpio.xz
#rm recovery-twrp.cpio.xz

# Make Single recovery RAMDISK
cd ramdisks
find . | cpio --quiet -o -H newc | lzma -qe > ../ramdisk.img

cd ../

# Make boot img
echo " Making Single Recovery kernel \n "
mkbootimg --base 0x80200000 --kernel kernel/arch/arm/boot/zImage --ramdisk_offset 0x02000000 --cmdline "console=ttyHSL0,115200,n8 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x3F ehci-hcd.park=3" --ramdisk ramdisk.img --pagesize 4096 -o boot.img

#Zip boot.img
mv boot.img meta/
cd meta
zip -9rq Kernel_Vengeance_TaoShan.zip *
mv Kernel_Vengeance_TaoShan.zip ../out/
cd ../

# Make Dual recovery RAMDISK
#cd ramdiskd
#find . | cpio --quiet -o -H newc | lzma -qe > ../ramdisk.img

#cd ../

# Make boot img
#echo " Making Dual Recovery kernel \n "
#mkbootimg --base 0x80200000 --kernel kernel/arch/arm/boot/zImage --ramdisk_offset 0x02000000 --cmdline "console=ttyHSL0,115200,n8 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x3F ehci-hcd.park=3" --ramdisk ramdisk.img --pagesize 4096 -o boot.img

# zip boot img
#mv boot.img meta/
#cd meta
#zip -9rq Kernel_Vengeance_TaoShan_Dual_Recovery.zip *
#mv Kernel_Vengeance_TaoShan_Dual_Recovery.zip ../out/
#rm boot.img
#cd ../
rm ramdisk.img

echo " Done! Files placed in out directory."

