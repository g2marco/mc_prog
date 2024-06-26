#include <stdio.h>
#include <inttypes.h>
#include <signal.h>

#include "device_buffer.h"
#include "pic16fxxx_driver.h"

#define BASE 0x378

FILE * log_file = NULL;

int running = 1;

void signalHandler(int sig) {
   running = 0;
}


void print_word( unsigned short data) {
    printf("%d%d %d%d%d%d %d%d%d%d %d%d%d%d", ((data&0x2000) == 0)? 0: 1, ((data&0x1000) == 0)? 0: 1, ((data&0x0800) == 0)? 0: 1, ((data&0x0400) == 0)? 0: 1, ((data&0x0200) == 0)? 0: 1, ((data&0x0100) == 0)? 0: 1, ((data&0x0080) == 0)? 0: 1, ((data&0x0040) == 0)? 0: 1, ((data&0x0020) == 0)? 0: 1, ((data&0x0010) == 0)? 0: 1, ((data&0x0008) == 0)? 0: 1, ((data&0x0004) == 0)? 0: 1, ((data&0x0002) == 0)? 0: 1, ((data&0x0001) == 0)? 0: 1);
}

void print_byte( unsigned short data) {
    printf("%d%d%d%d %d%d%d%d", ((data&0x0080) == 0)? 0: 1, ((data&0x0040) == 0)? 0: 1, ((data&0x0020) == 0)? 0: 1, ((data&0x0010) == 0)? 0: 1, ((data&0x0008) == 0)? 0: 1, ((data&0x0004) == 0)? 0: 1, ((data&0x0002) == 0)? 0: 1, ((data&0x0001) == 0)? 0: 1);
}

int main(void) {
    
    printf("\nPrueba de Driver PIC16FXXX usando el puerto paralelo (Base: 0x%x)\n", BASE);
    signal(SIGINT, signalHandler);
    
    int resultado = init_driver( BASE);
    if ( resultado != 0) {
        return resultado;
    }

    DeviceBuffer buffer;
    initProgramMemory( &buffer);
    initDataMemory( &buffer);
    initConfigurationMemory( &buffer);
    
    
    //
    printf( "\n\n\tEscritura de memoria de programa");
    init_HVP_mode();
    write_program_memory( &buffer);
    reset_device();
    //
    printf( "\n\n\tEscritura de memoria de configuracion");
    init_HVP_mode();
    write_config_memory( &buffer);
    reset_device();
    //
    printf( "\n\n\tEscritura de memoria de datos");
    init_HVP_mode();
    write_data_memory( &buffer);
    reset_device();
    //
    
  
    //
    printf( "\n\n\tLectura de Memoria de Configuraci�n");
    init_HVP_mode();
    read_config_memory( &buffer);
    reset_device();
    //
    
    unsigned int i = 0;
    for ( i = 0; i < buffer.configuration.length; ++i) {
        LocalidadMemoria location = buffer.configuration.locations[i];
        printf( "\naddress 0x%x[%d]: ", location.addr, location.skip);
        print_word( location.value);
    }
    
    //
    printf( "\n\n\tLectura de Memoria de Programa");
    init_HVP_mode();
    read_program_memory( &buffer);
    reset_device();
    //
    
    BancoMemoria bank = buffer.program.banks[0];
    for ( i = 0; i < bank.length; ++i) {
        printf( "\naddress 0x%x: ", bank.startAddr + i);
        print_word( bank.data[i]);
    }
  
  
    //
    printf( "\n\n\tLectura de Memoria de Datos");
    init_HVP_mode();
    read_data_memory( &buffer);
    reset_device();
    //
    
    bank = buffer.data.banks[0];
    for ( i = 0; i < bank.length; ++i) {
        printf( "\naddress 0x%x: ", bank.startAddr + i);
        print_byte( bank.data[i]);
    }
    //
    
    printf( "\n");
    
    return release_driver();
}
