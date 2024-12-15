#include <xc.h>


void config_pwm( void) {
	TRISIO2 = 1;

	PR2 = 69;					// pwm period
	CCP1CON = 0x0F;				// pwm mode, active low

	pwm_value = MAX_PWM_VALUE;
	increment = false;

	set_duty_cycle( pwm_value);

	PIR1bits.TMR2IF   = 0;		// timer 2, prescale and activation
	T2CONbits.T2CKPS1 = 0;
	T2CONbits.T2CKPS0 = 0;
	T2CONbits.TMR2ON  = 1;

 	while( PIR1bits.TMR2IF == 0) {	// wait timer 2 overflow
	}

	TRISIO2 = 0;				// CCP1 as output
}

void set_duty_cycle( unsigned short value) {
	CCPR1L   = (unsigned char) (value >> 2);		// duty cycle
	CCP1CON |= (unsigned char) (value << 4);
}
