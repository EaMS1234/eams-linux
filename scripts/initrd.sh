#!/bin/sh

chmod 600 initrd/etc/shadow
chmod 400 initrd/etc/doas.conf
chmod u+s initrd/usr/bin/doas

cd initrd
find . -print0 | cpio --null -ov --format=newc --owner 0:0 | gzip -9 > ../root/initrd.img
cd ..

chmod 644 initrd/etc/shadow initrd/etc/doas.conf

