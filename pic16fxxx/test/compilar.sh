#!/bin/bash
#
# This script compiles and execute test programs
#
echo "Compiling PIC16FXXX Programmer Test"

rm -f test
gcc pic16fxxx_programmer_test.c ../pic16fxxx_programmer.c ../pic16fxxx_driver.c ../../programming_info/programming_info.c ../../adaptador_pp/adaptador_pp.c ../../puerto_paralelo/puerto_paralelo.c -o test

sudo chown root.root test
sudo chmod +s test

echo "Executing PIC16FXXX Programmer Test"
./test
