#include "05_common.h"
#include <ctype.h>

int main() {
    
    // Si no existe, crea fifo servidor
    
    if (access(SERVER_FIFO_NAME, F_OK) == -1) {
        int resultado = mkfifo( SERVER_FIFO_NAME, 0777);
        if (resultado != 0) {
            fprintf(stderr, "\nCould not create fifo %s\n", SERVER_FIFO_NAME);
            exit(EXIT_FAILURE);
        }
    }
    
    int client_fifo_fd, server_fifo_fd;
    struct data_to_pass_st my_data;
    int read_res;
    
    char *tmp_char_ptr;

    do {
        // abre fifo servidor para lectura, se bloquea
        printf( "\n-\t-\t-\t-\t-\t-\t-\t-\t-\t-\t-\t-\t-\t-\t-\t-\t-\n");
        printf( "\nServer process %d: opening FIFO O_RDONLY\n", getpid());
        server_fifo_fd = open( SERVER_FIFO_NAME, O_RDONLY);
        
        printf( "\nServer process %d: result %d\n", getpid(), server_fifo_fd);
        if ( server_fifo_fd == -1) {
            fprintf( stderr, "\nServer process: FIFO failure\n");
            exit(EXIT_FAILURE);
        }
        
        read_res = read( server_fifo_fd, &my_data, sizeof( my_data));
        printf( "\nServer process: closing FIFO");
        
        close( server_fifo_fd);
        printf( "\nServer process: read bytes %d\n", read_res);
        
        if (read_res > 0) {
            tmp_char_ptr = my_data.some_data;
            
            while (*tmp_char_ptr) {
                *tmp_char_ptr = toupper(*tmp_char_ptr);
                tmp_char_ptr++;
            }
            
            printf( "\nServer: init data processing");
            
            int i = 0;
            int suma = 0;
            for ( i = 0; i < 400000000; ++i) {
                suma += i;
            }
            printf( "\nServer: step 1");
            
            for ( i = 0; i < 400000000; ++i) {
                suma += i;
            }
            
            printf( "\nServer: step 2");
            
            for ( i = 0; i < 400000000; ++i) {
                suma += i;
            }
            
            printf( "\nServer: step 3");
            
            for ( i = 0; i < 400000000; ++i) {
                suma += i;
            }
            
            printf( "\nServer: step 4");
            
            for ( i = 0; i < 400000000; ++i) {
                suma += i;
            }
            
            printf( "\nServer: step 5");
            
            for ( i = 0; i < 400000000; ++i) {
                suma += i;
            }
            
            printf( "\nServer: step 6");
            
            for ( i = 0; i < 400000000; ++i) {
                suma += i;
            }
            
            printf( "\nServer: step 7");
            
            for ( i = 0; i < 400000000; ++i) {
                suma += i;
            }
            
            printf( "\nServer: step 8");
            
            for ( i = 0; i < 400000000; ++i) {
                suma += i;
            }
            
            printf( "\nServer: step 9");
            
            for ( i = 0; i < 400000000; ++i) {
                suma += i;
            }
            
            
            printf( "\nServer: step 10");
            
            for ( i = 0; i < 400000000; ++i) {
                suma += i;
            }
            
            printf( "\nServer: step 11");
            
            for ( i = 0; i < 400000000; ++i) {
                suma += i;
            }
            
            printf( "\nServer: step 12");
            
            for ( i = 0; i < 400000000; ++i) {
                suma += i;
            }
            
            printf( "\nServer: step 13");
            
            for ( i = 0; i < 400000000; ++i) {
                suma += i;
            }
                        
            printf( "\nServer: ends data processing");
            
            printf( "\nServer: sends response to client");
            
            client_fifo_fd = open( CLIENT_FIFO_NAME, O_WRONLY);
            if (client_fifo_fd == -1) {
                fprintf( stderr, "\nServer process: Client FIFO failure\n");
                exit(EXIT_FAILURE);
            }
            write(client_fifo_fd, &my_data, sizeof(my_data));
            close(client_fifo_fd);
        }
        
    } while ( 1);
    
    unlink(SERVER_FIFO_NAME);
    exit(EXIT_SUCCESS);
    
}
