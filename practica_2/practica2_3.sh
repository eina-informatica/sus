#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, M, 3, A
#842236, Yubero Segura, Andres, M, 3, A

# Comprueba que solo se la haya pasado un parámetro
if test "$#" == 1
then
    # Comprueba que se un fichero regular
    if test -f "$1"
    then
        # Se le da permisos al propietario y usuarios con el mismo group id, del fichero, de ejecución
        chmod ug+x "$1"
        # Se muestra por pantalla los permisos del fichero por salida estandar
        stat -c %A "$1" 
    else
        # Si el fichero no existe se indica por salida estandar
        echo "$1 no existe"
    fi
else
    # Si hay más de un archivo como parámetro se indica cómo es la sintaxis del script
    echo "Sintaxis: practica2_3.sh <nombre_archivo>"
fi