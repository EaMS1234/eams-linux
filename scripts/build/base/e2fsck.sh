#!/bin/sh

E2FSCK=e2fsprogs-1.47.4
PREFIX=$(pwd)/initrd

if [ ! -d $E2FSCK ]; then
  if [ ! -e $E2FSCK.tar.xz ]; then
    wget https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v1.47.4/$E2FSCK.tar.xz
    ERROR=$?
    if [ ! $ERROR -eq 0 ]; then exit $ERROR; fi

  else
    echo "$E2FSCK.tar.xz is already present"

  fi

  tar -xf $E2FSCK.tar.xz
  rm $E2FSCK.tar.xz

else
  echo "$E2FSCK is already present"

fi

cd $E2FSCK
./configure --prefix=/usr
make -j $(nproc --all) e2fsck
install e2fsck/e2fsck $PREFIX/usr/bin/fsck.ext2
cd ..

