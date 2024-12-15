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
	GPIO   = 0;         // clear port latches
	CMCON0 = 7;         // turn comparators off, enable related pins for I/O
	ANSEL  = 0;

    config_pin_led;
}

/**
 *  Interruption config
 */

void interruptions( void) {
    // this app do not use interruptions
}