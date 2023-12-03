/**
 *      MAX TOGGLE SPEED
 */

#include <errno.h> 
#include <stdio.h>
#include <stdlib.h> 
#include <time.h> 
#include <inttypes.h>
#include <signal.h>

#include "parallel_port.h"

/**
 *  
 *  Test maximum toggle speed of a parallel port pin
 * 
 *    - Configures data port as output 
 *    - No uses log file
 *    - Toggles D4 in an infinite loop
 * 
 *  You should use the following command in order to run this program (max toggle speed)
 * 
 *  > sudo 02_max_toggle_speed.x
 * 
 *  You can indicate the delay between changes using the following command
 * 
 *  > sudo 02_max_toggle_speed.x NNN  
 * 
 *  Once started, you should use CTRL-C in order to exit de program
 */

#define BASE 0x378                                  // parallel port registers base address

FILE * log_file = NULL;                             // log file path

int running = 1;                                    // init status

unsigned int tnanos = 0;                           // delay in millis (invocation defines)



void signalHandler( int sig) {
   running = 0;
   release_puerto_paralelo();
   
   printf( "\n");
}


void wait_for( unsigned int tnanos) {
    if ( tnanos == 0) {
        return;
    }

    struct timespec remaining, request = { 0, tnanos}; 
    
    errno = 0; 

    if ( nanosleep( &request, &remaining) == -1) { 
        switch (errno) { 
            case EINTR: 
                printf("interrupted by a signal handler\n"); 
                break; 
  
            case EINVAL: 
                printf("tv_nsec - not in range or tv_sec is negative\n"); 
                break; 
  
            default: 
                perror( "nanosleep"); 
                break; 
        } 
    } 
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

        wait_for( tnanos);
    }
}

void set_delay_time( int argc, char* argv[]) {
    if ( argc < 2) {
        tnanos = 0;
        return;
    }
    long tmicros = strtol( argv[1], NULL, 0);

    tnanos = (int) ( tmicros * 1000);

    printf( "\nsetting t[millis] = %f\n", (tmicros / 1000.0));
}

int main( int argc, char* argv[]) {

    signal( SIGINT, signalHandler);

    printf( "Toggling D4 line of parallel port (Base: 0x%x)\n", BASE);

    set_delay_time( argc, argv);

    rutina_principal();

    printf( "\n");

    return 0;
}
