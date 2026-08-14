#!/bin/sh

XKBCOMMON=xkbcommon-1.14.0-beta1
PREFIX=$(pwd)/initrd

if [ ! -d libxkbcommon-$XKBCOMMON ]; then
  if [ ! -e $XKBCOMMON.tar.gz ]; then
    wget https://github.com/xkbcommon/libxkbcommon/archive/refs/tags/$XKBCOMMON.tar.gz
    ERROR=$?
    if [ ! $ERROR -eq 0 ]; then exit $ERROR; fi

  else
    echo "$XKBCOMMON.tar.gz is already present"

  fi

  tar -xf $XKBCOMMON.tar.gz
  rm $XKBCOMMON.tar.gz

else
  echo "libxkbcommon-$XKBCOMMON is already present"

fi

cd libxkbcommon-$XKBCOMMON
meson setup build --reconfigure --prefix=/usr -Denable-x11=false
DESTDIR=$PREFIX ninja -C build install
cd ..

