#!/bin/sh

chmod 600 initrd/etc/shadow
chmod 400 initrd/etc/doas.conf

ln -sf usr/lib initrd/lib

cd initrd
find . -print0 | cpio --null -ov --format=newc --owner 0:0 | gzip -9 > ../root/boot/initrd.img
cd ..

chmod 644 initrd/etc/shadow initrd/etc/doas.conf

