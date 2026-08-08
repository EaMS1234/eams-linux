#!/bin/sh

PIXMAN=pixman-0.46.4
PREFIX=$(pwd)/initrd

if [ ! -d $PIXMAN ]; then
  if [ ! -e $PIXMAN.tar.xz ]; then
    wget https://cairographics.org/releases/$PIXMAN.tar.xz
    ERROR=$?
    if [ ! $ERROR -eq 0 ]; then exit $ERROR; fi

  else
    echo "$PIXMAN.tar.xz is already present"

  fi

  tar -xf $PIXMAN.tar.xz
  rm $PIXMAN.tar.xz

else
  echo "$PIXMAN is already present"

fi

cd $PIXMAN
meson setup build --prefix="$PREFIX"
ninja -C build install
cd ..
