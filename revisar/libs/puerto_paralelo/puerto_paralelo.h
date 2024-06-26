#ifndef PUERTO_PARALELO_HEADER

#define PUERTO_PARALELO_HEADER

// tipos de datos

typedef struct {
    
    unsigned short baseAddress;
    
    union {
        unsigned short value;
        struct {
            unsigned D0: 1;
            unsigned D1: 1;
            unsigned D2: 1;
            unsigned D3: 1;
            unsigned D4: 1;
            unsigned D5: 1;
            unsigned D6: 1;
            unsigned D7: 1;
        } bits;
    } data;
    
    union {
        unsigned short value;
        struct {
            unsigned   : 3;
            unsigned S3: 1;
            unsigned S4: 1;
            unsigned S5: 1;
            unsigned S6: 1;
            unsigned S7: 1;
        } bits;
    } status;

    union {
        unsigned short value;
        struct {
            unsigned C0: 1;
            unsigned C1: 1;
            unsigned C2: 1;
            unsigned C3: 1;
            unsigned   : 1;
            unsigned C5: 1;
        } bits;
    } control;
    
} PuertoParalelo;


// variables globales

extern PuertoParalelo port;


// funciones

int init_puerto_paralelo( unsigned short direccionBase);
int release_puerto_paralelo();
    
void write_data_port();
void read_data_port();

void read_status_port();
void write_control_port();

void print_registros();

#endif
