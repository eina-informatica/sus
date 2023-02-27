#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, [M], [3], [A]
#842236, Yubero Segura, Andres, [M], [3], [A]

echo -n "Introduzca el nombre del fichero: " 
read filename

if test -f "$filename"
then
    echo -n "Los permisos del archivo $filename son: "
    
    if test -r "$filename"; then echo -n "r"; else echo -n "-"; fi

    if test -w "$filename"; then echo -n "w"; else echo -n "-"; fi

    if test -x "$filename"; then echo "x"; else echo "-"; fi

    # echo ls -l $filename | cut -c2-4

else
    echo "$filename no existe"
fi