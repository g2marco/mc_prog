#!/bin/bash
#  Script de compilacion y ejecucion de proceso de prueba

echo "Compiling PIC16F6XXA Programmer Test"

rm -f test
gcc pic16f6xxa_programmer_test.c device_buffer.c pic16fxxx_driver.c ../adaptador_pp/adaptador_pp.c ../puerto_paralelo/puerto_paralelo.c -o test

sudo chown root.root test
sudo chmod +s test

echo "Executing PIC16F6XXA Programmer Test"
./test
