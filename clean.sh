PATH=/home/rachit/android/toolchains/google/bin:$PATH

export PATH

#Build kernel
ARCH=arm CROSS_COMPILE=arm-linux-androideabi- make distclean
cd ../
cd prima_legacy
./clean.sh

