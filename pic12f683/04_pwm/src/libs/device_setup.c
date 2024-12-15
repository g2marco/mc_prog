
#include <xc.h>

#include "device_setup.h"
#include "device_pinout.h"
#include "timer2.h"
#include "pwm.h"


void setup( void ) {
	TRISIO = 0xFF;		        // all GPIO pins as inputs

	GPIO = 0;			        // clear port latches
	CMCON0 = 7;			        // turn comparators off, enable related pins for I/O
	ANSEL  = 0;

	config_pwm();
	config_gpio();
    config_timer2( TMR2_PRE_SCALER_1_4, 25, TMR2_POST_SCALER_1_10); // 4 * 25 * 10 = 1000 , 1000 * 4 / 4Mhz => 1ms

    init_timer2();
}

void config_gpio() {
	// output I/O
	TRISIO0 = 0;			    // GPIO0 is output

	// input I/O
	OPTION_REGbits.nGPPU = 0;	// general enable pull up

	TRISIO5 = 1;			    // GPIO5 pin as input
	WPU5    = 1;			    // pull up enabled
}

/**
 *  Interruption config
 */
void interruptions( void) {
    PEIE = 1;
    ei();
}
