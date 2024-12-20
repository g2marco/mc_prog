
#include <stdio.h>

#include "driver_pic16f.h"
#include "program_info.h"
#include "program_pic16f.h"

/**
 *  bulk erase tipo 1
 * 
 *  devices:   PIC12F683
 */
static void bulk_erase_type_1( unsigned char memoryArea) {
    unsigned short dato;
    
    if ( memoryArea == 'p') { 
        // load 1's
        dato = 0x3FFF;
        execute_command( CARGA_DATO_MEM_PROGRAMA);

        // bulk erase
        execute_command( BULK_ERASE_MEM_PROGRAMA);
    }

    if ( memoryArea == 'c') { 
        // load 1's
        dato = 0x3FFF;
        execute_command( CARGA_DATO_MEM_CONFIG);

        // bulk erase
        execute_command( BULK_ERASE_MEM_PROGRAMA);
    }

    if ( memoryArea == 'd') {
        // bulk erase
        execute_command( BULK_ERASE_MEM_DATOS);
    }
}

/**
 *  bulk erase tipo 2
 *  
 *  devices: PIC16F84A, PIC16F874A
 */
static void bulk_erase_type_2( unsigned char memoryArea) {
    unsigned short dato;
    
    if ( memoryArea == 'p') { 
        // load 1's
        dato = 0x3FFF;
        execute_command( CARGA_DATO_MEM_PROGRAMA);

        // bulk erase 
        execute_command( BULK_ERASE_MEM_PROGRAMA);

        // begin programming
        execute_command( INICIA_CICLO_ERASE_PROGRAM);

        wait_for( 10000);
    }

    if ( memoryArea == 'c') { 
        // load 1's
        dato = 0x3FFF;
        execute_command( CARGA_DATO_MEM_CONFIG);

        // bulk erase 
        execute_command( BULK_ERASE_MEM_PROGRAMA);

        // begin programming
        execute_command( INICIA_CICLO_ERASE_PROGRAM);

        wait_for( 10000);
    }

    if ( memoryArea == 'd') {
        // load 1's
        dato = 0x3FFF;
        execute_command( CARGA_DATO_MEM_DATOS );

        // bulk erase
        execute_command( BULK_ERASE_MEM_DATOS );

        // begin programming
        execute_command( INICIA_CICLO_ERASE_PROGRAM);
        
        wait_for( 10000);
    }
}

/**
 *  disable code protection tipo 1
 *  
 *  devices: PIC12F683
 */
static void disable_code_protection_type_1( unsigned short dato) {
    execute_command( CARGA_DATO_MEM_CONFIG  );
    execute_command( BULK_ERASE_MEM_PROGRAMA);

    execute_command( CARGA_DATO_MEM_CONFIG  );
    execute_command( BULK_ERASE_MEM_PROGRAMA);

    execute_command( CARGA_DATO_MEM_CONFIG  );
    execute_command( BULK_ERASE_MEM_DATOS);
}

/**
 *  disable code protection tipo 2
 *  
 *  devices: PIC16F84A
 */
static void disable_code_protection_type_2( unsigned short dato) {
    
    // carga palabra de configuracion
    execute_command( CARGA_DATO_MEM_CONFIG);
    unsigned int i;

    for( i = 0; i < 7 ; ++i) {
        execute_command( INCREMENTA_DIRECCION);
    }
    
    execute_command( 0x01, COMANDO_SIMPLE, 0);
    execute_command( 0x07, COMANDO_SIMPLE, 0);
    
    execute_command( INICIA_CICLO_ERASE_PROGRAM);
    wait_for( 10000);

    execute_command( 0x01, COMANDO_SIMPLE, 0);
    execute_command( 0x07, COMANDO_SIMPLE, 0);
}

/**
 *  disable code protection tipo 3
 *
 *  devices: PIC16F874A
 */
static void disable_code_protection_type_3( unsigned short dato) {
    dato = 0x3FFF;
    execute_command( CARGA_DATO_MEM_CONFIG);
    execute_command( 0x1F, COMANDO_PROGRAMACION, 0);        // chip erase
    
    wait_for( 10000);
}

void disable_code_protection( ProgrammingOpts * options) {
    switch( options->protectDsblType) {
        case 1: disable_code_protection_type_1( options->protectDsblData);
        case 2: disable_code_protection_type_2( options->protectDsblData);
        case 3: disable_code_protection_type_3( options->protectDsblData);
    }
}

void bulk_erase_program_memory( unsigned short bulkEraseType) {
    switch( bulkEraseType) {
        case 1: bulk_erase_type_1( 'p');  break;
        case 2: bulk_erase_type_2( 'p');  break;
    }
}

void bulk_erase_config_memory( unsigned short bulkEraseType) {
    switch( bulkEraseType) {
        case 1: bulk_erase_type_1( 'c');  break;
        case 2: bulk_erase_type_2( 'c');  break;
    }
}

void bulk_erase_data_memory( unsigned short bulkEraseType) {
    switch( bulkEraseType) {
        case 1: bulk_erase_type_1( 'd');  break;
        case 2: bulk_erase_type_2( 'd');  break;
    }
}

