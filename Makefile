all: root/boot/bzImage root/boot/initrd.img eams-linux.iso run

root/boot/bzImage:
	./kernel.sh

root/boot/initrd.img:
	./initrd.sh

eams-linux.iso: root/boot/initrd.img root/boot/bzImage
	grub-mkrescue -o eams-linux.iso root

run: eams-linux.iso
	qemu-system-x86_64 -cdrom eams-linux.iso -m 512M

