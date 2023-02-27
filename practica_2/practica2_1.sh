#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, [M], [3], [A]
#842236, Yubero Segura, Andres, [M], [3], [A]

echo -n "Introduzca el nombre del fichero: "
read FILENAME
if test -f $FILENAME
then
    echo -n "Los permisos del archivo $FILENAME son: "
    echo ls -l $FILENAME | cut -c2-4
else
    echo "$FILENAME no existe"
fi