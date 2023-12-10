/**
 *      PARALLEL PORT GENERAL TEST
 */

#include <stdio.h>
#include <inttypes.h>
#include <signal.h>

#include "../parallel_port.h"

/**
 *  
 *  Writes and reads the parallel port registers using the API (puerto paralelo)
 *
 *    - Writes data to data register
 *    - Reports port registers
 * 
 *    - Writes data to control register
 *    - Reports port registers
 * 
 * 
 *  You should use the following command in order to run this program
 * 
 *  > sudo 01_puerto_paralelo.x
 */

#define BASE 0x378                                  // parallel port registers base address

FILE * log_file = NULL;                             // log file path

int running = 1;                                    // init status


int rutina_principal() {

    int resultado = init_puerto_paralelo( BASE);
    if ( resultado != 0) {
		return resultado;
    }

    printf( "\n\nInitial state of the port\n");
    print_registros();
    
    
    printf( "\t- Writing 0xAA to data port\n");
    port.data.value = 0xAA;
    write_data_port();
    
    
    printf( "\t- Writing 0x0A to control port\n");
    port.control.value = 0x0A;
    write_control_port();
   

    printf( "\n\nEnd state of the port\n");
    print_registros();

    return release_puerto_paralelo();
}

int main(void) {
    printf( "Prueba de Interface de Puerto Paralelo (Base: 0x%x)\n", BASE);
    
    printf( "\n\ta) Usando standard streams:\n");
    
    rutina_principal();
    
    printf( "\n\ta) Usando standard streams:\n");

    log_file = fopen( "./test_log_file.log", "w");

    rutina_principal();

    fclose( log_file);

    printf( "\n");

    return 0;
}
