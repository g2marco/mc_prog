#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main() {
    
    int file_pipes[2];
    if ( pipe(file_pipes) < 0) {            // [0] read, [1] write
        exit(EXIT_FAILURE);
    }
    
    
    // escribe en el pipe
    const char some_data[] = "123";
    
    int bytes_escritos = write( file_pipes[1], some_data, strlen( some_data));
    printf( "Wrote %d bytes\n", bytes_escritos);
    
    
    // lee del pipe
    char buffer[BUFSIZ + 1];
    memset(buffer, '\0', sizeof(buffer));
    
    int bytes_leidos = read( file_pipes[0], buffer, BUFSIZ);
    printf( "Read %d bytes: %s\n", bytes_leidos, buffer);
    
    exit(EXIT_SUCCESS);
    
}