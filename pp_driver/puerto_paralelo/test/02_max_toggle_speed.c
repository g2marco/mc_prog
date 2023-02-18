
#include <stdio.h>
#include <inttypes.h>
#include <signal.h>

#include "../puerto_paralelo.h"

#define BASE 0x378

FILE * log_file = NULL;

int running = 1;

void signalHandler(int sig) {
   running = 0;
   release_puerto_paralelo();
}

int rutina_principal() {

    // reclama puerto paralelo
    int resultado = init_puerto_paralelo( BASE);
    if ( resultado != 0) {
        return resultado;
    }

    // configura como salida
    port.control.bits.C3 = 1;
	port.control.bits.C5 = 0;
    write_control_port();

    // inicializacion de salidas
    port.data.value = 0xFF;
    write_data_port();

    // conmuta el bit D4
    while( running == 1) {
        port.data.bits.D4 = !port.data.bits.D4;
        write_data_port();
    }

}

int main(void) {
    signal( SIGINT, signalHandler);

    printf("Toggling D4 line of parallel port (Base: 0x%x)\n", BASE);

    rutina_principal();

    return 0;
}
