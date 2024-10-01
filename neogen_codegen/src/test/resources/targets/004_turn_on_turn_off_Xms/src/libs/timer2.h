#ifndef _TIMER2_H_

#define _TIMER2_H_

#define TMR2_PRE_SCALER_1_1     0x00    // xxxx xx00  
#define TMR2_PRE_SCALER_1_4     0x01    // xxxx xx01
#define TMR2_PRE_SCALER_1_16    0x02    // xxxx xx1x

#define TMR2_POST_SCALER_1_1    0x00    // x000 0xxx
#define TMR2_POST_SCALER_1_2    0x08    // x000 1xxx
#define TMR2_POST_SCALER_1_3    0x10    // x001 0xxx
#define TMR2_POST_SCALER_1_4    0x18    // x001 1xxx
#define TMR2_POST_SCALER_1_5    0x20    // x010 0xxx
#define TMR2_POST_SCALER_1_6    0x28    // x010 1xxx
#define TMR2_POST_SCALER_1_7    0x30    // x011 0xxx
#define TMR2_POST_SCALER_1_8    0x38    // x011 1xxx
#define TMR2_POST_SCALER_1_9    0x40    // x100 0xxx
#define TMR2_POST_SCALER_1_10   0x48    // x100 1xxx
#define TMR2_POST_SCALER_1_11   0x50    // x101 0xxx
#define TMR2_POST_SCALER_1_12   0x58    // x101 1xxx
#define TMR2_POST_SCALER_1_13   0x60    // x110 0xxx
#define TMR2_POST_SCALER_1_14   0x68    // x110 1xxx
#define TMR2_POST_SCALER_1_15   0x70    // x111 0xxx
#define TMR2_POST_SCALER_1_16   0x78    // x111 1xxx


void config_timer2( unsigned char prescaler, unsigned char period,  unsigned char postscaler);

void init_timer2( void);

#endif
	
	