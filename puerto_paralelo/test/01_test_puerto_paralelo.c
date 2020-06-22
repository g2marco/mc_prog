#include <stdio.h>
#include <inttypes.h>
#include <signal.h>

#include "../puerto_paralelo.h"

#define BASE 0x378

FILE * log_file = NULL;

int running = 1;

void signalHandler(int sig) {
   running = 0;
}

int rutina_principal() {

    int resultado = init_puerto_paralelo( BASE);
    if ( resultado != 0) {
		return resultado;
    }

    printf( "\n\nEstado inicial del Puerto\n");
    print_registros();
    
    port.data.value = 0xAA;
    write_data_port();
    
    port.control.value = 0xAA;
    write_control_port();
   
    printf( "\nEstado final del Puerto (0xAA)\n");
    print_registros();

    return release_puerto_paralelo();

}

int main(void) {
    signal(SIGINT, signalHandler);

    printf("Prueba de Interface de Puerto Paralelo (Base: 0x%x)\n", BASE);
    
    printf( "\n\ta) Usando standard streams:\n");
    
    rutina_principal();
    
    printf( "\n\ta) Usando standard streams:\n");

    log_file = fopen( "./test_log_file.txt", "w");

    rutina_principal();

    fclose( log_file);

    return 0;

}
