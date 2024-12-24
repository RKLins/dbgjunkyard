ASMFLAGS = -mcpu=cortex-a9
LDFLAGS = -fPIE -mcpu=cortex-a9 -nostartfiles -nostdlib -Wl,-T,./script.ld -fdata-sections

ASMFILES = main.s
OFILES = $(patsubst %.s,%.o,$(ASMFILES))

all: executable.elf executable.bin

%.o: %.s
	$(CROSS_COMPILE)as $(ASMFLAGS) $< -o $@

executable.elf: $(OFILES)
	$(CROSS_COMPILE)gcc $^ $(LDFLAGS) -o $@

executable.bin: executable.elf
	$(CROSS_COMPILE)objcopy -O binary $^ $@

build:
	$(CROSS_COMPILE)as $(ASMFLAGS)

disassemble: executable.elf
	$(CROSS_COMPILE)objdump --disassemble-all executable.elf

clean:
	rm executable.elf $(OFILES) executable.bin
