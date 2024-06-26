#include "device_buffer.h"

#include "pic16fxxx_driver.h"

#include <stdlib.h>
#include <stdio.h>

void initProgramMemory( DeviceBuffer *bufferPtr) {
       
    ArrayBancoMemoria * array = &(bufferPtr->program);
    
    array->banks  = (BancoMemoria *) malloc( 1 * sizeof( BancoMemoria));
    array->length = 1;
    
    BancoMemoria * bank = &(array->banks[0]);
    
    bank->startAddr = 0x0000;
    bank->length   = 0x0400;
    bank->data     = (short *) malloc( bank->length * sizeof( unsigned short));
    
    unsigned int i;
    
    for ( i = 0; i< bank->length; ++i) {
        bank->data[i] = 0x0000;
    }
}


void initDataMemory( DeviceBuffer *bufferPtr) {
       
    ArrayBancoMemoria * array = &(bufferPtr->data);
    
    array->banks  = (BancoMemoria *) malloc( 1 * sizeof( BancoMemoria));
    array->length = 1;
    
    BancoMemoria * bank = &(array->banks[0]);
    
    bank->startAddr = 0x00;
    bank->length   = 128;
    bank->data     = (short *) malloc( bank->length * sizeof( unsigned short));
    
    unsigned int i;
    
    for ( i = 0; i< bank->length; ++i) {
        bank->data[i] = i;
    }   
}

void initConfigurationMemory( DeviceBuffer *bufferPtr) {
    
    ArrayLocalidadMemoria * array = &(bufferPtr->configuration);
    
    unsigned int length = 8;
    
    array->locations = (LocalidadMemoria *) malloc( length * sizeof( LocalidadMemoria));
    array->length = length;
    
    array->locations[0].addr = 0x2000;
    array->locations[0].skip = 0,
    
    array->locations[1].addr = 0x2001;
    array->locations[1].skip = 0;
    
    array->locations[2].addr = 0x2002;
    array->locations[2].skip = 0;
    
    array->locations[3].addr = 0x2003;
    array->locations[3].skip = 0;
    
    array->locations[4].addr = 0x2004;
    array->locations[4].skip = 1;
    
    array->locations[5].addr = 0x2005;
    array->locations[5].skip = 1;
    
    array->locations[6].addr = 0x2006;
    array->locations[6].skip = 0;
    
    array->locations[7].addr  = 0x2007;
    array->locations[7].value = 0x3F19;
    array->locations[7].skip = 0;    
}








void read_program_memory( DeviceBuffer * bufferPtr) {
    
    ArrayBancoMemoria * array = &(bufferPtr->program);
    BancoMemoria * bank = &(array->banks[0]);
    
    unsigned short dato = 0x0000;
    unsigned int i;
   
    execute_command( CARGA_DATO_MEM_PROGRAMA);
    
    for ( i = 0; i < bank->length ; ++i) {
        bank->data[i] = execute_command( LEER_DATO_MEM_PROGRAMA);
        execute_command( INCREMENTA_DIRECCION);
    }
    
}

void read_data_memory( DeviceBuffer * bufferPtr) {
    
    ArrayBancoMemoria * array = &(bufferPtr->data);
    BancoMemoria * bank = &(array->banks[0]);
    
    unsigned short dato = 0x0000;
    unsigned int i;
   
    execute_command( CARGA_DATO_MEM_DATOS);
    
    for ( i = 0; i < bank->length ; ++i) {
        bank->data[i] = execute_command( LEER_DATO_MEM_DATOS);
        execute_command( INCREMENTA_DIRECCION);
    }
    
}

void read_config_memory( DeviceBuffer * bufferPtr) {
    
    ArrayLocalidadMemoria * configuration = &(bufferPtr->configuration);
    
    LocalidadMemoria * location;
    unsigned int i;
   
    unsigned short dato = 0x0000;
    execute_command( CARGA_DATO_MEM_CONFIG);
    
    for ( i = 0; i < configuration->length; ++i) {
        location = &(configuration->locations[i]);
        
        if( location->skip == 0) {
            location->value = execute_command( LEER_DATO_MEM_PROGRAMA);
        } else {
            location->value = 0x3FFF;
        }
        
        execute_command( INCREMENTA_DIRECCION);
    }
}



void write_program_memory( DeviceBuffer * bufferPtr) {
    
    ArrayBancoMemoria * array = &(bufferPtr->program);
    BancoMemoria * bank = &(array->banks[0]);
        
    unsigned short dato;
    unsigned int i;

    // Borrado: 1er. paso
    dato = 0x3FFF;
    execute_command( CARGA_DATO_MEM_PROGRAMA);
    
    // Borrado: 2o. paso
    execute_command( BULK_ERASE_MEM_PROGRAMA);
    
    for ( i = 0; i < bank->length; ++i) {
        dato = bank->data[i];
        execute_command( CARGA_DATO_MEM_PROGRAMA);
        execute_command( INICIA_CICLO_ERASE_PROGRAM);
        
        execute_command( INCREMENTA_DIRECCION);
        
        if( i % 102 == 101) {
            printf( "\n\tavance: %.2f %%", (i * 100.0)/bank->length);
        }
    }
}



void write_data_memory( DeviceBuffer * bufferPtr) {
    
    ArrayBancoMemoria * array = &(bufferPtr->data);
    BancoMemoria * bank = &(array->banks[0]);
        
    unsigned short dato;
    unsigned int i;

    // Borrado: 1er. paso
    execute_command( BULK_ERASE_MEM_DATOS);
    
    for ( i = 0; i < bank->length; ++i) {
        dato = bank->data[i];
        execute_command( CARGA_DATO_MEM_DATOS);
        execute_command( INICIA_CICLO_ERASE_PROGRAM);
        
        execute_command( INCREMENTA_DIRECCION);
        
        if( i % 11 == 10) {
            printf( "\n\tavance: %.2f %%", (i * 100.0)/bank->length);
        }
    }
}

void write_config_memory( DeviceBuffer * bufferPtr) {
    
    ArrayLocalidadMemoria * configuration = &(bufferPtr->configuration);
    
    LocalidadMemoria * location;
    unsigned int i;
   
    unsigned short dato = 0x0000;               // entra a memoria de configuracion
    execute_command( CARGA_DATO_MEM_CONFIG);
    
    for ( i = 0; i < 7; ++i) {
        execute_command( INCREMENTA_DIRECCION);
    }
    printf( "direccion %d ", i);
    
    location = &(configuration->locations[7]);
    dato = location->value;
    
    printf( "valor: 0x%x", dato);
    
    execute_command( CARGA_DATO_MEM_PROGRAMA);
    execute_command( INICIA_CICLO_ERASE_PROGRAM);
}
