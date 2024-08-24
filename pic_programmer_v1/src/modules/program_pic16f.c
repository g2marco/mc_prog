
#include <stdio.h>

#include "driver_pic16f.h"
#include "program_info.h"
#include "program_pic16f.h"


#define BASE 0x378


static void read_program_memory( DeviceBuffer * buffer) {
    ArrayBancoMemoria * array = &(buffer->program);
    BancoMemoria * bank = &(array->banks[0]);

    unsigned short dato = 0x0000;
    unsigned int i;

    execute_command( CARGA_DATO_MEM_PROGRAMA);

    for ( i = 0; i < bank->length ; ++i) {
        bank->data[i] = execute_command( LEER_DATO_MEM_PROGRAMA);
        execute_command( INCREMENTA_DIRECCION);
    }

}

static void read_data_memory( DeviceBuffer * buffer) {
    ArrayBancoMemoria * array = &(buffer->data);
    BancoMemoria * bank = &(array->banks[0]);

    unsigned short dato = 0x0000;
    unsigned int i;

    execute_command( CARGA_DATO_MEM_DATOS);

    for ( i = 0; i < bank->length ; ++i) {
        bank->data[i] = execute_command( LEER_DATO_MEM_DATOS);
        execute_command( INCREMENTA_DIRECCION);
    }
}

static unsigned int read_device_id() {
    unsigned short dato = 0x0000;
    execute_command( CARGA_DATO_MEM_CONFIG);
    int i;
    for ( i = 0; i < 6; ++i) {    
		execute_command( INCREMENTA_DIRECCION);
    }

    unsigned short value = execute_command( LEER_DATO_MEM_PROGRAMA);

    value = value & 0xFFE0;
    printf( "\n\tdevice id: %d", value);

    return value;
}

static void read_config_memory( DeviceBuffer * buffer) {
    ArrayLocalidadMemoria * configuration = &(buffer->configuration);

    LocalidadMemoria * location;
    unsigned int i;

    unsigned short dato = 0x0000;
    execute_command( CARGA_DATO_MEM_CONFIG);

    for ( i = 0; i < configuration->length; ++i) {
        location = &(configuration->locations[i]);

        if( location->read == 1) {
            location->value = execute_command( LEER_DATO_MEM_PROGRAMA);
			printf( "\n\tlocation %d, value: %d", i, location->value);
			
        } else {
			location->value = 0x3FFF;
        }

        execute_command( INCREMENTA_DIRECCION);
    }
}

static void write_program_memory( DeviceBuffer * bufferPtr) {
	printf( "\n >> inicia: write_program_memory");

    ArrayBancoMemoria * array = &(bufferPtr->program);
    BancoMemoria * bank = &(array->banks[0]);

    unsigned short dato;
    unsigned int i;
/*
    // Borrado: 1er. paso
    dato = 0x3FFF;
    execute_command( CARGA_DATO_MEM_PROGRAMA);

    // Borrado: 2o. paso
    execute_command( BULK_ERASE_MEM_PROGRAMA);

    //
    //   TODO: find a way to implement this variation
    //

    // Borrado: 3er paso                            // NOTA: este paso es solamente para el PIC 16F84A
    execute_command( INICIA_CICLO_ERASE_PROGRAM);

    wait_for( 20000);
    //
    //
    //

    printf( "\n >> avoiding program write");
*/
    for ( i = 0; i < bank->length; ++i) {
        dato = bank->data[i];
        
        printf( "\n\twriting %d", dato);

        execute_command( CARGA_DATO_MEM_PROGRAMA);
        execute_command( INICIA_CICLO_ERASE_PROGRAM);

        execute_command( INCREMENTA_DIRECCION);
    }
  
    printf( "\n >> termina: write_program_memory");
}

static void write_data_memory( DeviceBuffer * bufferPtr) {
	printf( "\n >> inicia: write_data_memory");

    ArrayBancoMemoria * array = &(bufferPtr->data);
    BancoMemoria * bank = &(array->banks[0]);

    unsigned short dato;
    unsigned int i;

    //   PIC16F84
    //   TODO: find a way to implement this variation
    //
/*    
        // Borrado: 1er. paso
        dato = 0xFFFF;
        execute_command( CARGA_DATO_MEM_DATOS);

        // Borrado: 2o. paso
        execute_command( BULK_ERASE_MEM_DATOS);
        
        // Borrado: 3er paso                         
        execute_command( INICIA_CICLO_ERASE_PROGRAM);

    //
    //
    //

    //
    //  PIC 12F683
    //

    // Borrado: 1er. paso
    //execute_command( BULK_ERASE_MEM_DATOS);

    //
    //
    //
/*
    for ( i = 0; i < bank->length; ++i) {
        dato = bank->data[i];
        execute_command( CARGA_DATO_MEM_DATOS);
        execute_command( INICIA_CICLO_ERASE_PROGRAM);

        execute_command( INCREMENTA_DIRECCION);
    }
*/

    printf( "\n >> termina: write_data_memory");
}

static void write_config_memory( DeviceBuffer * bufferPtr) {
	printf( "\n >> inicia: write_config_memory");

	ArrayLocalidadMemoria * configuration = &(bufferPtr->configuration);

    LocalidadMemoria * location;
    unsigned int i;

    unsigned short dato = 0x0000;               // entra a memoria de configuracion
    execute_command( CARGA_DATO_MEM_CONFIG);

    for ( i = 0; i < 7; ++i) {
		printf( "\n\t\tinc addr");
        execute_command( INCREMENTA_DIRECCION);
    }
	
    location = &(configuration->locations[7]);
    dato = location->value;
	
	printf( "\n\t\tdata(write): %d", dato);
	
    execute_command( CARGA_DATO_MEM_PROGRAMA);
    execute_command( INICIA_CICLO_ERASE_PROGRAM);

	printf( "\n\t\tdata(read): %d", execute_command( LEER_DATO_MEM_PROGRAMA));
	
    printf( "\n << termina: write_config_memory");
}


int execute_programming_task( ProgramInfo * ptrInfo) {

	int resultado = init_driver( BASE);
	if ( resultado != 0) {
		return resultado;
	}

    //unsigned int deviceId = obtener_device_id();

	char operation = ptrInfo->operation;

	int idxArea = 0;
	Arreglo areas = ptrInfo->areas;

	int idxVoltage = 0;
	Arreglo voltages = ptrInfo->voltages;

    
	for ( idxVoltage = 0; idxVoltage < voltages.length; ++idxVoltage) {
		
		// memoria de programa
		
		for ( idxArea = 0; idxArea < areas.length ; ++idxArea) {
			
			if ( areas.values[ idxArea] == 'p') {
			
				init_HVP_mode();
				
				if (operation == 'r') {
					read_program_memory( &(ptrInfo->buffer));
				} else {
					write_program_memory( &(ptrInfo->buffer));
				}
				
				reset_device();
			}
		}
		
		// memoria de datos 
		
		for ( idxArea = 0; idxArea < areas.length ; ++idxArea) {
			
			if ( areas.values[ idxArea] == 'd') {
				
				init_HVP_mode();

				if (operation == 'r') {
					read_data_memory( &(ptrInfo->buffer));
				} else {
					write_data_memory( &(ptrInfo->buffer));
				}
				
				reset_device();
			}
		}
		
		// memoria de configuracion
		
		for ( idxArea = 0; idxArea < areas.length ; ++idxArea) {
			
			if ( areas.values[ idxArea] == 'c') {
				
				init_HVP_mode();
				
				if (operation == 'r') {
					read_config_memory( &(ptrInfo->buffer));
				} else {
					write_config_memory( &(ptrInfo->buffer));
				}
				
				reset_device();
			}
		}
		
	}

	return;
}
