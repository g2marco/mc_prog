import numpy as np
import matplotlib.pyplot as plt


#
#   Configuration params for PWM  Module
#

fosc = 4e6
tosc = 1 / fosc

#
#
#

prescales = np.array( [1, 4, 16])
pr2 = np.arange( 50, 256)



fig, axs = plt.subplots(2)


# pwm frequency for each timer2 pre-scale

for prescale in prescales :
    period     = (pr2 + 1) * 4 * tosc * prescale
    axs[0].plot( pr2, 1 / period, label= 'prescale [' + str( prescale) + ']')


# bits of resolution for every value of pr2

resolution = np.log10(4 * (pr2 + 1)) / np.log10( 2)
axs[1].plot( pr2, resolution)


#
#
#
axs[0].set_yscale( 'log')
axs[0].grid( which = 'both')
axs[1].grid( which = 'both')

plt.show()