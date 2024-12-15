#!/bin/bash
#
#  Actualización de version de aplicación
#

# exit when any error
set -e

export JAVA_HOME=/home/g2marco/software/java/jdk-23.0.1
export PATH=$PATH:$JAVA_HOME/bin

PROJECT_DIR=/home/g2marco/work/c_code/mc_prog
MVN_INSTALL="/usr/lib/apache-netbeans/java/maven/bin/mvn -T 4 -DskipTests=true -DcompilerArgument=-Xlint:all clean install"


#   compile and generate libraries

cd $PROJECT_DIR/pic_gui
$MVN_INSTALL

#   copy jars to dist directory

rm -f /dist/libs/*.*
cp ./target/libs/*.*                   ./dist/libs/
cp ./target/pic.programmer.gui-1.0.jar ./dist/libs/
