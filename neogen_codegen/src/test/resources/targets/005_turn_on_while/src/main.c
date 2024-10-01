#include <xc.h>
#include "libs\device_setup.h"

extern void loop( void);
extern __bit switchA;
extern __bit switchB;

void main( void) {
	setup();
    
    interruptions();

    switchA = 1;
    switchB = 1;

	while( 1) {
	    loop();
	}
}
