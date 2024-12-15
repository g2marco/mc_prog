#include <xc.h>

void config_timer2( unsigned char prescaler, unsigned char period,  unsigned char postscaler) {
    T2CON  = prescaler | postscaler;
    PR2    = period;

    TMR2ON = 1;             // turn on timer 2
}

void init_timer2( void) {
    TMR2 = 0;

    TMR2IF = 0;
    TMR2IE = 1;
}

