# Capture / Compare / PWM (CCP) Module



| CCP Mode | Function                                                     | Timer Resource |
| -------- | ------------------------------------------------------------ | -------------- |
| Capture  | timing of the duration of an event                           | Timer 1        |
| Compare  | triggers an external event when an predetermined amount o time has expired | Timer 1        |
| PWM      | generate a PWM signal (varying frequency / duty cycle)       | Timer 2        |



### CCP1CON

| U-0  | U-0  | R/W-0 | R/W-0 | R/W-0  | R/W-0  | R/W-0  | R/W-0  |
| ---- | ---- | ----- | ----- | ------ | ------ | ------ | ------ |
| ---- | ---- | DC1B1 | DC1B0 | CCP1M3 | CCP1M2 | CCP1M1 | CCP1Mo |

**DC1B[1:0]** PWM Duty Cycle lsb bits

​	**NN** = two lsb bits of the PWM duty cycle ( the 8 MSB's are in CCPR1L)

**CCP1M[3:0]** CCP Mode select

​	**0000** = CCP module off

​	**0100** = Capture mode, every falling edge
​	**0101** = Capture mode, every rising edge
​	**0110** = Capture mode, every 4th rising edge
​	**0111** = Capture mode, every 16th rising edge

​	**1000** = Compare mode, set output on match
​	**1001** = Compare mode, clear output on match
​	**1010** = Compare mode, generate software interrupt on match
​	**1011** = Compare mode, trigger special event

​	**110x** = PWM mode active-high
​	**111x** = PWM mode active-low



## Capture Mode 



## Compare Mode



## PWM Mode

* Generate a PWM signal (up to 10 bit resolution)  on the CCP1 pin (GP2)

* TRISIO.GP2 = 0 (GO2 )

  

| PWM Param      | SFR / comments                                               | Definition                                                |
| -------------- | ------------------------------------------------------------ | --------------------------------------------------------- |
| Period         | PR2 ,  TMR2 prescale (*****)                                 | = (PR2 + 1) * 4 * Tosc * TMR2 prescale                    |
| Pulse width    | CCPR1L : CCP1CON [ DC1B1:DC1B0 ] (******)                    | = CCPR1L : CCP1CON [ DC1B1:DC1B0 ] * Tosc * TMR2 prescale |
| Duty cycle     | high time / cycle time                                       | = CCPR1L : CCP1CON [ DC1B1:DC1B0 ] / ( 4 (PR2 + 1))       |
| PWM Resolution | number of available duty cycles <br />max resolution = 10 bits when PR2 = 255 | = log( 4 * (PR2 + 1)) / log ( 2)    [bits]                |

(*****) NOTE 1: **Timer2** pos-tscaler is not used by PWM module

(******) NOTE 2: While in PWM mode, CCPR1H register is read-only

(******) NOTE 3: When Pulse Width > Period, the PWM out pin will remain unchanged

### Setup for PWM operation

1. Disable CCP1 pin output driver                                           GP2 as input
2. Set PWM period                                                                    PR2
3. Configure CCP module in PWM mode                              CCP1CON
4. Set PWM duty cycle                                                              CCPR1L | CCP1CON
5. Configure and start Timer 2
   1. clear Timer2 interrupt flag                                             PIR1 [ TMR2IF ]
   2. set Timer2 pre-scaler                                                    T2CON [ T2CKPS bits ]
   3. enable Timer2                                                                T2CON [ TMR2ON ]
6. Enable CCP1 pin output driver after a new PWM cycle has started
   1. wait until Timer2 overflows                                            PIR1 [ TMR2IF ]  is set
   2. enable CPP1 pin output driver                                     GP2 as output

