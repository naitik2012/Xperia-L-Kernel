#!/bin/bash
cd ../
cd out
echo " Hi! What you want to do "

echo " 1. Fastboot Flash Single Recovery Kernel "
echo " 2. Fastboot Flash Dual recovery Kernel "
echo " 3. Push SRK to /sdcard "
echo " 4. Push DRK to /sdcard "
echo " 5. Push Modules.zip to /sdcard "

read n
case $n in
        1) 
            echo " Flashing Single recovery kernel"
            unzip -qqo Kernel_Vengeance_TaoShan
            fastboot flash boot boot.img
            ;;
        2) 
            echo " Flashing Dual recovery kernel"
            unzip -qqo Kernel_Vengeance_TaoShan_Dual_Recovery
            fastboot flash boot boot.img
            ;;
        3)  
            echo " Pushing Single recovery kernel"
            adb push Kernel_Vengeance_TaoShan.zip /sdcard/  
            ;;
        4)  
            echo " Pushing Dual recovery kernel"
            adb push Kernel_Vengeance_TaoShan_Dual_Recovery.zip /sdcard/  
            ;;
 
        5)
            echo " Pushing modules to sdcard "
            adb push Modules.zip /sdcard/
            echo " Done! "
            ;;
        *) echo " Invalid option";;
    esac

