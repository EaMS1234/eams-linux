#!/bin/bash

WAYLAND=wayland-1.26.0
PREFIX=$(pwd)/initrd

if [ ! -d $WAYLAND ]; then
  if [ ! -e $WAYLAND.tar.xz ]; then
    wget https://gitlab.freedesktop.org/wayland/wayland/-/releases/1.26.0/downloads/$WAYLAND.tar.xz

  else
    echo "$WAYLAND.tar.xz is already present"

  fi

  tar -xf $WAYLAND.tar.xz
  rm $WAYLAND.tar.xz

else
  echo "$WAYLAND is already present"

fi

cd $WAYLAND
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
CC=musl-gcc meson setup build --prefix=$PREFIX -Ddocumentation=false
ninja -C build install
cd ..
