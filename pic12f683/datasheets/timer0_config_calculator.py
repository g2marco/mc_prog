import numpy as np
import matplotlib.pyplot as plt


#
#   Configuration params for timer0 ( tmr0, prescaler)
#

fosc = 4e6
tosc = 1 / fosc

#
#
#

prescales = np.array( [2, 4, 8, 16, 32, 64, 128, 256])
tmr0 = np.arange( 0, 256)

##
## Encontrar las combinaciones de tmr0 y prescale que producen un retardo específico con el menor error
##

target = 1e-3           # 1 ms
max_error = 0.001       # 

for prescale in prescales :
    time   = (256 - tmr0) * 4 * tosc * prescale
    errors = np.abs( (time - target) / time)
    idxs   = np.where( errors <= max_error)
    
    if idxs[0].size > 0 : 
        for idx in idxs[0]: 
            t     = (256 - tmr0[idx]) * 4 * tosc * prescale
            error = (t - target) / t

            print( 'precale: ', prescale, ', tmr0: ', tmr0[idx], ', time: ',  t * 1000 , '[ms], error: ', error)



     

