#ifndef PROGRAMMING_INFO_HEADER

#define PROGRAMMING_INFO_HEADER


// tipos de datos

typedef struct {
    unsigned int startAddr;
    unsigned int    length;
    unsigned short *  data;

} BancoMemoria;

typedef struct {
    unsigned int    addr;
    unsigned char id[32];
    unsigned short value;
    unsigned short  read;
    unsigned short write;

} LocalidadMemoria;


typedef struct {
    BancoMemoria *  banks;
    unsigned short length;

} ArrayBancoMemoria; 

typedef struct {
    LocalidadMemoria * locations;
    unsigned short        length;

} ArrayLocalidadMemoria;

typedef struct {
    ArrayBancoMemoria program;
    ArrayBancoMemoria    data;
    ArrayLocalidadMemoria configuration;
    
} DeviceBuffer;


typedef struct {
	char values[10];
	int length;
} Arreglo;

typedef struct {
	char operation;
	Arreglo areas;
	Arreglo voltages;
	DeviceBuffer buffer;
} ProgrammingInfo;


void read_programming_info( ProgrammingInfo * ptrInfo, const char * filePath);

void write_programming_info( ProgrammingInfo * ptrInfo, const char * filePath);

#endif
