#ifndef PROGRAM_INFO_HEADER

#define PROGRAM_INFO_HEADER


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
    unsigned short programmingType;         // 0: erase_program | 1: program only + end programming | 
    unsigned short bulkEraseType;           // e = [1 | 2 | 3 | ...], [1 | 2 | 3 | ...], [NNNN]
    unsigned short protectDsblType;         //
    unsigned short protectDsblData;         //
} ProgrammingOpts;

typedef struct {
	char      operation;
	Arreglo       areas;
	Arreglo    voltages;
    ProgrammingOpts options;

	DeviceBuffer buffer;

} ProgramInfo;


void read_program_info( ProgramInfo * ptrInfo, const char * filePath);

void write_program_info( ProgramInfo * ptrInfo, const char * filePath);

#endif
