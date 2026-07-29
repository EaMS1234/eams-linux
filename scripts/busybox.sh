#!/bin/bash

BUSYBOX=busybox-1.38.0

if [ ! -e initrd/bin/ ]; then
  mkdir initrd/bin/

fi

if [ ! -d $BUSYBOX ]; then
  if [ ! -e $BUSYBOX.tar.bz2 ]; then
    wget https://busybox.net/downloads/$BUSYBOX.tar.bz2

  else
    echo "$BUSYBOX.tar.bz2 is already present"

  fi

  tar -xf $BUSYBOX.tar.bz2

else
  echo "$BUSYBOX is already present"

fi

cd $BUSYBOX
cp ../config/busybox.config ./.config
make -j $(nproc --all) CC=musl-gcc
cp busybox ../initrd/bin/
cd ..

for item in $(initrd/bin/busybox --list); do
    ln -rs initrd/bin/busybox initrd/bin/$item
done
ln -rs initrd/bin/busybox initrd/init
chmod +x initrd/bin/*
chmod +x initrd/init

