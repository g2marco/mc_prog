/**
 *  Exercise 001: Led toggle
 */

#include <xc.h>
#include "libs/device_setup.h"

extern void loop( void);

unsigned char DATA0 = 0x01;
unsigned char DATA1 = 0x01;
unsigned char DATA2 = 0x01;
unsigned char DATA3 = 0x01;


void main( void) {
	setup();
    
    interruptions();

	while( 1) {
	    loop();
	}
}
