#!/bin/bash
#  
#	This script compiles parallel port test programs and changes its permissions
#
echo "Compiling Parallel Port Tests"

rm -f 01_test_puerto_paralelo
rm -f 02_test_maxima_frecuencia

gcc 01_test_puerto_paralelo.c   ../puerto_paralelo.c -o 01_test_puerto_paralelo
gcc 02_test_maxima_frecuencia.c ../puerto_paralelo.c -o 02_test_maxima_frecuencia

sudo chown root.root 01_test_puerto_paralelo
sudo chmod +s 01_test_puerto_paralelo

sudo chown root.root 02_test_maxima_frecuencia
sudo chmod +s 02_test_maxima_frecuencia


echo "Tests compiled"
