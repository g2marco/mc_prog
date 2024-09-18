#!/bin/bash
#
# Invoca interface grafica para programacion de dispositivos controladores PIC
#

# exit when any error
set -e

export JAVA_HOME=/home/g2marco/software/java/jdk-21.0.2
$JAVA_HOME/bin/java -cp "./libs/*" mx.com.neogen.pic.prg.gui.Main &
