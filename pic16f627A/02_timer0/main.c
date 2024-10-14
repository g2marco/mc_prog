#include <xc.h>

extern void setup( void);
extern void loop ( void);

void main( void) {
	setup();
	
	ei();						// enable interruptions
	
	while( 1) {
		loop();
	}
}
