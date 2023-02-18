#!/bin/bash
#  Script de compilacion y ejecucion de proceso de prueba

echo "Compiling Adaptador PP Test"

rm -f 01_pp_adapter.test
gcc 01_pp_adapter.c  ../adaptador_pp.c ../puerto_paralelo/puerto_paralelo.c -o 01_pp_adapter.test

sudo chown root.root 01_pp_adapter.test
sudo chmod +s        01_pp_adapter.test

echo " [done] Tests compiled!"
