#!/bin/sh

XKBCOMMON=xkbcommon-1.14.0-beta1
PREFIX=$(pwd)/initrd

export PATH="$PREFIX/bin:$PATH"
export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PREFIX/share/pkgconfig:$PKG_CONFIG_PATH"
export LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"

if [ ! -d libxkbcommon-$XKBCOMMON ]; then
  if [ ! -e libxkbcommon-$XKBCOMMON.tar.gz ]; then
    wget https://github.com/xkbcommon/libxkbcommon/archive/refs/tags/$XKBCOMMON.tar.gz
    ERROR=$?
    if [ ! $ERROR -eq 0 ]; then exit $ERROR; fi

  else
    echo "libxkbcommon-$XKBCOMMON.tar.gz is already present"

  fi

  tar -xf libxkbcommon-$XKBCOMMON.tar.gz
  rm libxkbcommon-$XKBCOMMON.tar.gz

else
  echo "libxkbcommon-$XKBCOMMON is already present"

fi

cd libxkbcommon-$XKBCOMMON
meson setup build --prefix=$PREFIX -Denable-x11=false
ninja -C build install
cd ..

