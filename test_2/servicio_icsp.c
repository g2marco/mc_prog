#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>


int main(int argc, char* argv[]) {
  
    pid_t process_id = fork();      // creates child process
    
    if (process_id < 0) {
        printf("\nfork failed!\n");
        exit(1);
    }
    
    if (process_id > 0) {           // parent process ends here
        printf("\nprocess_id of child process %d \n", process_id);
        exit(0);
    }
    
    // child process starts here
    
    umask(0);                   // unmask the file mode
    
    pid_t sid = setsid();       // set new session
    if( sid < 0) {
        printf("\nerror while setting new sessión id\n");
        exit(1);
    }
    
    chdir( "/");                 // change the current working directory to root.
    
    close( STDIN_FILENO);        // close stdin, stdout and stderr
    close( STDOUT_FILENO);
    close( STDERR_FILENO);

    FILE *fp = fopen ("Log.txt", "w+");   // open a log file for writing
    
    while (1) {     // service
        sleep(1);                                   // dont block context switches, let 
                                                    // the process sleep for some time
       
        fprintf( fp, "Logging info...\n");
        fflush( fp);                                // Implement and call some function 
                                                    // that does core work for this daemon.
    }
    
    fclose(fp);
    return (0);
}