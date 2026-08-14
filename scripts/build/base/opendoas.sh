#!/bin/sh

OPENDOAS=opendoas-6.8.2
VERSION="v${OPENDOAS#opendoas-}"
PREFIX=$(pwd)/initrd

if [ ! -e initrd/bin/ ]; then
  mkdir initrd/bin/

fi

if [ ! -d $OPENDOAS ]; then
  if [ ! -e $OPENDOAS.tar.gz ]; then
    wget https://github.com/Duncaen/OpenDoas/releases/download/$VERSION/$OPENDOAS.tar.gz
    ERROR=$?
    if [ ! $ERROR -eq 0 ]; then exit $ERROR; fi

  else
    echo "$OPENDOAS.tar.bz2 is already present"

  fi

  tar -xf $OPENDOAS.tar.gz
  rm $OPENDOAS.tar.gz

else
  echo "$OPENDOAS is already present"

fi

cd $OPENDOAS
./configure --prefix=/usr --without-pam
make -j $(nproc --all) && make install DESTDIR=$PREFIX
cd ..

chmod u+s $PREFIX/usr/bin/doas
