.PHONY: all run clean
all: boot.img
boot.img: sectorllm.asm models/stories260K_int.bin
	nasm -f bin sectorllm.asm -o boot.bin
	cat boot.bin models/stories260K_int.bin | dd of=$@ bs=1024 conv=notrunc count=1440
	rm boot.bin
run: boot.img
	qemu-system-i386 -hda boot.img
clean:
	rm -rf boot.img
