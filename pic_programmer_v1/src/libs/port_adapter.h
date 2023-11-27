#ifndef ADAPTADOR_PUERTO_PARALELO_HEADER

#define ADAPTADOR_PUERTO_PARALELO_HEADER

//  tipos de datos 

enum Modo_Operacion_Adaptador {
    PERIPHERIC_READ,
    SERVER_WRITE
};

// variables globales


// declaración de funciones

int init_adaptador_pp( unsigned short baseAddress, enum Modo_Operacion_Adaptador modo);
int release_adaptador_pp();

void start_write_mode();
void end_write_mode();

void start_read_mode();
void end_read_mode();

#endif
