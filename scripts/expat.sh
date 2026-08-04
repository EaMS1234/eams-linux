#!/bin/bash

EXPAT=expat-2.8.2
PREFIX=$(pwd)/initrd

if [ ! -d $EXPAT ]; then
  if [ ! -e $EXPAT.tar.xz ]; then
    wget https://github.com/libexpat/libexpat/releases/download/R_2_8_2/$EXPAT.tar.xz

  else
    echo "$EXPAT.tar.xz is already present"

  fi

  tar -xf $EXPAT.tar.xz
  rm $EXPAT.tar.xz

else
  echo "$EXPAT is already present"

fi

cd $EXPAT
CC=musl-gcc ./configure --prefix="$PREFIX"
make -j $(nproc --all)
make install
cd ..
