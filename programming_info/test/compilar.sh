#!/bin/bash
#  Script de compilacion y ejecucion de proceso de prueba

echo "Compiling Programming Info Test"

rm -f test
gcc programming_info_test.c programming_info.c -o test

echo "Executing Programming Info Test"
./test
