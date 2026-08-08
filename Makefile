all: essentials eams-linux.iso run

ui: essentials initrd/lib/libwayland-server.so initrd/lib/libxkbcommon.so eams-linux.iso run

essentials: initrd/lib/libc.so initrd/bin/busybox initrd/bin/doas initrd/bin/limine root/boot/bzImage

initrd/lib/libc.so:
	scripts/build/musl.sh

initrd/lib/libffi.so: initrd/lib/libc.so
	scripts/build/libffi.sh

initrd/lib/libxml2.so: initrd/lib/libc.so
	scripts/build/libxml2.sh

initrd/lib/libexpat.so: initrd/lib/libc.so
	scripts/build/expat.sh

initrd/lib/libpixman-1.so: initrd/lib/libc.so
	scripts/build/pixman.sh

initrd/lib/libdrm.so: initrd/lib/libc.so
	scripts/build/libdrm.sh

initrd/lib/libwayland-server.so: initrd/lib/libffi.so initrd/lib/libxml2.so initrd/lib/libexpat.so
	scripts/build/wayland.sh

initrd/lib/libxkbcommon.so: initrd/lib/libwayland-server.so initrd/lib/libpixman-1.so initrd/lib/libdrm.so
	scripts/build/xkbcommon.sh

initrd/bin/limine: initrd/lib/libc.so
	scripts/build/limine.sh

initrd/bin/busybox: initrd/lib/libc.so
	scripts/build/busybox.sh

initrd/bin/doas: initrd/lib/libc.so
	scripts/build/opendoas.sh

root/boot/bzImage:
	scripts/build/kernel.sh

root/boot/initrd.img: essentials
	scripts/initrd.sh

eams-linux.iso: root/boot/initrd.img
	xorriso -as mkisofs -V "EaMS Linux" -b /boot/limine-bios-cd.bin -no-emul-boot -boot-load-size 4 -boot-info-table --efi-boot /boot/limine-uefi-cd.bin -efi-boot-part --efi-boot-image root/ -o eams-linux.iso
	initrd/bin/limine bios-install eams-linux.iso

run: eams-linux.iso
	qemu-system-x86_64 -cdrom eams-linux.iso -m 512M

