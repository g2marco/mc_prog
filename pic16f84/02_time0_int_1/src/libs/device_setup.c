
/**
 * 	initial device setup and interruption configuration
 */

#include <xc.h>
#include "device_setup.h"
#include "device_pinout.h"

/**
 *  Device setup
 */

void setup( void ) {
	PORTA  = 0;         // clear ports 
	PORTB  = 0;

    config_pin_led;
}

/**
 *  Interruption config
 */

void interruptions( void) {
    // this app do not use interruptions
}