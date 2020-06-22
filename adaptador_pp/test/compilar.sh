#!/bin/bash
#  Script de compilacion y ejecucion de proceso de prueba

echo "Compiling Adaptador PP Test"

rm -f test
gcc adaptador_pp_test.c adaptador_pp.c ../puerto_paralelo/puerto_paralelo.c -o test

sudo chown root.root test
sudo chmod +s test

echo "Executing Adaptador PP Test"
./test
