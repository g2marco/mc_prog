/**
 *      Data Control
 */

#include <stdio.h>
#include <inttypes.h>
#include <signal.h>

#include "../puerto_paralelo.h"

/**
 *  Uses command line arguments to control individual parallel port pins  
 * 
 *  - Options:
 * 
 *    a) whole data register:  data 0xAA
 *    b) individual pins    :  D1   1; C0 1; D7 0;  etc
 *    c) with no arguments, it reads the status port and prints the current state of all registers
 *    
 * 
 *  > sudo 02_max_toggle_speed.x
 *  
 *  Once started, you should use CTRL-C in order to exit de program
 */

#define BASE 0x378                                  // parallel port registers base address

FILE * log_file = NULL;                             // log file path


//  updates whole data register with a value

void update_data_port( unsigned int value) {
    port.data.value = value;
    
    write_data_port();
}


//  updates an individual bit of data register

void update_data_bit( unsigned int idx, unsigned int value) {
    switch( idx) {
        case 0: port.data.bits.D0 = value; break;
        case 1: port.data.bits.D1 = value; break;
        case 2: port.data.bits.D2 = value; break;
        case 3: port.data.bits.D3 = value; break;
        case 4: port.data.bits.D4 = value; break;
        case 5: port.data.bits.D5 = value; break;
        case 6: port.data.bits.D6 = value; break;
        case 7: port.data.bits.D7 = value; break;

    }

    write_data_port();
}


//  updates an individual bit of control register

void update_control_bit ( unsigned int idx, unsigned int value) {
    switch( idx) {
        case 0: port.control.bits.C0 = value; break;
        case 1: port.control.bits.C1 = value; break;
        case 2: port.control.bits.C2 = value; break;
        case 3: port.control.bits.C3 = value; break;
    }

    write_control_port();
}


//  reads status port and prints current status of all registers

void read_and_print() {
    read_status_port();

    print_registros();
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

    swtich ( argc) {
        case 1:     // no params
            t.opcion = 3;
            break;

        case 3:     // data 0xAA | D1 0 | C3 0
            t.opcion = 1;
            t.value  = 255;
            break;

        default:    // invocation not allowed
            t.estatus = 1;

    }
    
    return t;
}

int main( int argc, char* argv[]) {
    
    printf( "Prueba de Interface de Puerto Paralelo (Base: 0x%x)\n", BASE);
    
    printf( "\n\ta) Usando standard streams:\n");
    
    // analiza argumentos

    tarea t = read_params( argc, argv);

    if ( t.estatus != 0) {
        printf( "\n\tWrong invocation / parameters, please correct");
        return 0;
    }

    // va a realizar una tarea

    int resultado = init_puerto_paralelo( BASE);
    if ( resultado != 0) {
        return resultado;
    }

    // configura como salida
    port.control.bits.C3 = 1;
    port.control.bits.C5 = 0;
    write_control_port();

    switch( t.opcion) {
        case 0: update_data_port(          t.value); break;
        case 1: update_data_bit(    t.idx, t.value); break;
        case 2: update_control_bit( t.idx, t.value); break;
        case 3: read_and_print();                    break;
    }
    
    release_puerto_paralelo();
    
    printf( "\n");

    return 0;
}
