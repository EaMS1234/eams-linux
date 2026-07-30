#!/bin/sh

cd initrd
find . -print0 | cpio --null -ov --format=newc --owner 0:0 | gzip -9 > ../root/boot/initrd.img
cd ..

