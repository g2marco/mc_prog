#include "05_common.h"
#include <ctype.h>

int main() {
    
    if ( mkfifo( CLIENT_FIFO_NAME, 0777) == -1) {
        fprintf( stderr, "Sorry, can't make %s\n", CLIENT_FIFO_NAME);
        exit(EXIT_FAILURE);
    }

    struct data_to_pass_st my_data;
    my_data.client_pid = getpid();
    
    int client_fifo_fd, server_fifo_fd;
    int times_to_send;
    
    printf( "\n\tclient: init");
    
    for (times_to_send = 0; times_to_send < 5; times_to_send++) {
        
        // prepara informacion para enviar
        sprintf( my_data.some_data, "Hello from %d", my_data.client_pid);
        
        
        // espera servidor listo
        server_fifo_fd = open( SERVER_FIFO_NAME, O_WRONLY);
        if ( server_fifo_fd == -1) {
            fprintf(stderr, "\n\tLa FIFO del servidor no esta disponible.\n");
            exit(EXIT_FAILURE);
        }
        write(server_fifo_fd, &my_data, sizeof(my_data));
        close(server_fifo_fd);
        
        printf( "\n\tclient %d sent '%s'", my_data.client_pid, my_data.some_data);
        printf( "\n\tclient waiting response");
        
        // espera respuesta del servidor
        client_fifo_fd = open( CLIENT_FIFO_NAME, O_RDONLY);
        if ( client_fifo_fd == -1) {
            fprintf(stderr, "\n\tLa FIFO de cliente no esta disponible.\n");
            exit(EXIT_FAILURE);
        }
        
        if ( read( client_fifo_fd, &my_data, sizeof(my_data)) > 0) {
            printf( "\n\tcliente: info recibida: '%s'\n", my_data.some_data);
        } else {
            printf( "\n\tcliente: bytes recibidos = 0");
            break;
        }
        close(client_fifo_fd);
    }
    
    unlink( CLIENT_FIFO_NAME);
    exit(EXIT_SUCCESS);
}