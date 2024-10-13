
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

        } else {
			location->value = 0x3FFF;
        }

        execute_command( INCREMENTA_DIRECCION);
    }
}

static void write_program_memory( DeviceBuffer * bufferPtr, unsigned short bulkEraseType) {
    ArrayBancoMemoria * array = &(bufferPtr->program);
    BancoMemoria * bank = &(array->banks[0]);

    unsigned short dato;
    unsigned int i;

    bulk_erase_program_memory( bulkEraseType);

    for ( i = 0; i < bank->length; ++i) {
        dato = bank->data[i];
        execute_command( CARGA_DATO_MEM_PROGRAMA);
        execute_command( INICIA_CICLO_ERASE_PROGRAM);

        execute_command( INCREMENTA_DIRECCION);
    }
}

static void write_data_memory( DeviceBuffer * bufferPtr, unsigned short bulkEraseType) {
    ArrayBancoMemoria * array = &(bufferPtr->data);
    BancoMemoria * bank = &(array->banks[0]);

    unsigned short dato;
    unsigned int i;

    bulk_erase_data_memory( bulkEraseType);
       
    for ( i = 0; i < bank->length; ++i) {
        dato = bank->data[i];
        execute_command( CARGA_DATO_MEM_DATOS);
        execute_command( INICIA_CICLO_ERASE_PROGRAM);

        execute_command( INCREMENTA_DIRECCION);
    }
}

static void write_config_memory( DeviceBuffer * bufferPtr) {
	ArrayLocalidadMemoria * configuration = &(bufferPtr->configuration);

    LocalidadMemoria * location;
    unsigned int i;

    unsigned short dato = 0x0000;               // entra a memoria de configuracion
    execute_command( CARGA_DATO_MEM_CONFIG);

    for ( i = 0; i < 7; ++i) {
        execute_command( INCREMENTA_DIRECCION);
    }
	
    location = &(configuration->locations[7]);
    dato = location->value;
	
    execute_command( CARGA_DATO_MEM_PROGRAMA);
    execute_command( INICIA_CICLO_ERASE_PROGRAM);
}

int reset_programmer() {
    int resultado = init_driver( BASE);
	if ( resultado != 0) {
		return resultado;
	}
    
    reset_device();

    return release_driver();
}

int execute_programming_task( ProgramInfo * ptrInfo) {

	int resultado = init_driver( BASE);
	if ( resultado != 0) {
		return resultado;
	}

	char operation = ptrInfo->operation;

	int idxArea = 0;
	Arreglo areas = ptrInfo->areas;

	int idxVoltage = 0;
	Arreglo voltages = ptrInfo->voltages;

	for ( idxVoltage = 0; idxVoltage < voltages.length; ++idxVoltage) {
		// memoria de configuracion
		
		for ( idxArea = 0; idxArea < areas.length ; ++idxArea) {
			
			if ( areas.values[ idxArea] == 'c') {
				
				init_HVP_mode();
				
                switch ( operation) {
                    case 'r': read_config_memory(  &(ptrInfo->buffer)); break;
                    case 'p': write_config_memory( &(ptrInfo->buffer)); break;
                    case 'e': disable_code_protection( &(ptrInfo->eraseOpts)); break;
				}
				
				reset_device();
			}
		}

		// memoria de programa
		
		for ( idxArea = 0; idxArea < areas.length ; ++idxArea) {
			
			if ( areas.values[ idxArea] == 'p') {
			
				init_HVP_mode();
				
				switch ( operation) {
                    case 'r': read_program_memory(  &(ptrInfo->buffer)); break;
                    case 'p': write_program_memory( &(ptrInfo->buffer), (ptrInfo->eraseOpts).bulkEraseType); break;
				}
				
				reset_device();
			}
		}
		
		// memoria de datos 
		
		for ( idxArea = 0; idxArea < areas.length ; ++idxArea) {
			
			if ( areas.values[ idxArea] == 'd') {
				
				init_HVP_mode();

                switch ( operation) {
                    case 'r': read_data_memory(  &(ptrInfo->buffer   )); break;
    				case 'p': write_data_memory( &(ptrInfo->buffer   ), (ptrInfo->eraseOpts).bulkEraseType); break;                 
				}
				
				reset_device();
			}
		}
	}

	release_driver();
}
