#include <stdio.h>

#include "../programming_info/programming_info.h"
#include "pic16fxxx_programmer.h"

FILE * log_file = NULL;

int main(void) {
    
    ProgrammingInfo info;

    read_programming_info( &info, "/tmp/pic_prog_request.txt");

    execute_programming_task( &info);
    
    write_programming_info( &info, "/tmp/pic_prog_response.txt");

    return 0;
}
