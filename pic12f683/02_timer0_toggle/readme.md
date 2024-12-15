# Práctica 2: Timer 0

- El  Timer0 es configurado para producir una interrupción cada 1 [ms], al configurar valores de pre-scaler TMR0, usando el oscilador interno @ 4 MHz
- Al terminar cada cuenta se permite la generación de interrupción 
- Al detectarse cada interrupción se conmuta el pin GP0 y se recarga el valor inicial de TMR0

