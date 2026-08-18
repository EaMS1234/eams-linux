#!/bin/sh

LINUX=linux-7.1.8
PREFIX=$(pwd)/initrd

if [ ! -d $LINUX ]; then
  if [ ! -e $LINUX.tar.xz ]; then
    wget https://cdn.kernel.org/pub/linux/kernel/v7.x/$LINUX.tar.xz
    ERROR=$?
    if [ ! $ERROR -eq 0 ]; then exit $ERROR; fi
      
  else
    echo "$LINUX.tar.xz is already present"

  fi

  tar -xf $LINUX.tar.xz
  rm $LINUX.tar.xz

else
  echo "$LINUX is already present"

fi

cd $LINUX
cp ../config/kernel.config ./.config && make olddefconfig
make -j $(nproc --all)
make -j $(nproc --all) INSTALL_HDR_PATH=$PREFIX/usr/ headers_install

cd ..
cp $LINUX/arch/x86/boot/bzImage root/

