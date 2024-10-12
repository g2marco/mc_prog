
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

    if ( memoryArea == 'd') {
        // bulk erase
        execute_command( BULK_ERASE_MEM_DATOS);
    }
}

/**
 *  bulk erase tipo 2
 *  
 *  devices: PIC16F84A
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
        execute_command ( INICIA_CICLO_PROGRAM  );

        wait_for( 10000);
    }

    if ( memoryArea == 'd') {
        // load 1's
        dato = 0x3FFF;
        execute_command( CARGA_DATO_MEM_DATOS );

        // bulk erase
        execute_command( BULK_ERASE_MEM_DATOS );

        // begin programming
        execute_command ( INICIA_CICLO_PROGRAM);
        
        wait_for( 10000);
    }
}

/**
 *  disable code protection tipo 1
 *  
 *  devices: 
 */
static void disable_code_protection_type_1( unsigned short dato) {

}

void disable_code_protection( EraseOpts * eraseOpts) {
    switch( eraseOpts->protectDsblType) {
        case 1: disable_code_protection_type_1( eraseOpts->protectDsblData);
        case 2: disable_code_protection_type_2( eraseOpts->protectDsblData);
    }
}

void bulk_erase_program_memory( unsigned short bulkEraseType) {
    switch( bulkEraseType) {
        case 1: bulk_erase_type_1( 'p');  break;
        case 2: bulk_erase_type_2( 'p');  break;
    }
}

void bulk_erase_data_memory( unsigned short bulkEraseType) {
    switch( bulkEraseType) {
        case 1: bulk_erase_type_1( 'd');  break;
        case 2: bulk_erase_type_2( 'd');  break;
    }
}

