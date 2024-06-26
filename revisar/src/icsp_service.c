#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <inttypes.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <limits.h>
#include <string.h>
#include <signal.h>
#include <time.h>
#include <ctype.h>

#include "05_common.h"
#include "libs/pic16f6xxa/device_buffer.h"
#include "libs/pic16f6xxa/pic16fxxx_driver.h"

/*	Compilar:
 *  gcc icsp_service.c ./libs/puerto_paralelo/puerto_paralelo.c ./libs/adaptador_pp/adaptador_pp.c ./libs/pic16f6xxa/pic16fxxx_driver.c ./libs/pic16f6xxa/device_buffer.c -o icsp_service
 *
 *
 */
#define BASE 0x378
FILE * log_file = NULL;

int running = 1;

void signalHandler(int signal) {
   running = 0;
}

void print_word( unsigned short data) {
    printf("%d%d %d%d%d%d %d%d%d%d %d%d%d%d", ((data&0x2000) == 0)? 0: 1, ((data&0x1000) == 0)? 0: 1, ((data&0x0800) == 0)? 0: 1, ((data&0x0400) == 0)? 0: 1, ((data&0x0200) == 0)? 0: 1, ((data&0x0100) == 0)? 0: 1, ((data&0x0080) == 0)? 0: 1, ((data&0x0040) == 0)? 0: 1, ((data&0x0020) == 0)? 0: 1, ((data&0x0010) == 0)? 0: 1, ((data&0x0008) == 0)? 0: 1, ((data&0x0004) == 0)? 0: 1, ((data&0x0002) == 0)? 0: 1, ((data&0x0001) == 0)? 0: 1);
}

void print_byte( unsigned short data) {
    printf("%d%d%d%d %d%d%d%d", ((data&0x0080) == 0)? 0: 1, ((data&0x0040) == 0)? 0: 1, ((data&0x0020) == 0)? 0: 1, ((data&0x0010) == 0)? 0: 1, ((data&0x0008) == 0)? 0: 1, ((data&0x0004) == 0)? 0: 1, ((data&0x0002) == 0)? 0: 1, ((data&0x0001) == 0)? 0: 1);
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
    
    printf("\nPrueba de Driver PIC16FXXX usando el puerto paralelo (Base: 0x%x)\n", BASE);
    signal(SIGINT, signalHandler);
    
    int resultado = init_driver( BASE);
    if ( resultado != 0) {
        return resultado;
    }
    
    
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
            
            DeviceBuffer buffer;
            initProgramMemory( &buffer);
            initDataMemory( &buffer);
            initConfigurationMemory( &buffer);
    
            //
            printf( "\n\n\tEscritura de memoria de programa");
            init_HVP_mode();
            write_program_memory( &buffer);
            reset_device();
            //  
            printf( "\n\n\tEscritura de memoria de configuracion");
            init_HVP_mode();
            write_config_memory( &buffer);
            reset_device();
            //
            printf( "\n\n\tEscritura de memoria de datos");
            init_HVP_mode();
            write_data_memory( &buffer);
            reset_device();
            //
    
  
            //
            printf( "\n\n\tLectura de Memoria de Configuración");
            init_HVP_mode();
            read_config_memory( &buffer);
            reset_device();
            //
    
            unsigned int i = 0;
            for ( i = 0; i < buffer.configuration.length; ++i) {
                LocalidadMemoria location = buffer.configuration.locations[i];
                printf( "\naddress 0x%x[%d]: ", location.addr, location.skip);
                print_word( location.value);
            }
    
            //
            printf( "\n\n\tLectura de Memoria de Programa");
            init_HVP_mode();
            read_program_memory( &buffer);
            reset_device();
            //
    
            BancoMemoria bank = buffer.program.banks[0];
            for ( i = 0; i < bank.length; ++i) {
                printf( "\naddress 0x%x: ", bank.startAddr + i);
                print_word( bank.data[i]);
            }
    
            //
            printf( "\n\n\tLectura de Memoria de Datos");
            init_HVP_mode();
            read_data_memory( &buffer);
            reset_device();
            //
            
            bank = buffer.data.banks[0];
            for ( i = 0; i < bank.length; ++i) {
                printf( "\naddress 0x%x: ", bank.startAddr + i);
                print_byte( bank.data[i]);
            }
            //
    
            printf( "\n");
    
            
                        
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
    release_driver();
    cerrar_log_file();
    
    return 0;
}

