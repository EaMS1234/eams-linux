#!/bin/sh

TOOLS="build-base clang lld llvm mtools nasm bc cpio gettext perl xorriso meson ninja git bison cmake rsync gzip flex diffutils findutils"
LIBS="linux-headers pkgconf pkgconf-dev libffi-dev expat-dev libxml2-dev xkeyboard-config elfutils-dev openssl-dev ncurses-dev"

docker run --rm -it -v $(pwd):/eams-linux/ alpine \
  sh -c "apk update && apk add $TOOLS $LIBS && cd /eams-linux/ && make $1 eams-linux.iso && chown $(id -u):$(id -g) eams-linux.iso"

