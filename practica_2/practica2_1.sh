#!/bin/bash

echo -n "Introduzca el nombre del fichero: " 
read file

if test -f "$file"
then
    echo -n "Los permisos del archivo $file son: "
    
    if test -r "$file"
    then
        echo -n "r"
    else
        echo -n "-"
    fi

    if test -w "$file"
    then
        echo -n "w"
    else
        echo -n "-"
    fi

    if test -x "$file"
    then
        echo "x"
    else
        echo "-"
    fi

else
    echo "$file no existe"
fi
