#!/bin/bash
#  
#	This script compiles parallel port test programs and changes its permissions
#
echo "Compiling Parallel Port Tests"

rm -f 01_parallel_port.x
rm -f 02_max_toggle_speed.x
rm -f 03_port_control.x

gcc 01_parallel_port.c  ../parallel_port.c  -o 01_parallel_port.x
gcc 02_max_toggle_speed.c ../parallel_port.c  -o 02_max_toggle_speed.x
gcc 03_port_control.c     ../parallel_port.c  -o 03_port_control.x 

sudo chown root.root 01_parallel_port.x
sudo chmod +s        01_parallel_port.x

sudo chown root.root 02_max_toggle_speed.x
sudo chmod +s        02_max_toggle_speed.x

sudo chown root.root 03_port_control.x
sudo chmod +s        03_port_control.x

echo " [done] Tests compiled!"
