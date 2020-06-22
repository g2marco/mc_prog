#include "adaptador_pp.h"

#include "../puerto_paralelo/puerto_paralelo.h"


// definiciones internas

static enum Modo_Operacion_Adaptador modo_operacion;

static void set_write_mode_adaptador() {
    port.control.bits.C3 = 1;
    write_control_port();
    
    port.control.bits.C5 = 0;
    write_control_port();
}

static void set_read_mode_adaptador() {
    port.control.bits.C5 = 1;
    write_control_port();
    
    port.control.bits.C3 = 0;
    write_control_port();
}

// variables externas


// definiciones públicas

int init_adaptador_pp( unsigned short baseAddress, enum Modo_Operacion_Adaptador modo) {
    
    modo_operacion = modo;
    
    int resultado = init_puerto_paralelo( baseAddress);
    
    if ( resultado != 0) {
        return resultado;
    }
    
    if( modo_operacion == PERIPHERIC_READ) {
        set_read_mode_adaptador();
        
    } else if( modo_operacion == SERVER_WRITE) {
        set_write_mode_adaptador();
    
    }

    return 0;
}

int release_adaptador_pp() {
    set_write_mode_adaptador();
    
    return release_puerto_paralelo();
}


void start_write_mode() {
    if ( modo_operacion == PERIPHERIC_READ) {
        set_write_mode_adaptador();
    }
}

void end_write_mode() {
    if ( modo_operacion == PERIPHERIC_READ) {
       set_read_mode_adaptador();
    }
}

void start_read_mode() {
    if ( modo_operacion == SERVER_WRITE) {
       set_read_mode_adaptador();
    }
}

void end_read_mode() {
    if ( modo_operacion == SERVER_WRITE) {
        set_write_mode_adaptador();
    }
}
