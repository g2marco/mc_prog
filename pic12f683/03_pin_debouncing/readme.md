# Práctica 3: Debouncing de pin de entrada

- El timer 2 es configurado para producir una interrupcion cada 1ms al configurar valores de pre-scalet y post-scaler apropidados (usando el oscilador interno @ 4 MHz)
- Al terminar cada cuenta se permite la generación de interrupción
- Al detectarse cada interrupción se ejecuta un proceso de debouncing
  - Se revisa el estado del pin GP1, si se detecta un cambio se inicia una cuenta de 100 interrupciones
  - Al pasar 100 interrupciones, se vuelve a revisar el valor de GP!, si el cambio de valor se mantiene, se asigna el nuevo estado estable del pin.

- El valor GP0 es asignado al valor estable del pin GP1
  - valor del ping GP1  es distinto de su valor estable (después de debouncing)




