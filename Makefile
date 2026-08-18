all: base eams-linux.iso

wayland: base initrd/usr/lib/libwayland-server.so initrd/usr/lib/libxkbcommon.so eams-linux.iso

base: root/bzImage initrd/usr/lib/libc.so initrd/usr/lib64/libgcc_s.so initrd/usr/bin/busybox initrd/usr/bin/doas initrd/usr/bin/limine initrd/usr/bin/kbdinfo

initrd/usr/lib/libc.so:
	scripts/build/base/musl.sh

initrd/usr/lib64/libgcc_s.so: initrd/usr/lib/libc.so
	scripts/build/base/gcc.sh

initrd/usr/bin/limine: initrd/usr/lib/libc.so
	scripts/build/base/limine.sh

initrd/usr/bin/busybox: initrd/usr/lib/libc.so
	scripts/build/base/busybox.sh

initrd/usr/bin/doas: initrd/usr/lib/libc.so
	scripts/build/base/opendoas.sh

initrd/usr/bin/kbdinfo: initrd/bin/busybox
	scripts/build/base/kbd.sh

root/bzImage:
	scripts/build/base/kernel.sh

initrd/usr/lib/libffi.so: base
	scripts/build/wayland/libffi.sh

initrd/usr/lib/libxml2.so: base
	scripts/build/wayland/libxml2.sh

initrd/usr/lib/libexpat.so: base
	scripts/build/wayland/expat.sh

initrd/usr/lib/libpixman-1.so: base
	scripts/build/wayland/pixman.sh

initrd/usr/lib/libdrm.so: base
	scripts/build/wayland/libdrm.sh

initrd/usr/lib/libwayland-server.so: initrd/usr/lib/libffi.so initrd/usr/lib/libxml2.so initrd/usr/lib/libexpat.so
	scripts/build/wayland/wayland.sh

initrd/usr/lib/libxkbcommon.so: initrd/usr/lib/libwayland-server.so initrd/usr/lib/libpixman-1.so initrd/usr/lib/libdrm.so
	scripts/build/wayland/xkbcommon.sh

root/initrd.img: base
	scripts/initrd.sh

eams-linux.iso: root/initrd.img
	xorriso -as mkisofs -V "eams-linux-live" -b /boot/limine-bios-cd.bin -no-emul-boot -boot-load-size 4 -boot-info-table --efi-boot /boot/limine-uefi-cd.bin -efi-boot-part --efi-boot-image root/ -o eams-linux.iso
	initrd/bin/limine bios-install eams-linux.iso

run: eams-linux.iso
	qemu-system-x86_64 -cdrom eams-linux.iso -m 512M

