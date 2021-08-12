#!/bin/bash

#before run this. you must delete /src/formats.c line 476 #error

#configure ndk path
#edit here
export NDK=/C/Users/username/AppData/Local/Android/Sdk/ndk/22.1.7171670

#configure api level
#edit here
API=28

#if windows case, this script should run in msys2 environment
#edit here windows or linux
PLATFORM=windows

TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$PLATFORM-x86_64
SYSROOT=$NDK/toolchains/llvm/prebuilt/$PLATFORM-x86_64/sysroot

CPUS=(arm64-v8a armeabi-v7a x86_64 x86)
HOSTS=(aarch64-linux-android armv7a-linux-androideabi x86_64-linux-android i686-linux-android)

for i in $(seq 0 3)
do

CPU=${CPUS[$i]}
HOST=${HOSTS[$i]}
PREFIX=$(pwd)/build/android
export CC=$TOOLCHAIN/bin/$HOST$API-clang

./configure \
--prefix=$PREFIX/$CPU \
--with-sysroot=$SYSROOT \
--host=$HOST \
--includedir=$PREFIX/include \
--libdir=$PREFIX/$CPU \

make -j 10 && make install
make clean

done