#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, [M], [3], [A]
#842236, Yubero Segura, Andres, [M], [3], [A]

echo -n "Introduzca una tecla: " 
# Se lee por entrada estandar
read key
# Se selecciona solo el primer caracter introducido
key=`echo $key | cut -c1-1`
# Se diferencian los distintos casos
case "$key" in
    # Si es un número se indica por salida estandar
    [0-9] ) echo "$key es un numero";;
    # Si es una letra se indica por salida estander
    [a-zA-Z] ) echo "$key es una letra";;
    # Si no es ninguno de los caracteres anteriores
    # se identifica como caracter especial
    * ) echo "$key es un caracter especial";;
esac
