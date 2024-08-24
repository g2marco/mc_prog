#ifndef DRIVER_PIC16F_HEADER

#define DRIVER_PIC16F_HEADER

//  declaraciones de tipos
enum Tipo_Comando {
    COMANDO_SIMPLE        ,
    COMANDO_PROGRAMACION  ,
    COMANDO_ESCRITURA_DATO,
    COMANDO_LECTURA_DATO
};

#define CARGA_DATO_MEM_PROGRAMA     0x02, COMANDO_ESCRITURA_DATO, ((dato << 1) & 0x7FFE)
#define CARGA_DATO_MEM_DATOS        0x03, COMANDO_ESCRITURA_DATO, ((dato << 1) & 0x7FFE)
#define CARGA_DATO_MEM_CONFIG       0x00, COMANDO_ESCRITURA_DATO, ((dato << 1) & 0x7FFE)

#define INICIA_CICLO_ERASE_PROGRAM  0x08, COMANDO_PROGRAMACION, 0

#define INCREMENTA_DIRECCION        0x06, COMANDO_SIMPLE, 0

#define LEER_DATO_MEM_PROGRAMA      0x04, COMANDO_LECTURA_DATO, 0
#define LEER_DATO_MEM_DATOS         0x05, COMANDO_LECTURA_DATO, 0

//
//
//#define BULK_ERASE_MEM_PROGRAMA     0x09, COMANDO_PROGRAMACION, 0
//#define BULK_ERASE_MEM_DATOS        0x0B, COMANDO_PROGRAMACION, 0
//

#define BULK_ERASE_MEM_PROGRAMA     0x09, COMANDO_SIMPLE, 0
#define BULK_ERASE_MEM_DATOS        0x0B, COMANDO_SIMPLE, 0

//  variables globales


// definición de funciones

int init_driver( unsigned short baseAddress);
int release_driver();

void reset_device();
void init_HVP_mode();

unsigned short execute_command( unsigned short command, enum Tipo_Comando tipoComando, unsigned short data);

#endif
