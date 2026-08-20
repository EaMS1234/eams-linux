#!/bin/sh

LIMINE=limine-12.5.2
VERSION="v${LIMINE#limine-}"
PREFIX=$(pwd)/initrd

if [ ! -e initrd/bin/ ]; then
  mkdir initrd/bin/

fi

if [ ! -d $LIMINE ]; then
  if [ ! -e $LIMINE.tar.xz ]; then
    wget https://github.com/Limine-Bootloader/Limine/releases/download/$VERSION/$LIMINE.tar.xz
    ERROR=$?
    if [ ! $ERROR -eq 0 ]; then exit $ERROR; fi

  else
    echo "$LIMINE.tar.xz is already present"

  fi

  tar -xf $LIMINE.tar.xz
  rm $LIMINE.tar.xz

else
  echo "$LIMINE is already present"

fi

cd $LIMINE
./configure --enable-bios --enable-bios-cd --enable-uefi-x86-64 --enable-uefi-cd --prefix=/usr
make -j $(nproc --all) && make install DESTDIR=$PREFIX
cd ..

mkdir -p root/EFI/BOOT
cp $PREFIX/usr/share/limine/* root/boot/
mv root/boot/BOOTX64.EFI root/EFI/BOOT

