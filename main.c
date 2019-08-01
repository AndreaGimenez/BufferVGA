#include <stdint.h>

vga1() escribe una cadena al comienzo del buffer VGA. La
cadena no debe tener ni saltos de lÃ­nea ni tabuladores (solo
caracteres ASCII imprimibles).
void vga1(const char *msg, uint8_t color);

vga2() escribe una cadena en posiciÃ³n indicada (lÃ­nea y
columna), y devuelve un puntero a la siguiente posiciÃ³n
del buffer VGA (la primera no escrita). La lÃ­nea puede
ser un nÃºmero negativo, en cuyo caso se debe contar desde
la Ãºltima lÃ­nea hacia arriba.
void *vga2(const char *msg, int8_t linea, uint8_t col, uint8_t color);

vga3() escribe una cadena en direcciÃ³n de memoria marcada
por la variable global VGAPOS, actualizando esta variable
tras escribir. La funciÃ³n maneja los saltos de lÃ­nea asÃ­:
se aÃ±ade una nueva lÃ­nea y se alinea el texto con la anterior.
void vga3(const char *msg, uint8_t color);

void _start(void) {
    vga1("Hola desde vga1(). Se imprime al comienzo del buffer VGA.", 0x2F);
    char *pos1 = vga2("Hola desde vga2(5, 20).", 5, 20, 0x4F);
    char *pos2 = vga2("Hola desde vga2(-16, 10).", -16, 10, 0x4F);
    
    VGAPOS = pos1;
    vga3("Hola,\nciao.", 0xE0);
    vga3("Falta poco para terminar.", 0x3F);
    
    VGAPOS = pos2 + 162;
    vga3("Byeeee!", 0xD0);

    __asm__("hlt");
}
