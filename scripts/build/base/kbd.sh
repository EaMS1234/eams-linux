#!/bin/sh

KBD=kbd-2.9.0
PREFIX=$(pwd)/initrd

if [ ! -d $KBD ]; then
  if [ ! -e $KBD.tar.xz ]; then
    wget https://www.kernel.org/pub/linux/utils/kbd/$KBD.tar.xz
    ERROR=$?
    if [ ! $ERROR -eq 0 ]; then exit $ERROR; fi

  else
    echo "$KBD.tar.xz is already present"

  fi

  tar -xf $KBD.tar.xz
  rm $KBD.tar.xz

else
  echo "$KBD is already present"

fi

cd $KBD
./configure --prefix=$PREFIX
make -j $(nproc --all) install
cd ..

find "$PREFIX/share/keymaps" -type f -name "*.gz" | while IFS= read -r file; do
    gzip -df $file
done

