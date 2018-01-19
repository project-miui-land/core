#!/usr/bin/sh

echo "clearing output/boot.img"
test -f out/boot.img && rm -f out/boot.img || echo "nothing to clear"

# lets compile the kernel, modify accordingly
cd kernel
export KBUILD_BUILD_USER="build"
export KBUILD_BUILD_HOST="yourmachine"
export PATH=$PATH:$coredir/aarch64-linux-android-4.9/bin
make ARCH=arm64 SUBARCH=arm64 CROSS_COMPILE=aarch64-linux-android- land_defconfig
make ARCH=arm64 SUBARCH=arm64 CROSS_COMPILE=aarch64-linux-android- -j32

# lets now copy Image.gz-dtb to ramdisk
cp arch/arm64/boot/Image.gz-dtb $coredir/ramdisk/boot_extracted/

# done with kernel
cd $coredir

# now with the kernel, combine with ramdisk
cd ramdisk
echo "clearing out ramdisk/boot.img"
test -f boot.img && rm -f boot.img || echo "nothing to clear"
test -f boot_extracted/Image.gz-dtb && echo "Image.gz-dtb successfully compiled." || echo "Image.gz-dtb failed to compile"; exit

./mkboot boot_extracted boot.img

# now we got our boot.img, copy it for zipping
cd $coredir

echo "copying new boot.img to output dir"
mv ramdisk/boot.img out/boot.img
