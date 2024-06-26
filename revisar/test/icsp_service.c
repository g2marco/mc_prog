#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <limits.h>
#include <string.h>
#include <signal.h>
#include <time.h>
#include <ctype.h>

#include "05_common.h"


int running = 1;

void signalHandler(int signal) {
   running = 0;
}


void validar_id_proceso( pid_t process_id) {
    if ( process_id < 0) {
        fprintf( stderr, "\nImposible crear proceso hijo\n");
        exit( EXIT_FAILURE);
    }
    
    if (process_id > 0) {
        // parent process ends here
        exit( EXIT_SUCCESS);
    }
}

void init_service() {
    
    signal( SIGINT, signalHandler);
    signal( SIGTERM, signalHandler);
    
    umask(0);                   // unmask the file mode
    
    pid_t sid = setsid();       // set new session
    
    if( sid < 0) {
        fprintf( stderr, "\nError al crear una nueva sesión\n");
        exit( EXIT_FAILURE);
    }
    
    chdir( "/");                // change the current working directory to root.
    
    close( STDIN_FILENO);       // close stdin, stdout and stderr
    close( STDOUT_FILENO);
    close( STDERR_FILENO);
}

void crear_fifo() {
    if (access(SERVER_FIFO_NAME, F_OK) == -1) {
        int resultado = mkfifo( SERVER_FIFO_NAME, 0777);
        if (resultado != 0) {
            fprintf( stderr, "\nCould not create fifo %s\n", SERVER_FIFO_NAME);
            exit(EXIT_FAILURE);
        }
    }
}

FILE *logFile;

void abrir_log_file() {
    logFile = fopen ("/tmp/icsp_service_log.txt", "w+");
}

void cerrar_log_file() {
    fclose( logFile);
}

void print_current_time() {
    time_t s = time(NULL);
    struct tm* c = localtime(&s);
    
    fprintf( logFile, "%02d/%02d/%02d %02d:%02d:%02d ",
        c->tm_mday, c->tm_mon + 1, c->tm_year + 1900,
        c->tm_hour, c->tm_min, c->tm_sec
    );
}

void log_activity( char* mensaje) {
    print_current_time();
    fprintf( logFile, "mensaje: \n");
    fflush( logFile);
}




int main(int argc, char* argv[]) {
  
    pid_t process_id = fork();          // crea proceso hijo
    
    validar_id_proceso( process_id);    
        
    init_service();                     // proceso hijo continua 
    abrir_log_file();    
    crear_fifo();
    
    
    
    int client_fifo_fd, server_fifo_fd;
    struct data_to_pass_st my_data;
    int read_res;
    char *tmp_char_ptr;
    unsigned int i;
    unsigned int suma = 0;
    
    while ( running) {    
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
        
        log_activity( "inactivo");
    }
    
    log_activity( "señal de finalización recibida");
    
    unlink( SERVER_FIFO_NAME);
    cerrar_log_file();
    
    return (0);
}