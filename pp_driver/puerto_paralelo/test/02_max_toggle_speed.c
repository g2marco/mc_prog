/**
 *      MAX TOGGLE SPEED
 */

#include <stdio.h>
#include <inttypes.h>
#include <signal.h>

#include "../puerto_paralelo.h"

/**
 *  
 *  Test maximum toggle speed of a parallel port pin
 * 
 *    - Configures data port as output 
 *    - No uses log file
 *    - Toggles D4 in an infinite loop
 * 
 *  You should use the following command in order to run this program
 * 
 *  > sudo 02_max_toggle_speed.x
 *  
 *  Once started, you should use CTRL-C in order to exit de program
 */

#define BASE 0x378                                  // parallel port registers base address

FILE * log_file = NULL;                             // log file path

int running = 1;                                    // init status


void signalHandler( int sig) {
   running = 0;
   release_puerto_paralelo();
   
   printf( "\n");
}

int rutina_principal() {

    // reclama puerto paralelo
    int resultado = init_puerto_paralelo( BASE);
    if ( resultado != 0) {
        return resultado;
    }

    // configura como salida
    port.control.bits.C3 = 1;
	port.control.bits.C5 = 0;
    write_control_port();

    // inicializacion de salidas
    port.data.value = 0xFF;
    write_data_port();

    // conmuta el bit D4
    while( running == 1) {
        port.data.bits.D4 = !port.data.bits.D4;
        write_data_port();
    }

}

int main(void) {
    signal( SIGINT, signalHandler);

    printf( "Toggling D4 line of parallel port (Base: 0x%x)\n", BASE);

    rutina_principal();

    printf( "\n");

    return 0;
}
