#!/bin/sh

LIBFFI=libffi-3.7.1
PREFIX=$(pwd)/initrd

if [ ! -d $LIBFFI ]; then
  if [ ! -e $LIBFFI.tar.gz ]; then
    wget https://github.com/libffi/libffi/releases/download/v3.7.1/$LIBFFI.tar.gz

  else
    echo "$LIBFFI.tar.gz is already present"

  fi

  tar -xf $LIBFFI.tar.gz
  rm $LIBFFI.tar.gz

else
  echo "$LIBFFI is already present"

fi

cd $LIBFFI
./configure --prefix="$PREFIX"
make -j $(nproc --all) && make install
cd ..
