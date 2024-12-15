# PIC12F683 DEVICE CONFIGURATION

- Use of **#pragma** for initializing:
  - Identification words (IDLOC3 - IDLOC0)
  - Configuration word



## Identification Words

````c
#pragma config IDLOC0 = 0x127
#pragma config IDLOC1 = 0x128
#pragma config IDLOC2 = 0x129
#pragma config IDLOC3 = 0x12A
````



## Configuration Word



| Field     | Name                              | Options                                                      |
| --------- | --------------------------------- | ------------------------------------------------------------ |
| **FOSC**  | Oscillator Selection              | - **EXTRCCLK**  : External RC Oscillator [GP5>CLKIN, GP4 > CLKOUT]<br />- **EXTRCIO**     : External RC Oscillator [GP5>CLKIN, GP4 > I/O          ]<br />- **INTOSCCLK**: Internal Oscillator        [GP5>I/O,      GP4 > CLKOUT]<br />- **INTOSCIO**   : Internal Oscillator        [GP5>I/O,      GP4 > I/O          ]<br />- **EC**:                                                            [GP5>CLKIN, GP4 > I/O          ]<br />- **HS**: High-speed crystal/resonator on GP5:GP4 <br />- **XT**: Crystal/resonator                       on GP5:GP4<br />- **LP**: Low-power crystal                      on GP5:GP4 |
| **WDTE**  | Watchdog Timer Enable             | **ON**/**OFF**                                               |
| **PWRTE** | Power-up Timer Enable             | **ON**/**OFF**                                               |
| **MCLRE** | MCLR Pin Function Select          | - **ON**:  GP3/MCLR pin function is MCLR<br />- **OFF**: GP3/MCLR pin function is digital input (MCLR internally tied to VDD) |
| **CP**    | Program Memory Code Protection    | **ON**/**OFF**                                               |
| **CPD**   | Data Memory Code Protection       | **ON**/**OFF**                                               |
| **BOREN** | Brown Out Detect                  | - **ON**:           BOR enabled <br />- **NSLEEP**:   BOR enabled during operation but disabled on sleep<br />- **SBODEN**: BOR controlled by **PCON< SBOREN >** <br />- **OFF**:          BOR disabled |
| **IESO**  | Internal External Switchover Mode | **ON**/**OFF**                                               |
| **FCMEN** | Fail-Safe Clock Monitor Enabled   | **ON**/**OFF**                                               |


