B = build
.PHONY: all run
all: $(B)/boot.img
$(B)/boot.img: sectorllm.asm models/stories260K_int.bin
	nasm -f bin sectorllm.asm -o $(B)/boot.bin
	cat $(B)/boot.bin models/stories260K_int.bin | dd of=$@ bs=1024 conv=notrunc count=1440
	rm $(B)/boot.bin
run: $(B)/boot.img
	qemu-system-i386 -hda $(B)/boot.img
