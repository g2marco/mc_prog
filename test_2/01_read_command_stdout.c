#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main() {
    char buffer[BUFSIZ + 1];
    int chars_read;
    
    memset( buffer, '\0', sizeof(buffer));
    
    FILE *read_fp = popen( "uname -a", "r");                    // abre stream de salida del comando 'uname -a'
    if( read_fp == NULL) {
        exit(EXIT_FAILURE);
    }
    
    chars_read = fread( buffer, sizeof(char), BUFSIZ, read_fp); // lee stream de slaida
        
    if (chars_read > 0) {
        printf( "Output was:-\n%s\n", buffer);                  // imprime resultado del comando
    }
        
    pclose(read_fp);
    exit(EXIT_SUCCESS);
    
}