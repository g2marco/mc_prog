#!/bin/bash
#
# Invoca interface grafica para programacion de dispositivos controladores PIC
#

# exit when any error
set -e

export JAVA_HOME=/home/g2marco/software/java/jdk-18.0.2.1
$JAVA_HOME/bin/java -cp "./libs/pic.programmer.gui-1.0.jar" mx.com.neogen.pic.programmer.gui.Main
