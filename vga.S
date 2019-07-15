.globl vga1
vga1:
movl $0xB8000, %eax  //direccion de memoria inicial
INICIOCICLO:
xorb $0, %dx
je FINCICLO
movb %dx, (%eax)
incl %eax
movb %si, (%eax)
incl %eax
jmp INICIOCICLO
FINCICLO:
ret


.globl vga2
vga2:
  ret


.globl vga3
vga3:
  ret


.align 4
multiboot:
    .long 0x1BADB002
    .long 0
    .long -0x1BADB002
