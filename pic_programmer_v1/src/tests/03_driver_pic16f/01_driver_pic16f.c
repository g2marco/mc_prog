
#include <errno.h> 
#include <stdio.h>
#include <stdlib.h> 
#include <time.h> 
#include <inttypes.h>
#include <signal.h>

/**
 *  Uses command line arguments to send specific driver methods
 * 
 *  - Options:
 * 
 *      - reset   (r)  => reset_device()
 *      - init    (i)  => init_device()
 *      - loop    (l)  => reset_device() - delay 1 - init_HVP_mode() - delay 2
 *      - exec    (e)  => execute_command( command, tipoComando[, data]);
 */

#define BASE_PP_ADDR 0x378

FILE * log_file = NULL;

int running = 1;


void signalHandler( int sig) {
    running = 0;

    release_driver();
    printf( "\n");
}

unsigned short char_to_int( char n) {
    return (unsigned short) ( n - '0');
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


//
//  device driver routines
//

void execute_reset_device() {
    reset_device();
}

void execute_init_device() {
    init_HVP_mode();
}

void execute_init_reset_loop() {

    while( running == 1) {
        reset_device();
        wait_for( 600);

        init_HVP_mode();
        wait_for( 300);
    }
}

void execute_comman_loop() {
    while( running == 1) {
        //execute_command( command, tipo, 0);
    }
}

typedef struct {
    unsigned short estatus;         // 0 tarea valida, 1 tarea invalida
    unsigned short opcion;          // 0, 1, 2, 3
} tarea;


tarea read_params( int argc, char* argv[]) {
    tarea t;

    t.estatus = 0;

    switch ( argc) {
        case 2:     // single option
            switch( argv[1][0]) {
                case 'r': t.opcion = 0; break;
                case 'i': t.opcion = 1; break;
                case 'l': t.opcion = 2; break;
                case 'e': t.opcion = 3; break;
                
                default: t.estatus = 1;
            }

            break;

        default:    // invocation not allowed
            t.estatus = 1;
    }
    
    return t;
}

int main( int argc, char* argv[]) {
    
    printf( "PIC programmer driver test  (Parallel Port Base Addr: 0x%x)\n", BASE_PP_ADDR);
    
    // analiza argumentos

    tarea t = read_params( argc, argv);

    if ( t.estatus != 0) {
        printf( "\n\tWrong invocation / parameters, please correct\n");
        return 0;
    }

    // va a realizar una tarea

    printf( "\n\ta) Usando standard streams:\n");
    
    int resultado = init_driver( BASE_PP_ADDR);
    if ( resultado != 0) {
        return resultado;
    }

    switch( t.opcion) {
        case 0: execute_reset_device();     break;
        case 1: execute_init_device();      break;
        case 2: execute_init_reset_loop();  break;
        case 3: execute_comman_loop();      break;
    }

    release_driver();
    
    printf( "\n");

    return 0;
}
