/**
 *      Data Control
 */

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <signal.h>

#include "parallel_port.h"

/**
 *  Uses command line arguments to send specific driver methods in a loop
 * 
 *  - Options:
 * 
 *      - init          => reset_device() - delay 1 - init_HVP_mode() - delay 2
 *      - execute       => execute_command( command, tipoComando[, data]);
 */

#define BASE_PP_ADDR 0x378

FILE * log_file = NULL;

int running = 1;


void signalHandler( int sig) {
    running = 0;

    release_driver();
    printf( "\n");
}

/*
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


//  init / reset loop

void init_reset_loop() {

    while( running == 1) {
        reset_device();

        wait_for( 600);

        init_HVP_mode();

        wait_for( 300);
    }
}


//  execute simple command loop

void execute_loop() {
    while( running == 1) {
        execute_command( command, tipo, 0);
    }
}

typedef struct {
    unsigned short estatus;         // 0 tarea valida, 1 tarea invalida
    unsigned short opcion;          // 0 write data, 1 write data bit, 2 write control bit, 3 print status
    unsigned short idx;             // data: 0 - 7, control 0 - 3
    unsigned short value;           // register 0 -55, bit 0 : 1
} tarea;


tarea read_params( int argc, char* argv[]) {
    tarea t;

    t.estatus = 0;

    switch ( argc) {
        case 1:     // no params
            t.opcion = 3;
            break;

        case 3:     // data 0xAA | D1 0 | C3 0
            switch (argv[1][0]) {
                case 'd':
                    t.opcion = 0;

                    long value = strtol( argv[2], NULL, 0);

                    if ( value < 0 || value > 255) {
                        // error > valor fuera de rango
                        t.estatus = 1;
                    } else {
                        t.value  = (unsigned short) value;
                    }

                    break;

                case 'D':
                    t.opcion = 1;

                    t.idx    = char_to_int( argv[1][1]);
                    t.value  = char_to_int( argv[2][0]);

                    if ( t.idx < 0 || t.idx > 7 || t.value < 0 || t.value > 1) {
                        // error > valores no permitidos
                        t.estatus = 1;
                    }

                    break;

                case 'C':
                    t.opcion = 2;

                    t.idx    = char_to_int( argv[1][1]);
                    t.value  = char_to_int( argv[2][0]);

                    if ( t.idx < 0 || t.idx > 5 || t.idx == 4 || t.value < 0 || t.value > 1) {
                        // error > valores no permitidos
                        t.estatus = 1;
                    }

                    break;

                default:
                    t.estatus = 1;
            }

            break;


        default:    // invocation not allowed
            t.estatus = 1;

    }
    
    return t;
}

int main( int argc, char* argv[]) {
    
    printf( "Prueba de Interface de Puerto Paralelo (Base: 0x%x)\n", BASE_PP_ADDR);
    
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

    // configura como salida puerto de control
    
    port.control.bits.C3 = 1;
    port.control.bits.C5 = 0;
    write_control_port();

    switch( t.opcion) {
        case 0: reset_device();     break;
        case 1: init_reset_loop();  break;
        case 2: execute_cmd_loop(); break;
    }

    release_driver();
    
    printf( "\n");

    return 0;
}

*/

int main( int argc, char* argv[]) {
    
    printf( "PIC programmer driver test  (Parallel Port Base Addr: 0x%x)\n", BASE_PP_ADDR);
    
    
    int resultado = init_driver( BASE_PP_ADDR);
    if ( resultado != 0) {
        return resultado;
    }

    printf( "resetting programmer device");

    reset_device();

    release_driver();
    
    printf( "\n");

    return 0;
}