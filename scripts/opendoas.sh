#!/bin/bash

OPENDOAS=opendoas-6.8.2

[[ $OPENDOAS =~ ^opendoas-(.*)$ ]]
VERSION="v${BASH_REMATCH[1]}"

if [ ! -e initrd/bin/ ]; then
  mkdir initrd/bin/

fi

if [ ! -d $OPENDOAS ]; then
  if [ ! -e $OPENDOAS.tar.gz ]; then
    wget https://github.com/Duncaen/OpenDoas/releases/download/$VERSION/$OPENDOAS.tar.gz

  else
    echo "$OPENDOAS.tar.bz2 is already present"

  fi

  tar -xf $OPENDOAS.tar.gz
  rm $OPENDOAS.tar.gz

else
  echo "$OPENDOAS is already present"

fi

cd $OPENDOAS
CC=musl-gcc ./configure --prefix=$(pwd)/../initrd --without-pam
make -j $(nproc --all) CC=musl-gcc install
cd ..

chmod u+s initrd/bin/doas
