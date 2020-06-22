#include "puerto_paralelo.h"

#include <stdio.h>
#include <sys/io.h>

//  definiciones internas

static void read_control_port() {
    port.control.value = inb( port.baseAddress + 2);
}

//  definiciones globales

PuertoParalelo port;

extern FILE * log_file;

//  implementación de métodos

int init_puerto_paralelo( unsigned short direccionBase) {

    port.baseAddress = direccionBase;
    
    fprintf( ((log_file == NULL)? stdout : log_file), "\n Solicitando acceso al puerto paralelo: ...");
    
    int resultado = ioperm( port.baseAddress, 4, 1);
    if (resultado != 0) {

        fprintf( ((log_file == NULL)? stderr: log_file), "ERROR: Could not set permissions on ports\n");
        return resultado;
    }
    
    fprintf( ((log_file == NULL)? stdout : log_file), "[OK]");
    
    read_data_port();
    read_status_port();
    read_control_port();
    
    return 0;
}

int release_puerto_paralelo() {
    
    fprintf( ((log_file == NULL)? stdout : log_file), "\n Liberando acceso al puerto paralelo: ...");
    
    int resultado = ioperm( port.baseAddress, 4, 0);

    if (resultado != 0) {
        fprintf( ((log_file == NULL)? stderr : log_file), "ERROR: Could not clear permissions on ports\n");
    } else {
        fprintf( ((log_file == NULL)? stdout : log_file), "[OK]\n");
    }
    
    return resultado;
}

void write_data_port() {
    outb( port.data.value, port.baseAddress);
}

void read_data_port() {
    port.data.value = inb( port.baseAddress);
}

void read_status_port() {
    port.status.value = inb( port.baseAddress + 1);
}

void write_control_port() {
    outb( port.control.value, port.baseAddress + 2);
}

void print_registros() {
    fprintf( ((log_file == NULL)? stdout : log_file), "\n\tdata   : %d%d%d%d %d%d%d%d", port.data.bits.D7, port.data.bits.D6, port.data.bits.D5, port.data.bits.D4, port.data.bits.D3, port.data.bits.D2, port.data.bits.D1, port.data.bits.D0);
    fprintf( ((log_file == NULL)? stdout : log_file), "\n\tstatus : %d%d%d%d %dxxx", port.status.bits.S7, port.status.bits.S6, port.status.bits.S5, port.status.bits.S4, port.status.bits.S3);
    fprintf( ((log_file == NULL)? stdout : log_file), "\n\tcontrol: xx%dx %d%d%d%d\n", port.control.bits.C5, port.control.bits.C3, port.control.bits.C2, port.control.bits.C1, port.control.bits.C0);

}
