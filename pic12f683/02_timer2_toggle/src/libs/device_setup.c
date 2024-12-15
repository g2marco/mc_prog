
#include <xc.h>
#include "device_setup.h"
#include "device_pinout.h"
#include "timer2.h"

/**
 *  Device setup
 */
void setup( void ) {
	GPIO   = 0;         // clear port latches
	CMCON0 = 7;         // turn comparators off, enable related pins for I/O
	ANSEL  = 0;

    config_switchA;
    config_outputA;

    config_timer2( TMR2_PRE_SCALER_1_4, 25, TMR2_POST_SCALER_1_10); // 4 * 25 * 10 = 1000 , 1000 * 4 / 4Mhz => 1ms
    init_timer2();
}

/**
 *  Interruption config
 */
void interruptions( void) {
    PEIE = 1;
    ei();
}
