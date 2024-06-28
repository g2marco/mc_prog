
#include <sys/types.h>
#include <sys/socket.h>

#include <stdio.h>
#include <sys/un.h>
#include <unistd.h>

int main( void) {
    struct sockaddr_un address;

    int sockfd = socket( AF_UNIX, SOCK_STREAM, 0);

    address.sun_family = AF_UNIX;
    strcpy( address.sun_path, "server_socket");

    int len = sizeof( address);

    int result = connect( sockfd, (struct sockaddr *) &address, len);

    if( result == -1) {
        perror( "connection error from client");
        exit( 1);
    }

    char ch = 'A';

    write( sockfd, &ch, 1);
    read( sockfd, &ch, 1);

    printf( "char form server: %c\n", ch);

    close( sockfd);
    exit(0);
}
