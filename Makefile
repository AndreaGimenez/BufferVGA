CFLAGS := -g -Og -m32
ASFLAGS := -m32
LDFLAGS := -m32 -nostdlib -Ttext=0x100000

all: vga
vga: vga.o main.o

run: vga
	qemu-system-i386 -kernel ./vga

clean:
	rm -f vga *.o
