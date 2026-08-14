#!/bin/sh

GCC=gcc-16.2.0
PREFIX=$(pwd)/initrd

if [ ! -d $GCC ]; then
  if [ ! -e $GCC.tar.xz ]; then
    wget https://ftp.gnu.org/gnu/gcc/$GCC/$GCC.tar.xz
    ERROR=$?
    if [ ! $ERROR -eq 0 ]; then exit $ERROR; fi

  else
    echo "$GCC.tar.xz is already present"

  fi

  tar -xf $GCC.tar.xz
  rm $GCC.tar.xz

else
  echo "$GCC is already present"

fi

cd $GCC
mkdir build
cd build
../configure --prefix=/usr --target=x86_64-linux-musl --enable-languages=c,c++ --disable-multilib --disable-bootstrap --disable-symvers --disable-stdcxx-pch --enable-clocale=generic --disable-libsanitizer --disable-libgomp --disable-libquadmath --disable-libitm --disable-libvtv --disable-libssp --disable-nls
make -j$(nproc) all-target-libgcc_s all-target-libstdc++-v3
make install-target-libgcc_s install-target-libstdc++-v3
cd ..

