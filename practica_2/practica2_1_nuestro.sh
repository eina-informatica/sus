#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, [M], [3], [A]
#842236, Yubero Segura, Andres, [M], [3], [A]

echo -n "Introduzca el nombre del fichero: "
read filename
if test -f $filename
then
    echo -n "Los permisos del archivo $filename son: "
    echo ls -l $filename | cut -c2-4
else
    echo "$filename no existe"
fi