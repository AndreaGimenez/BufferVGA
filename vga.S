.globl vga1
vga1:
pushl %ebp
movl %esp, %ebp
pushl %ebx
movl $0xB8000, %edx  //direccion de memoria inicial
movb 12(%ebp), %al //color
movl 8(%ebp),%ebx //aca esta el primer caracter del string de chars

//pusheo los parametros de la poner_caracteres_en_el_buffer
pushl %edx
pushl %eax
pushl %ebx

call poner_caracteres_en_el_buffer

addl $12, %esp //saco los parametros de la poner_caracteres_en_el_buffer del tope de la pila

popl %ebx
movl %ebp, %esp
popl %ebp

ret

.globl vga2
vga2:
pushl %ebp
movl %esp, %ebp
pushl %esi
pushl %ebx
pushl %edi

movl $0xB8000, %esi //direccion de memoria inicial
movl 8(%ebp),%edi //aca esta el primer caracter del string de chars
movl 12(%ebp),%ebx //aca esta la alinea
movl 16(%ebp), %ecx //aca esta la columna
movl 20(%ebp), %eax //color

test %ebx, %ebx
jns ESPOSITIVO
addl $25, %ebx

ESPOSITIVO:
//calculo la direccion
lea (%ebx, %ebx, 4), %ebx
lea (,%ebx,4), %ebx
lea (,%ebx,8), %ebx
addl %ebx, %esi
addl %ecx, %esi //direccion en la q empiezo a escribir

//pusheo los parametros de la poner_caracteres_en_el_buffer
pushl %esi
pushl %eax
pushl %edi
call poner_caracteres_en_el_buffer
addl $12, %esp  //saco los parametros de la poner_caracteres_en_el_buffer del tope de la pila

movl %esi, %eax
popl %edi
popl %ebx
popl %esi
movl %ebp, %esp
popl %ebp

ret

.globl vga3
vga3:
pushl %ebp
movl %esp, %ebp
pushl %esi
pushl %edi
pushl %ebx
pushl %edx

movl VGAPOS, %esi //memoria en la que empiezo a escribir
movl 8(%ebp),%edi //aca esta el primer caracter del string de chars
movl 12(%ebp),%ebx //aca esta el color

//pusheo los parametros de la poner_caracteres_en_el_buffer
pushl %esi
pushl %ebx
pushl %edi
call poner_caracteres_en_el_buffer

movl %esi, VGAPOS

popl %edx
popl %ebx
popl %edi
popl %esi
movl %ebp, %esp
popl %ebp

ret


poner_caracteres_en_el_buffer:
  pushl %ebp
  movl %esp, %ebp
  pushl %ebx
  pushl %edx
  movl 8(%ebp),%ebx //aca esta el primer caracter del string de chars
  movb 12(%ebp), %al // color
  movl 16(%ebp), %esi //guardo dir del buffer
  movb (%ebx), %cl

  movb $10, %dl


  copiar_caracteres:
  test %cl,%cl
  je FIN
  cmp %cl, %dl //el caracter es un salto de linea
  jz HAYUNSALTODELINEA
  movb %cl, (%esi) //copio el caracter en el buffer
  addl $1, %esi //calculo posicion para el color
  movb %al, (%esi) //pongo en el buffer el byte de color
  addl $1, %esi //calculo posicion para el proximo caracter
  addl $1, %ebx //avanzo en el string de chars
  movb (%ebx), %cl
  jmp copiar_caracteres

  HAYUNSALTODELINEA:
  //calcular a donde seguira escribiendo
  movl VGAPOS, %esi
  addl $160, %esi
  addl $1, %ebx //avanzo en el string de chars
  movb (%ebx), %cl
  jmp copiar_caracteres

  FIN:
  popl %edx
  popl %ebx
  movl %ebp, %esp
  popl %ebp
  ret


.align 4
multiboot:
    .long 0x1BADB002
    .long 0
    .long -0x1BADB002

    .long -0x1BADB002
