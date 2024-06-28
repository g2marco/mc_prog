#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main() {
    
    int file_pipes[2];
    if ( pipe(file_pipes) < 0) {            // [0] read, [1] write
        exit(EXIT_FAILURE);
    }

    pid_t fork_result = fork();
    if ( fork_result == -1) {
        fprintf(stderr, "Fork failure");
        exit(EXIT_FAILURE);
    }
    
    const int packet_size = 10*sizeof( int);
    
    if (fork_result == 0) {                 // child process
        int buffer[ packet_size];
                
        int bytes_leidos = read( file_pipes[0], buffer, packet_size);
        printf( "\nChild read %d bytes: \n", bytes_leidos);
        
        int i;
        for ( i = 0; i < bytes_leidos / sizeof( int); ++i) {
            printf( "%d, ", buffer[i]);
        }
        
        printf( "\nInit processing: ");
        sleep( 10);
        
        printf( "\nSending response:");
        const int some_data[] = {123};
    
        int bytes_escritos = write( file_pipes[1], some_data, sizeof( int));
        printf( "\nChild wrote %d bytes\n", bytes_escritos);
        
    } else {                                // parent process
        const int some_datap[] = {1024, 512, 256, 128, 64, 32, 16, 8, 4, 1};
    
        int bytes_escritosp = write( file_pipes[1], some_datap, packet_size);
        printf( "\nParent wrote %d bytes\n", bytes_escritosp);
        
        
        sleep(1);
        
        
        int bufferp[ 1];
        
        int bytes_leidosp = read( file_pipes[0], bufferp, sizeof( int));
        printf( "\nParent read %d bytes: ", bytes_leidosp);
        
        int i;
        for ( i = 0; i < 1; ++i) {
            printf( "%d, ", bufferp[i]);
        }
    }
       
    exit(EXIT_SUCCESS);
}