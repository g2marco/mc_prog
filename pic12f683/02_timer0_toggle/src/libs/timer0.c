#include <xc.h>
#include "timer0.h"


void config_timer0( unsigned char prescaler) {
    T0CS = 0;

    CLRWDT();

    OPTION_REG = OPTION_REG & 0b11110000;
    OPTION_REG = OPTION_REG | prescaler  ;

    TMR0 = 0;
}

void init_timer0( void) {
    TMR0 = TMRO_INIT_VALUE;

    T0IF = 0;
    T0IE = 1;
}