#ifndef _TIMER0_H_

#define _TIMER0_H_

#define TMR0_PRE_SCALER_1_2     0x00    // xxxx x000  
#define TMR0_PRE_SCALER_1_4     0x01    // xxxx x001
#define TMR0_PRE_SCALER_1_8     0x02    // xxxx x010
#define TMR0_PRE_SCALER_1_16    0x03    // xxxx x011
#define TMR0_PRE_SCALER_1_32    0x04    // xxxx x100
#define TMR0_PRE_SCALER_1_64    0x05    // xxxx x101
#define TMR0_PRE_SCALER_1_128   0x06    // xxxx x110
#define TMR0_PRE_SCALER_1_256   0x07    // xxxx x111

#define TMRO_INIT_VALUE          131     // 1ms @ Fosc = 4MHz, prescaler = 8

void config_timer0( unsigned char prescaler);

void init_timer0( void);

#endif
	
	