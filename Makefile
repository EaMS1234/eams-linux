all: essentials ui eams-linux.iso run

noui: essentials eams-linux.iso run

essentials: initrd/lib/libc.so initrd/bin/busybox initrd/bin/doas initrd/bin/limine

ui: essentials initrd/lib/libwayland-server.so initrd/lib/libxkbcommon.so

initrd/lib/libc.so:
	scripts/musl.sh

initrd/lib/libffi.so: initrd/lib/libc.so
	scripts/libffi.sh

initrd/lib/libxml2.so: initrd/lib/libc.so
	scripts/libxml2.sh

initrd/lib/libexpat.so: initrd/lib/libc.so
	scripts/expat.sh

initrd/lib/libpixman-1.so: initrd/lib/libc.so
	scripts/pixman.sh

initrd/lib/libdrm.so: initrd/lib/libc.so
	scripts/libdrm.sh

initrd/lib/libwayland-server.so: initrd/lib/libffi.so initrd/lib/libxml2.so initrd/lib/libexpat.so
	scripts/wayland.sh

initrd/lib/libxkbcommon.so: initrd/lib/libwayland-server.so initrd/lib/libpixman-1.so initrd/lib/libdrm.so
	scripts/xkbcommon.sh

initrd/bin/limine: initrd/lib/libc.so
	scripts/limine.sh

initrd/bin/busybox: initrd/lib/libc.so
	scripts/busybox.sh

initrd/bin/doas: initrd/lib/libc.so
	scripts/opendoas.sh

root/boot/bzImage:
	scripts/kernel.sh

root/boot/initrd.img: essentials
	scripts/initrd.sh

eams-linux.iso: root/boot/initrd.img root/boot/bzImage
	xorriso -as mkisofs -V "EaMS Linux" -b /boot/limine-bios-cd.bin -no-emul-boot -boot-load-size 4 -boot-info-table --efi-boot /boot/limine-uefi-cd.bin -efi-boot-part --efi-boot-image root/ -o eams-linux.iso
	initrd/bin/limine bios-install eams-linux.iso

run: eams-linux.iso
	qemu-system-x86_64 -cdrom eams-linux.iso -m 512M

