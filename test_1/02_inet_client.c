
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include <stdio.h>
#include <unistd.h>

int main( void) {
    struct sockaddr_in address;

    int sockfd = socket( AF_INET, SOCK_STREAM, 0);

    address.sin_family = AF_INET;
	address.sin_addr.s_addr = inet_addr( "127.0.0.1");
	address.sin_port = htons( 9734);
	
    int result = connect( sockfd, (struct sockaddr *) &address, sizeof( address));

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
