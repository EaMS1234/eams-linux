#!/bin/bash

LIMINE=limine-12.5.2

[[ $LIMINE =~ ^limine-(.*)$ ]]
VERSION="v${BASH_REMATCH[1]}"

if [ ! -e initrd/bin/ ]; then
  mkdir initrd/bin/

fi

if [ ! -d $LIMINE ]; then
  if [ ! -e $LIMINE.tar.xz ]; then
    wget https://github.com/Limine-Bootloader/Limine/releases/download/$VERSION/$LIMINE.tar.xz

  else
    echo "$LIMINE.tar.xz is already present"

  fi

  tar -xf $LIMINE.tar.xz
  rm $LIMINE.tar.xz

else
  echo "$LIMINE is already present"

fi

cd $LIMINE
./configure --enable-bios --enable-bios-cd --prefix=$(pwd)/../initrd/
make -j $(nproc --all) CC=musl-gcc && make install
cd ..

cp initrd/share/limine/* root/boot/

