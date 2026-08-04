#!/bin/sh

DEPS="base-devel musl kernel-headers-musl clang lld llvm mtools nasm bc cpio gettext perl xorriso"

docker run --rm -it -v $(pwd):/eams-linux/ archlinux \
  bash -c "pacman -Sy --noconfirm $DEPS && cd /eams-linux/ && make eams-linux.iso && chown $(id -u):$(id -g) eams-linux.iso"

