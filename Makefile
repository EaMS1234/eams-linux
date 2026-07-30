all: initrd/lib/libc.so initrd/bin/busybox initrd/bin/limine root/boot/bzImage root/boot/initrd.img eams-linux.iso run

initrd/lib/libc.so:
	scripts/musl.sh

initrd/bin/limine:
	scripts/limine.sh

initrd/bin/busybox:
	scripts/busybox.sh

root/boot/bzImage:
	scripts/kernel.sh

root/boot/initrd.img: initrd/lib/libc.so initrd/bin/limine initrd/bin/busybox
	scripts/initrd.sh

eams-linux.iso: root/boot/initrd.img root/boot/bzImage
	xorriso -as mkisofs -V "EaMS Linux" -b /boot/limine-bios-cd.bin -no-emul-boot -boot-load-size 4 -boot-info-table root/ -o eams-linux.iso
	initrd/bin/limine bios-install eams-linux.iso

run: eams-linux.iso
	qemu-system-x86_64 -cdrom eams-linux.iso -m 512M

