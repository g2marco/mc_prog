
#include <xc.h>
#include "device_setup.h"
#include "device_pinout.h"
#include "timer0.h"

/**
 *  Device setup
 */
void setup( void ) {
	GPIO   = 0;         // clear port latches
	CMCON0 = 7;         // turn comparators off, enable related pins for I/O
	ANSEL  = 0;

    config_outputA;

    config_timer0( TMR0_PRE_SCALER_1_8);

    init_timer0();
}

/**
 *  Interruption config
 */
void interruptions() {
    PEIE = 1;
    ei();
}
