#!/bin/sh

cd initrd
find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../root/boot/initrd.img
cd ..

