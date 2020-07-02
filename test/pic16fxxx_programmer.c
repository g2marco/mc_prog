#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include <stdio.h>
#include <unistd.h>

#include "../programming_info/programming_info.h"
#include "../pic16fxxx/pic16fxxx_programmer.h"

FILE * log_file = NULL;

char REQUEST_FILE_PATH[]  = "/tmp/programmer_request.txt";
char RESPONSE_FILE_PATH[] = "/tmp/programmer_response.txt";



void save_request_file( int client_sockfd) {
	unsigned char ch = 'a';
	FILE *fp = fopen( REQUEST_FILE_PATH, "w");
	
	while ( ch != 0) {
		read( client_sockfd, &ch, 1);
		if ( ch != 0) {
			fputc( ch, fp);
		}
	}
		
	fclose (fp);
}

void write_response_file( int client_sockfd) {
	unsigned char ch;
	FILE *fp = fopen( RESPONSE_FILE_PATH, "r");
	
	while((ch = fgetc( fp)) != EOF && ch != 255) {
		write( client_sockfd, &ch, 1);
	}
	ch = 0;
	write( client_sockfd, &ch, 1);
		
	fclose (fp);
}


void program_device( void) {

    ProgrammingInfo info;

    read_programming_info( &info, REQUEST_FILE_PATH);

    execute_programming_task( &info);
	
	info.operation = 'r';
	
	execute_programming_task( &info);
		
    write_programming_info( &info, RESPONSE_FILE_PATH);
}

int main( void) {
    struct sockaddr_in server_address;
	struct sockaddr_in client_address;
	
	int server_sockfd = socket( AF_INET, SOCK_STREAM, 0);
	
	// create and name the socket
	server_address.sin_family = AF_INET;
	server_address.sin_addr.s_addr = htonl( INADDR_ANY);
	server_address.sin_port = htons( 9734);
		
	bind( server_sockfd, (struct sockaddr *) &server_address, sizeof( server_address));
	listen( server_sockfd, 5);
	
	int client_sockfd;
	int client_len;
	
	while( 1) {
		client_sockfd = accept( server_sockfd, (struct sockaddr *) &client_address, &client_len);
		
		save_request_file( client_sockfd);
		
		program_device();
		
		write_response_file( client_sockfd);
		
		close( client_sockfd);
	}
	
    exit( 0);
}





