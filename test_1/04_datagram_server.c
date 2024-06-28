#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main( void) {
    struct sockaddr_in server_address;
	struct sockaddr_in client_address;
	
	int server_sockfd;
	
	if( (server_sockfd = socket( AF_INET, SOCK_DGRAM, 0)) < 0) {
		perror( "datagram socket creation failed");
		exit( EXIT_FAILURE);
	}
	
	// create and name the socket
	server_address.sin_family = AF_INET;
	server_address.sin_addr.s_addr = htonl( INADDR_ANY);
	server_address.sin_port = htons( 9797);
		
	if( bind( server_sockfd, (struct sockaddr *) &server_address, sizeof( server_address)) < 0) {
		perror( "datagram bind failed");
		exit( EXIT_FAILURE);
	}
	
	char buffer[1];
	int addr_length = sizeof (client_address);
	
	int n = recvfrom( server_sockfd, (char *) buffer, 1, MSG_WAITALL, (struct sockaddr *) &client_address, &addr_length);
    printf("Client : %c\n", buffer[0]); 
	
	buffer[0] = 'b';
	
    sendto( server_sockfd, (const char *) buffer, 1, MSG_CONFIRM, (const struct sockaddr *) &client_address, addr_length); 
    
	printf( "respuesta enviada");     
	
    exit( 0);
}

