#include "pic16fxxx_driver.h"

#include <stdio.h>

#include "../puerto_paralelo/puerto_paralelo.h"
#include "../adaptador_pp/adaptador_pp.h"

//
// Valores que provocan un estado alto/bajo en cada señal de salida
//
#define VCC_HIGH    1
#define VCC_LOW     0

#define CLK_HIGH    1
#define CLK_LOW     0

#define VPP_HIGH    0
#define VPP_LOW     1

#define COMMAND_SIZE             6              // número de bits de comando
#define DATA_SIZE               16              // número de bits de dato
#define READ_DATA_SIZE          14              // número de bits leidos de memoria

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

static void wait_for( unsigned int ciclosRetardo) {
    unsigned int i;
    unsigned valor = 0;
    for( i = 0; i < ciclosRetardo; ++i) {
       valor = i;
    }
}

static void set_vcc( unsigned valor) {         
    port.control.bits.C0 = ((valor == 0)? 0:1);     // C0 (Vcc)
    write_control_port();
    wait_for( VCC_SETUP_TIME);
}

static void set_clk( unsigned valor) {
    port.control.bits.C1 = ((valor == 0)? 0:1);     // C1 (clock)
    write_control_port();
    wait_for( CLK_HOLD_TIME);
}

static void set_vpp( unsigned valor) {
    port.control.bits.C2 = ((valor == 0)? 0:1);     // C2 (Vpp)
    write_control_port();
    wait_for( VPP_SETUP_TIME);
}

static void set_data( unsigned short valor) {
    port.data.bits.D3 = ((valor == 0)? 0:1);        // D3 (data)
    write_data_port();
}

static unsigned short get_data() {                  // D3 (0000 1000) 
    read_data_port();
    unsigned short valor = port.data.value;
    return ((0x0008 & valor) == 0)? 0 : 1;
}

static void rise_vcc() { set_vcc( VCC_HIGH); }
static void fall_vcc() { set_vcc(  VCC_LOW); }

static void rise_clk() { set_clk( CLK_HIGH); }
static void fall_clk() { set_clk(  CLK_LOW); }

static void rise_vpp() { set_vpp( VPP_HIGH); }
static void fall_vpp() { set_vpp(  VPP_LOW); }   


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
    int resultado = init_adaptador_pp( baseAddress, SERVER_WRITE);
    
    if ( resultado == 0) {
        reset_device();
    }
    
    return resultado;
}

int release_driver() {
    return release_adaptador_pp();
}


void reset_device() {
	printf("\n\tresetting_device");
    set_data( 0);
    fall_clk();
    fall_vpp();
    fall_vcc();
    printf("\n\tdevice is reseted\n");
}

void init_HVP_mode() {
    rise_vpp();
    rise_vcc();
}

unsigned short execute_command( unsigned short command, enum Tipo_Comando tipoComando, unsigned short data) {
    
    if( tipoComando == COMANDO_SIMPLE) {
        write_serial_data( command, COMMAND_SIZE);
        wait_for( COMMAND_EXECUTION_TIME);
        
        return 0;
    
    } else if( tipoComando == COMANDO_PROGRAMACION) {
        write_serial_data( command, COMMAND_SIZE);
        wait_for( COMMAND_PROGRAMMING_EXECUTION_TIME);
        
        return 0;
        
    } else if( tipoComando == COMANDO_ESCRITURA_DATO) {
        write_serial_data( command, COMMAND_SIZE);
        wait_for( COMMAND_SETUP_TIME);
        
        write_serial_data( data, DATA_SIZE);
        wait_for( COMMAND_EXECUTION_TIME);
    
        return 0;
        
    } else if( tipoComando == COMANDO_LECTURA_DATO) {
        write_serial_data( command, COMMAND_SIZE);
        wait_for( COMMAND_SETUP_TIME);
        
        unsigned short inputData = read_serial_data( DATA_SIZE, READ_DATA_SIZE);
        wait_for( INTER_COMMAND_TIME);
    
        return inputData;
    }
    return 0;
}
