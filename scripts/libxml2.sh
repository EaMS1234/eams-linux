#!/bin/bash

LIBXML2=libxml2-v2.15.3
PREFIX=$(pwd)/initrd

if [ ! -d $LIBXML2 ]; then
  if [ ! -e $LIBXML2.tar.gz ]; then
    wget https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.15.3/$LIBXML2.tar.gz

  else
    echo "$LIBXML2.tar.gz is already present"

  fi

  tar -xf $LIBXML2.tar.gz
  rm $LIBXML2.tar.gz

else
  echo "$LIBXML2 is already present"

fi

cd $LIBXML2
CC=musl-gcc meson setup build --prefix=$PREFIX
ninja -C build install
cd ..
