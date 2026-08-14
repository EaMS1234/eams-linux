#!/bin/sh

LIBDRM=libdrm-2.4.134
PREFIX=$(pwd)/initrd

if [ ! -d $LIBDRM ]; then
  if [ ! -e $LIBDRM.tar.xz ]; then
    wget https://dri.freedesktop.org/libdrm/$LIBDRM.tar.xz
    ERROR=$?
    if [ ! $ERROR -eq 0 ]; then exit $ERROR; fi

  else
    echo "$LIBDRM.tar.xz is already present"

  fi

  tar -xf $LIBDRM.tar.xz
  rm $LIBDRM.tar.xz

else
  echo "$LIBDRM is already present"

fi

cd $LIBDRM
meson setup build --reconfigure --prefix=/usr
DESTDIR=$PREFIX ninja -C build install
cd ..
