
﻿#include <stdio.h>
#include <inttypes.h>
#include <signal.h>

#include "../../puerto_paralelo/puerto_paralelo.h"
#include "../adaptador_pp.h"

#define BASE 0x378

FILE * log_file = NULL;

int running = 1;

void signalHandler(int sig) {
   running = 0;
}


int test_modo_trabajo( enum Modo_Operacion_Adaptador modo) {

	int resultado = init_adaptador_pp( BASE, modo);
    if ( resultado != 0) {
        return resultado;
    }

    fprintf( (log_file == NULL)? stdout: log_file, "\nInicia Modo de Lectura");
    start_read_mode();
    print_registros();

    fprintf( (log_file == NULL)? stdout: log_file, "\nTermina Modo de Lectura");
    end_read_mode();
    print_registros();

    fprintf( (log_file == NULL)? stdout: log_file, "\nInicia Modo de Escritura");
    start_write_mode();
    print_registros();

    fprintf( (log_file == NULL)? stdout: log_file, "\nTermina Modo de Escritura");
    end_write_mode();
    print_registros();

    return release_adaptador_pp();

}


int main(void) {
    signal(SIGINT, signalHandler);

    printf("Prueba de Interface de Puerto Paralelo (Base: 0x%x)\n", BASE);

    printf( "\n\ta) Usando standard streams:\n");

    printf( "\n1.- Modo de trabajo PERIPHERIC_READ:\n");
    test_modo_trabajo( PERIPHERIC_READ);
    printf( "\n2.- Modo de trabajo SERVER_WRITE   :\n");
    test_modo_trabajo( SERVER_WRITE);

    printf( "\n\ta) Usando standard streams:\n");

    log_file = fopen( "./test_log_file.txt", "w");

    fprintf( log_file, "\n1.- Modo de trabajo PERIPHERIC_READ:\n");
    test_modo_trabajo( PERIPHERIC_READ);
    fprintf( log_file, "\n2.- Modo de trabajo SERVER_WRITE   :\n");
    test_modo_trabajo( SERVER_WRITE);

    fclose( log_file);

    return 0;

}
