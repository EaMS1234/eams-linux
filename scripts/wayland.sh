#!/bin/sh

WAYLAND=wayland-1.26.0
WAYLAND_PROTOCOLS=wayland-protocols-1.49
PREFIX=$(pwd)/initrd

export PATH="$PREFIX/bin:$PATH"
export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
export LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"

if [ ! -d $WAYLAND ]; then
  if [ ! -e $WAYLAND.tar.xz ]; then
    wget https://gitlab.freedesktop.org/wayland/wayland/-/releases/1.26.0/downloads/$WAYLAND.tar.xz
    ERROR=$?
    if [ ! $ERROR -eq 0 ]; then exit $ERROR; fi

  else
    echo "$WAYLAND.tar.xz is already present"

  fi

  tar -xf $WAYLAND.tar.xz
  rm $WAYLAND.tar.xz

else
  echo "$WAYLAND is already present"

fi

cd $WAYLAND
meson setup build --prefix=$PREFIX -Ddocumentation=false
ninja -C build install
cd ..


if [ ! -d $WAYLAND_PROTOCOLS ]; then
  if [ ! -e $WAYLAND_PROTOCOLS.tar.gz ]; then
    wget https://gitlab.freedesktop.org/wayland/wayland-protocols/-/archive/1.49/$WAYLAND_PROTOCOLS.tar.gz

  else
    echo "$WAYLAND_PROTOCOLS.tar.gz is already present"

  fi

  tar -xf $WAYLAND_PROTOCOLS.tar.gz
  rm $WAYLAND_PROTOCOLS.tar.gz

else
  echo "$WAYLAND_PROTOCOLS is already present"

fi

cd $WAYLAND_PROTOCOLS
meson setup build --prefix=$PREFIX -Dtests=false
ninja -C build install
cd ..
