all: initrd.img teste.iso run

initrd.img:
	./initrd.sh

teste.iso: initrd.img
	grub-mkrescue -o teste.iso root

run: teste.iso
	qemu-system-x86_64 -cdrom teste.iso -m 512M

