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

    // individual TRISIO initialization
    config_switchA;
    config_outputA;

    nGPPU = 0;          // global pull ups enabled
    
    // individual input pull-up enable
    WPU0  = 1;       // input GP0 pull up enabled    
    
    config_timer2( TMR2_PRE_SCALER_1_4, 25, TMR2_POST_SCALER_1_10);
    init_timer2();
}

/**
 *  Interruption config
 */
void interruptions( void) {
    PEIE = 1;
    ei();
}