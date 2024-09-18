#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main() {
       
    FILE *write_fp = popen( "od -c", "w");                      // abre stream de entrada para el comando 'od -c'
    if( write_fp == NULL) {
        exit(EXIT_FAILURE);
    }
    
    char buffer[BUFSIZ + 1];                                    // crea cadena a la medida
    sprintf( buffer, "Erase una vez, hace 20 años estaba programando en C y ...\n");
    
    fwrite( buffer, sizeof(char), strlen(buffer), write_fp);    // envia la cadena al stdin del comando

    pclose(write_fp);
    exit(EXIT_SUCCESS);
     
}