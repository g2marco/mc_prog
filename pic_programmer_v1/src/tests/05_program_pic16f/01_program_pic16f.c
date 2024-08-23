#include <stdio.h>

#include "program_info.h"
#include "program_pic16f.h"

FILE * log_file = NULL;

int main( int argc, char* argv[]) {

    printf("\nPrueba de Programador PIC16FXXX");

    ProgramInfo info;

    // carga archivo indicado en linea de comandos

    printf( "\n\t - Lectura de archivo de peticion");
    read_programming_info( &info, argv[1]);

    if ( info.operation == 'p') {
        printf( "\n\t - Ejecución de tarea de programacion");
        execute_programming_task( &info);
    
        info.operation = 'r';
    }

    printf( "\n\t - Ejecución de tarea de lectura");
    execute_programming_task( &info);

    printf( "\n\t - Escritura de archivo de respuesta");
    write_programming_info( &info, "program_info_response.txt");

    printf( "\n\nPrueba terminada con exito\n");
	
	printf("\n");
	
    return 0;

}
