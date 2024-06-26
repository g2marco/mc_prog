#!/bin/bash
#  Script de compilacion y ejecucion de proceso de prueba

echo "Compiling Parallel Port Test"

rm -f test
gcc puerto_paralelo_test.c puerto_paralelo.c -o test

sudo chown root.root test
sudo chmod +s test

echo "Executing Parallel Port Test"
./test
