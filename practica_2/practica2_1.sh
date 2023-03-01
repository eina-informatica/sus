#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, M, 3, A
#842236, Yubero Segura, Andres, M, 3, A

echo -n "Introduzca el nombre del fichero: " 

# Se lee el nombre del fichero
read filename

# Comprobamos que el fichero sea regular
if test -f "$filename"
then
    echo -n "Los permisos del archivo $filename son: "
    # Se comprueba si el usuario puede leer el fichero
    if test -r "$filename"; then echo -n "r"; else echo -n "-"; fi
    # Se comprueba si el usuario puede escribir en el fichero
    if test -w "$filename"; then echo -n "w"; else echo -n "-"; fi
    # Se comprueba si el usuario puede ejecutar el archivo
    if test -x "$filename"; then echo "x"; else echo "-"; fi
else    
    # Si no es un fichero regular se indica por salida estándar
    echo "$filename no existe"
fi