#include <stdio.h>
#include "program_info.h"

FILE * log_file = NULL;

int main(void) {
	printf( "\nPrueba de Lectura y escritura de Tarea de programacion\n");

	ProgrammingInfo info;

	printf( "\n\t - Lectura de archivo de peticion");
	read_programming_info( &info, "programming_info_request.txt");

	printf( "\n\t - Escritura de archivo de respuesta");
	write_programming_info( &info, "programming_info_response.txt");

	printf( "\n\nPrueba terminada con exito\n");

	return 0;
}
