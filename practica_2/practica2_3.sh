#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, [M], [3], [A]
#842236, Yubero Segura, Andres, [M], [3], [A]

if test $# == 1
then
    if test -f $1
    then
        chmod ug+x $1
        stat -c %A $1 
    else
        echo "$1 no existe"
    fi
else
    echo "Sintaxis: practica2_3.sh <nombre_archivo>"
fi