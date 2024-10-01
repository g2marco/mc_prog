#include <xc.h>
#include "libs\device_setup.h"

extern void loop( void);

void main( void) {
	setup();
    
    interruptions();


	while( 1) {
	    loop();
	}
}
