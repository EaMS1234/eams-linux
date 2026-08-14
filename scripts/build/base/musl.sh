#!/bin/sh

MUSL=musl-1.2.6
PREFIX=$(pwd)/initrd

if [ ! -d $MUSL ]; then
  if [ ! -e $MUSL.tar.gz ]; then
    wget https://musl.libc.org/releases/$MUSL.tar.gz
    ERROR=$?
    if [ ! $ERROR -eq 0 ]; then exit $ERROR; fi

  else
    echo "$MUSL.tar.gz is already present"

  fi

  tar -xf $MUSL.tar.gz
  rm $MUSL.tar.gz

else
  echo "$MUSL is already present"

fi

cd $MUSL
./configure --prefix="/usr" --syslibdir="/usr/lib" --disable-gcc-wrapper
make -j $(nproc --all) TARGET=x86_64-linux-musl install DESTDIR=$PREFIX
rm $PREFIX/usr/lib/ld-musl-x86_64.so.1
ln -sf libc.so $PREFIX/usr/lib/ld-musl-x86_64.so.1
cd ..
