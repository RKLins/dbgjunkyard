ASMFLAGS = -mcpu=cortex-a9
LDFLAGS = -pie -nostartfiles -nostdlib -Wl,-T,./script.ld

ASMFILES = main.s
OFILES = $(patsubst %.s,%.o,$(ASMFILES))

%.o: %.s
	$(CROSS_COMPILE)as $(ASMFLAGS) $< -o $@

executable.elf: $(OFILES)
	$(CROSS_COMPILE)gcc $^ $(LDFLAGS) -o $@

all: library.cpp main.cpp
	# $@ evaluates to all
	# $< evaluates to library.cpp
	# $^ evaluates to library.cpp main.cpp

build:
	$(CROSS_COMPILE)as $(ASMFLAGS)

clean:
	rm executable.elf $(OFILES)
