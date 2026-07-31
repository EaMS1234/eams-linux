#!/bin/bash

MUSL=musl-1.2.6
PREFIX=../initrd

if [ ! -d $MUSL ]; then
  if [ ! -e $MUSL.tar.gz ]; then
    wget https://musl.libc.org/releases/$MUSL.tar.gz

  else
    echo "$MUSL.tar.gz is already present"

  fi

  tar -xf $MUSL.tar.gz
  rm $MUSL.tar.gz

else
  echo "$MUSL is already present"

fi

cd $MUSL
./configure --prefix="$PREFIX" --syslibdir="$PREFIX/lib/"
make TARGET=x86_64-linux-musl install
rm $PREFIX/lib/ld-musl-x86_64.so.1
ln -rs $PREFIX/lib/libc.so $PREFIX/lib/ld-musl-x86_64.so.1
cd ..

