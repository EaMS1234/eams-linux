#!/bin/sh

XKBCOMMON=xkbcommon-1.14.0-beta1
PREFIX=$(pwd)/initrd

export PATH="$PREFIX/bin:$PATH"
export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PREFIX/share/pkgconfig:$PKG_CONFIG_PATH"

if [ ! -d $XKBCOMMON ]; then
  if [ ! -e $XKBCOMMON.tar.gz ]; then
    wget https://github.com/xkbcommon/libxkbcommon/archive/refs/tags/$XKBCOMMON.tar.gz -O $XKBCOMMON.tar.gz

  else
    echo "$XKBCOMMON.tar.gz is already present"

  fi

  tar -xf $XKBCOMMON.tar.gz
  rm $XKBCOMMON.tar.gz

else
  echo "$XKBCOMMON is already present"

fi

cd $XKBCOMMON
meson setup build --prefix=$PREFIX -Denable-x11=false
ninja -C build install
cd ..

