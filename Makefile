BUILD_DIR = build

.PHONY: all clean boot.img run

all: $(BUILD_DIR)/infer

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)

boot.img: boot.asm models/stories260K_int.bin | $(BUILD_DIR)
	nasm -f bin boot.asm -o $(BUILD_DIR)/boot.bin
	cat $(BUILD_DIR)/boot.bin models/stories260K_int.bin > $(BUILD_DIR)/temp.img
	dd if=/dev/zero of=$(BUILD_DIR)/boot.img bs=1024 count=1440
	dd if=$(BUILD_DIR)/temp.img of=$(BUILD_DIR)/boot.img conv=notrunc
	rm $(BUILD_DIR)/temp.img
	@echo "Built: $(BUILD_DIR)/boot.img"

run: boot.img
	qemu-system-i386 -hda $(BUILD_DIR)/boot.img
