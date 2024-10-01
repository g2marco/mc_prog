#ifndef _device_pinout_
#define _device_pinout_

/**
 *  Pin definition
 */

#define config_switchA  TRISIO0 = 1 // input signal
#define raw_switchA GP0

#define config_outputA  TRISIO5 = 0 // output signal
#define outputA GP5

#endif