#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, [M], [3], [A]
#842236, Yubero Segura, Andres, [M], [3], [A]

echo -n "Introduzca una tecla: " 
read key
key=`echo $key | cut -c1-1`
case $key in
    [0-9] ) echo "$key es un numero";;
    [a-zA-Z] ) echo "$key es una letra";;
    * ) echo "$key es un caracter especial";;
esac

#[[ $key == [0-9] ]] && echo "$key es un numero"