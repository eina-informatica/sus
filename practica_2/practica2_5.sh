#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, M, 3, A
#842236, Yubero Segura, Andres, M, 3, A

echo -n "Introduzca el nombre de un directorio: "

# Leemos el nombre del directorio
read dir

# Comprobamos que "$dir" es un directorio
if test -d "$dir"
then
    # Con 'ls -l "$dir"' listamos los archivos que se encuentran en el directorio
    # Después con 'grep ^-' filtramos los archivos que empiecen por "-", es decir, que son ficheros
    # Finalmente contamos con 'wc -l' el número de líneas, 
    # que corresponde con el número de ficheros en el directorio
    nFiles=`ls -l "$dir" | grep ^- | wc -l`
    # Para contar el número de directorios hacemos lo mismo,
    # pero al usar 'grep' cambiamos '^-' por '^d' para filtrar los directorios
    nDir=`ls -l "$dir" | grep ^d | wc -l`
    # Mostramos por salida estándar el número de ficheros y directorios
    echo "El numero de ficheros y directorios en $dir es de $nFiles y $nDir, respectivamente"
else
    # Si "$dir" no es un directorio, lo indicamos por salida estándar
    echo "$dir no es un directorio"
fi