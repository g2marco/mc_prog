#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include <stdio.h>
#include <unistd.h>

int main( void) {
    struct sockaddr_in server_address;
	struct sockaddr_in client_address;
	
	int server_sockfd = socket( AF_INET, SOCK_STREAM, 0);
	
	// create and name the socket
	server_address.sin_family = AF_INET;
	server_address.sin_addr.s_addr = htonl( INADDR_ANY);
	server_address.sin_port = htons( 9734);
		
	bind( server_sockfd, (struct sockaddr *) &server_address, sizeof( server_address));
	
	// create connection queue and waits
	
	listen( server_sockfd, 5);
	
	int client_sockfd;
	int client_len;
	
	while( 1) {
		char ch;
		
		printf ( "\nserver waiting\n");
		
		client_sockfd = accept( server_sockfd, (struct sockaddr *) &client_address, &client_len);
		
		read( client_sockfd, &ch, 1);
		printf( "\nserver received: %c", ch);
		
		ch++;
		
		printf( "\nserver answer: %c", ch);
		
		write( client_sockfd, &ch, 1);
		
		close( client_sockfd);
	}
	
    exit( 0);
}
