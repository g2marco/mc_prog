#ifndef _PWM_H_

#define _PWM_H_

#define MAX_PWM_VALUE       280         //
#define DELTA_PWM            28


void config_pwm( unsigned char prescaler, unsigned char period,  unsigned char postscaler);

void set_duty_cycle( unsigned short value);

#endif
