
#include <stdio.h>
#include <stdlib.h>

#include "program_info.h"


static void create_program_buffer( int longitud, DeviceBuffer * buffer) {
	ArrayBancoMemoria * array = &(buffer->program);

	array->banks = (BancoMemoria *) malloc( longitud * sizeof( BancoMemoria));
	array->length = longitud;
}

static void create_data_buffer( int longitud, DeviceBuffer * buffer) {
	ArrayBancoMemoria * array = &(buffer->data);

	array->banks = (BancoMemoria *) malloc( longitud * sizeof( BancoMemoria));
	array->length = longitud;
}

static void create_configuration_buffer( int longitud, DeviceBuffer * buffer) {
	ArrayLocalidadMemoria * array = &(buffer->configuration);

	array->locations = (LocalidadMemoria *) malloc( longitud * sizeof( LocalidadMemoria));
	array->length = longitud;
}

static int obtener_indice( char caracter) {
	char string[2] = { caracter, '\0'};
	return atoi( string);
}

static int read_integer( FILE * file) {
	int data;
	fscanf( file, "%d", &data);
	return data;
}

static void read_string(char * data, FILE * file) {
	fscanf( file, "%s", data);
}

static unsigned short * read_arreglo( int length, FILE * file) {
	unsigned short * array = (unsigned short *) malloc( length * sizeof( unsigned short));

	int i = 0;

	for( i = 0; i < length; ++i) {
		array[ i] = read_integer( file);
		fgetc( file);
	}

	return array;
}

static void init_arreglo_areas( FILE * file, DeviceBuffer * buffer, Arreglo * areas) {
	fgetc( file);
	char caracter;
	int terminar = 0;
	int indice = 0;

	do {
		switch( fgetc( file) ) {
		case ',': break;
		case 'p':
			create_program_buffer( read_integer( file), buffer);
			areas->values[indice++] = 'p';
			break;

		case 'd':
			create_data_buffer( read_integer( file), buffer);
			areas->values[indice++] = 'd';
			break;

		case 'c':
			create_configuration_buffer( read_integer( file), buffer);
			areas->values[indice++] = 'c';
			break;

		default:
			terminar = 1;
			break;
		}

	} while( terminar == 0);

	areas->length = indice;
}

static void init_arreglo_voltajes( FILE * file, Arreglo * areas) {
	fgetc( file);
	char caracter;
	int terminar = 0;
	int indice = 0;

	do {
		switch( fgetc( file) ) {
		case ',': break;
		case 'l':
			areas->values[indice++] = 'l';
			break;
		case 'n':
			areas->values[indice++] = 'n';
			break;
		case 'h':
			areas->values[indice++] = 'h';
			break;
		default:
			terminar = 1;
			break;
		}
	} while( terminar == 0);

	areas->length = indice;
}


static char init_operacion( char caracter) {
	if( caracter == 'r' || caracter == 'p') {
		return caracter;
	} else {
		return -1;
	}
}

static void init_program_buffer ( int indice, FILE * file, DeviceBuffer * buffer) {

	ArrayBancoMemoria * array = &(buffer->program);
	BancoMemoria * bank = &(array->banks[ indice]);

	switch( fgetc( file)) {
	case 'i':
		fgetc( file);
		bank->startAddr = read_integer( file);
		break;

	case 'l':
		fgetc( file);
		bank->length = read_integer( file);
		break;

	case 'v':
		fgetc( file);
		bank->data = read_arreglo( bank->length, file);
		break;
	}
}

static void init_data_buffer ( int indice, FILE * file, DeviceBuffer * buffer) {

	ArrayBancoMemoria * array = &(buffer->data);
	BancoMemoria * bank = &(array->banks[ indice]);

	switch( fgetc( file)) {
	case 'i':
		fgetc( file);
		bank->startAddr = read_integer( file);
		break;

	case 'l':
		fgetc( file);
		bank->length = read_integer( file);
		break;

	case 'v':
		fgetc( file);
		bank->data = read_arreglo( bank->length, file);
		break;
	}
}

static void init_configuration_location ( int indice, FILE * file, DeviceBuffer * buffer) {

	ArrayLocalidadMemoria * array = &(buffer->configuration);

	switch( fgetc( file)) {
	case 'a':
		fgetc( file);
	    array->locations[ indice].addr = read_integer( file);
		break;

	case 'i':
		fgetc( file);
		read_string(array->locations[ indice].id, file);
		break;

	case 'v':
		fgetc( file);
		array->locations[ indice].value = read_integer( file);
		break;

	case 'r':
		fgetc( file);
		array->locations[ indice].read = ((fgetc( file) == 't')? 1 : 0);
		break;

	case 'w':
		fgetc( file);
		array->locations[ indice].write = ((fgetc( file) == 't')? 1 : 0);
		break;
	}
}


static void write_device_buffer( FILE * file, DeviceBuffer * buffer) {
	BancoMemoria * banco;
	ArrayBancoMemoria * array;
	int i = 0;
	int j = 0;

	array = &(buffer->program);

	for( i = 0; i < array->length; ++i) {
		banco = &(array->banks[i]);

		fprintf( file, "\np%di=%d", i, banco->startAddr);
		fprintf( file, "\np%dl=%d", i,  banco->length);
		fprintf( file, "\np%dv=", i);

		for ( j = 0; j < banco->length; ++j) {
			if( j > 0) {
				fprintf( file, ",");
			}
			fprintf( file, "%d", banco->data[j]);
		}
	}

	array = &(buffer->data);
	
	for( i = 0; i < array->length; ++i) {
		banco = &(array->banks[i]);

		fprintf( file, "\nd%di=%d", i, banco->startAddr);
		fprintf( file, "\nd%dl=%d", i,  banco->length);
		fprintf( file, "\nd%dv=", i);

		for ( j = 0; j < banco->length; ++j) {
			if( j > 0) {
				fprintf( file, ",");
			}
			fprintf( file, "%d", banco->data[j]);
		}
	}

	ArrayLocalidadMemoria * config = &(buffer->configuration);
	LocalidadMemoria * localidad;

	for( i = 0; i < config->length; ++i) {
		localidad = &(config->locations[i]);

		fprintf( file, "\nc%da=%d", i, localidad->addr);
		fprintf( file, "\nc%di=%s", i, localidad->id);
		fprintf( file, "\nc%dv=%d", i, localidad->value);
		fprintf( file, "\nc%dr=%s", i, ((localidad->read  == 1)? "true" : "false"));
		fprintf( file, "\nc%dw=%s", i, ((localidad->write == 1)? "true" : "false"));
	}
}


extern FILE * log_file;

void read_programming_info( ProgramInfo * ptrInfo, const char * filePath) {

	FILE * file = fopen( filePath, "r");

	if ( file == NULL) {
		fprintf( ((log_file == NULL)? stderr : log_file), "No es posible abrir archivo para lectura: %s", filePath);
		return;
	}

	int indice = 0;
	char caracter;

	while ( (caracter = fgetc( file)) != EOF) {
		switch (caracter) {

		case 'a':
			init_arreglo_areas( file, &(ptrInfo->buffer), &(ptrInfo->areas));
			break;

		case 'c':
			indice = obtener_indice( fgetc( file));
			init_configuration_location( indice, file, &(ptrInfo->buffer));
			break;

		case 'd':
			indice = obtener_indice( fgetc( file));
			init_data_buffer( indice, file, &(ptrInfo->buffer));
			break;

		case 'o':
			fgetc( file);
			ptrInfo->operation = init_operacion( fgetc(file));
			break;

		case 'p':
			indice = obtener_indice( fgetc( file));
			init_program_buffer( indice, file, &(ptrInfo->buffer));
			break;

		case 'v':
			init_arreglo_voltajes( file, &(ptrInfo->voltages));
			break;
		}
	}

	fclose( file);
}

void write_programming_info( ProgramInfo * ptrInfo, const char * filePath) {

	FILE * file = fopen( filePath, "w");

	if ( file == NULL) {
		fprintf ( ((log_file == NULL)? stderr : log_file), "No es posible abrir archivo para escritura: %s", filePath);
		return;
	}

	int i = 0;

	fprintf( file, "o=%c", ptrInfo->operation);

	fprintf( file, "\na=");

	for ( i = 0; i < (ptrInfo->areas).length; ++i) {
		if( i > 0) {
			fprintf( file, ",");
		}
		fprintf( file, "%c", (ptrInfo->areas).values[i]);
	}

	fprintf( file, "\nv=");

	for ( i = 0; i < (ptrInfo->voltages).length; ++i) {
		if( i > 0) {
			fprintf( file, ",");
		}
		fprintf( file, "%c", (ptrInfo->voltages).values[i]);
	}

	write_device_buffer( file, &(ptrInfo->buffer));

	fclose( file);
}
