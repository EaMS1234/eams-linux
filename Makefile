all: base eams-linux.iso

wayland: base initrd/lib/libwayland-server.so initrd/lib/libxkbcommon.so eams-linux.iso

base: root/boot/bzImage initrd/lib/libc.so initrd/bin/busybox initrd/bin/doas initrd/bin/limine

initrd/lib/libc.so:
	scripts/build/base/musl.sh

initrd/bin/limine: initrd/lib/libc.so
	scripts/build/base/limine.sh

initrd/bin/busybox: initrd/lib/libc.so
	scripts/build/base/busybox.sh

initrd/bin/doas: initrd/lib/libc.so
	scripts/build/base/opendoas.sh

root/boot/bzImage:
	scripts/build/base/kernel.sh

initrd/lib/libffi.so: initrd/lib/libc.so
	scripts/build/ui/libffi.sh

initrd/lib/libxml2.so: base
	scripts/build/ui/libxml2.sh

initrd/lib/libexpat.so: base
	scripts/build/ui/expat.sh

initrd/lib/libpixman-1.so: base
	scripts/build/ui/pixman.sh

initrd/lib/libdrm.so: base
	scripts/build/ui/libdrm.sh

initrd/lib/libwayland-server.so: initrd/lib/libffi.so initrd/lib/libxml2.so initrd/lib/libexpat.so
	scripts/build/ui/wayland.sh

initrd/lib/libxkbcommon.so: initrd/lib/libwayland-server.so initrd/lib/libpixman-1.so initrd/lib/libdrm.so
	scripts/build/ui/xkbcommon.sh

root/boot/initrd.img: base
	scripts/initrd.sh

eams-linux.iso: root/boot/initrd.img
	xorriso -as mkisofs -V "EaMS Linux" -b /boot/limine-bios-cd.bin -no-emul-boot -boot-load-size 4 -boot-info-table --efi-boot /boot/limine-uefi-cd.bin -efi-boot-part --efi-boot-image root/ -o eams-linux.iso
	initrd/bin/limine bios-install eams-linux.iso

run: eams-linux.iso
	qemu-system-x86_64 -cdrom eams-linux.iso -m 512M
