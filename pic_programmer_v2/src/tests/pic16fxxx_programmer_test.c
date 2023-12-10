#include <stdio.h>

#include "../../programming_info/programming_info.h"
#include "../pic16fxxx_programmer.h"

FILE * log_file = NULL;

int main(void) {

    printf("\nPrueba de Programador PIC16FXXX");

    ProgrammingInfo info;

    printf( "\n\t - Lectura de archivo de peticion");
    read_programming_info( &info, "./programming_info_request.txt");

	printf( "\n\t - Ejecución de tarea de programacion");
    execute_programming_task( &info);

    printf( "\n\t - Escritura de archivo de respuesta");
    write_programming_info( &info, "programming_info_response.txt");

    printf( "\n\nPrueba terminada con exito\n");
	
	printf("\n");
	
    return 0;

}
