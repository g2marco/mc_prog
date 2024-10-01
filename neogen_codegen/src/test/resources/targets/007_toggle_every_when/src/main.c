#include <xc.h>
#include "libs\device_setup.h"

extern void loop( void);
extern __bit inputA;

void main( void) {
	setup();
    
    interruptions();
    
    inputA = 1;

	while( 1) {
	    loop();
	}
}
