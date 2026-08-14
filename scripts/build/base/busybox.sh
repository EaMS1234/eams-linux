#!/bin/sh

BUSYBOX=busybox-1.38.0
PREFIX=$(pwd)/initrd

if [ ! -d $BUSYBOX ]; then
  if [ ! -e $BUSYBOX.tar.bz2 ]; then
    wget https://busybox.net/downloads/$BUSYBOX.tar.bz2
    ERROR=$?
    if [ ! $ERROR -eq 0 ]; then exit $ERROR; fi

  else
    echo "$BUSYBOX.tar.bz2 is already present"

  fi

  tar -xf $BUSYBOX.tar.bz2
  rm $BUSYBOX.tar.bz2

else
  echo "$BUSYBOX is already present"

fi

cd $BUSYBOX
cp ../config/busybox.config ./.config
make -j $(nproc --all)
cp busybox $PREFIX/usr/bin/
cd ..

for item in $($PREFIX/usr/bin/busybox --list); do
    ln -sf busybox $PREFIX/usr/bin/$item
done
ln -sf bin/busybox $PREFIX/init
