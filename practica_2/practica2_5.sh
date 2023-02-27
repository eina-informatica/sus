#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, [M], [3], [A]
#842236, Yubero Segura, Andres, [M], [3], [A]

echo -n "Introduzca el nombre de un directorio: "
read directory
if test -d $directory
then
    nFiles=`ls -l $directory | grep ^- | wc -l`
    nDirectories=`ls -l $directory | grep ^d | wc -l`
    echo "El numero de ficheros y directorios en $directory es de $nFiles y $nDirectories, respectivamente"
else
    echo "$directory no es un directorio"
fi