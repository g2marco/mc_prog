#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main() {
    char buffer[1024 + 1];
    int chars_read;
    
    memset( buffer, '\0', sizeof(buffer));
    
    FILE *read_fp = popen( "ps ax", "r");                    // abre stream de salida del comando 'ps ax'
    if( read_fp == NULL) {
        exit(EXIT_FAILURE);
    }
    
    printf( "\nLongitud de buffer: %d\n", 1024);
    
    while ( (chars_read = fread( buffer, sizeof(char), 1024, read_fp)) > 0) {
        buffer[ chars_read] = '\0';
        printf( "\nCaracteres leidos: %d\n%s\n", chars_read, buffer);   // imprime resultado del comando
    }
        
    pclose(read_fp);
    exit(EXIT_SUCCESS);
    
}