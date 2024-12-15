
/**
 *  implementation of loop routine
 */

#include <xc.h>
#include "libs/device_pinout.h"

#define _XTAL_FREQ 4000000 

extern unsigned char DATA0;
extern unsigned char DATA1;
extern unsigned char DATA2;
extern unsigned char DATA3;


void send_data( unsigned char value, unsigned char nbits) {
    unsigned char mask = 1;

    for ( int i = 0 ; i < nbits; ++i) {
        DATA_OUT = (value & mask) == 0? 0 : 1;
        mask = mask << 1;
        
        CLK_OUT  = 1;
        __delay_ms( 10);
        CLK_OUT  = 0;
        __delay_ms( 10);
    }
}

void loop( void) {
    if ( PUSH_BTN == 0) {
        return;
    }

    send_data( DATA0, 4);
    send_data( DATA1, 4);
    send_data( DATA2, 4);
    send_data( DATA3, 4);

    while ( PUSH_BTN == 1) {
        continue;
    }
}
