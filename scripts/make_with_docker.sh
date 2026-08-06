#!/bin/sh

DEPS="build-base linux-headers byacc clang lld llvm mtools nasm bc cpio gettext perl xorriso meson ninja pkgconf pkgconf-dev libffi-dev expat-dev libxml2-dev git"

docker run --rm -it -v $(pwd):/eams-linux/ alpine \
  sh -c "apk update && apk add $DEPS && cd /eams-linux/ && make essentials ui eams-linux.iso && chown $(id -u):$(id -g) eams-linux.iso"

