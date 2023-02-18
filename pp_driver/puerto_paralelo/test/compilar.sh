#!/bin/bash
#  
#	This script compiles parallel port test programs and changes its permissions
#
echo "Compiling Parallel Port Tests"

rm -f 01_puerto_paralelo.test
rm -f 02_max_toggle_speed.test

gcc 01_puerto_paralelo.c  ../puerto_paralelo.c -o 01_puerto_paralelo.test
gcc 02_max_toggle_speed.c ../puerto_paralelo.c -o 02_max_toggle_speed.test

sudo chown root.root 01_puerto_paralelo.test
sudo chmod +s 01_puerto_paralelo.test

sudo chown root.root 02_max_toggle_speed.test
sudo chmod +s 02_max_toggle_speed.test

echo " [done] Tests compiled!"
