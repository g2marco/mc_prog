
#include <stdio.h>

#include "parallel_port.h"
#include "port_adapter.h"
#include "driver_pic16f.h"


//
// Valores que provocan un estado alto/bajo en cada señal de salida
//
#define VPP_HIGH        0                           // CO
#define VPP_LOW         1

#define VCC_HIGH        1                           // C1
#define VCC_LOW         0

#define CLK_HIGH        0                           // C2
#define CLK_LOW         1

#define COMMAND_SIZE    6                           // número de bits de comando
#define DATA_SIZE      16                           // número de bits de dato
#define READ_DATA_SIZE 14                           // número de bits leidos de memoria

//
//  Tiempos de retardo requeridos por el dispositivo
//
#define VCC_SETUP_TIME         20000
#define VPP_SETUP_TIME         20000
#define CLK_HOLD_TIME            100


#define COMMAND_EXECUTION_TIME                3000      // tiempo para ejecución de comando
#define COMMAND_SETUP_TIME                    1000      // tiempo antes de envio de dato
#define COMMAND_PROGRAMMING_EXECUTION_TIME 4000000
#define INTER_COMMAND_TIME                    1000
    
//
//  Métodos de manipulación de señales de control
//

static void wait_for( unsigned milliseconds) {
    //TODO : implementar rutina de retardo usando nanoSleep()
}


static void set_vpp( unsigned valor) {
    port.control.bits.C0 = valor == 0? 0 : 1;       // C0 -- VPP
    write_control_port();
    wait_for( VPP_SETUP_TIME);
}

static void set_vcc( unsigned valor) {
    port.control.bits.C1 = valor == 0? 0 : 1;       // C1 -- Vcc
    write_control_port();
    wait_for( VCC_SETUP_TIME);
}

static void set_clk( unsigned valor) {
    port.control.bits.C2 = valor == 0? 0 : 1;       // C2 -- CLK
    write_control_port();
    wait_for( CLK_HOLD_TIME);
}

static void set_data( unsigned short valor) {
    port.data.bits.D0 = valor == 0? 0:1;            // D0 -- DATA
    write_data_port();
}

static unsigned short get_data() {                  // S3 (0000 1000)  -- DATA IN
    read_status_port();
    return port.status.bits.S3;
}

static void rise_vcc() {
    set_vcc( VCC_HIGH);
}

static void fall_vcc() {
    set_vcc(  VCC_LOW);
}

static void rise_clk() {
    set_clk( CLK_HIGH);
}

static void fall_clk() {
    set_clk(  CLK_LOW);
}

static void rise_vpp() {
    set_vpp( VPP_HIGH);
}

static void fall_vpp() {
    set_vpp(  VPP_LOW);
}   


//  definiciones internas

static void write_serial_data( unsigned short data, unsigned short bits) {
    unsigned bit;
    unsigned int i;
    
    for ( i = 0; i < bits; ++i) {
        bit = data & 0x01;

        set_data( bit);
        rise_clk();
        
        set_data( bit);
        fall_clk();
        
        data >>= 1;
    }
    
    set_data( 0);
}

static unsigned short read_serial_data(unsigned short totalBits, unsigned short readBits) {
    
    unsigned short data = 0;
    unsigned int i;
   
    for ( i = 0; i < totalBits; ++i) {
        if( i == 1) {   start_read_mode(); }
        rise_clk();
        get_data();
        
        if( i == (totalBits - 1)) { end_read_mode(); }
        
        fall_clk();
        data >>= 1;
        if( get_data() == 1) {
            data |= 0x8000;
        }
    }
    
    set_data(0);
    return data >> 1;
}

//
//  Implementación de módulo
//

int init_driver( unsigned short baseAddress) {
    return init_adaptador_pp( baseAddress, SERVER_WRITE);
}

int release_driver() {
    return release_adaptador_pp();
}


void reset_device() {
    set_data( 0);
    fall_clk();
    fall_vpp();
    fall_vcc();
}

void init_HVP_mode() {
    rise_vpp();
    rise_vcc();
}

unsigned short execute_command( unsigned short command, enum Tipo_Comando tipoComando, unsigned short data) {
    
    switch( tipoComando) {
        case COMANDO_SIMPLE:
            write_serial_data( command, COMMAND_SIZE);
            wait_for( COMMAND_EXECUTION_TIME);
            
            break;
            
        case COMANDO_PROGRAMACION:
            write_serial_data( command, COMMAND_SIZE);
            wait_for( COMMAND_PROGRAMMING_EXECUTION_TIME);

            break;
        
        case COMANDO_ESCRITURA_DATO:
            write_serial_data( command, COMMAND_SIZE);
            wait_for( COMMAND_SETUP_TIME);
        
            write_serial_data( data, DATA_SIZE);
            wait_for( COMMAND_EXECUTION_TIME);
    
            break;
        
        case COMANDO_LECTURA_DATO:
            write_serial_data( command, COMMAND_SIZE);
            wait_for( COMMAND_SETUP_TIME);
        
            unsigned short dataIn = read_serial_data( DATA_SIZE, READ_DATA_SIZE);
            wait_for( INTER_COMMAND_TIME);

            return dataIn;
    }

    return 0;
}
