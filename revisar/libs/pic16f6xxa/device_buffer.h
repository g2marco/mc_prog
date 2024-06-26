#ifndef DEVICE_BUFFER_HEADER

#define DEVICE_BUFFER_HEADER

// tipos de datos

typedef struct {
    unsigned int startAddr;
    unsigned int length;
    unsigned short * data;  
} BancoMemoria;

typedef struct {
    unsigned int addr;
    unsigned short value;
    unsigned char skip;
} LocalidadMemoria;


typedef struct {
    BancoMemoria* banks;
    unsigned short length;
} ArrayBancoMemoria; 

typedef struct {
    LocalidadMemoria* locations;
    unsigned int length;
} ArrayLocalidadMemoria;

typedef struct {
    ArrayBancoMemoria program;
    ArrayBancoMemoria data;
    ArrayLocalidadMemoria configuration;
    
} DeviceBuffer;


void initProgramMemory( DeviceBuffer *bufferPtr);

void initDataMemory( DeviceBuffer *bufferPtr);

void initConfigurationMemory( DeviceBuffer *bufferPtr);







void read_program_memory( DeviceBuffer * bufferPtr);

void read_data_memory( DeviceBuffer * bufferPtr);

void read_config_memory( DeviceBuffer * bufferPtr);


void write_program_memory( DeviceBuffer * bufferPtr);

void write_data_memory( DeviceBuffer * bufferPtr);

void write_config_memory( DeviceBuffer * bufferPtr);

#endif