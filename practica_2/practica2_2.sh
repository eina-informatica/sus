#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, M, 3, A
#842236, Yubero Segura, Andres, M, 3, A

# Iteramos por cada uno de los ficheros que nos han pasado como parámetro,
# respetando aquellos que tienen espacios en el nombre
for filename in "$@"
do
    # Comprueba si es un fichero regular
    if test -f "$filename"
    then
        # Si lo es, se pagina por salida estándar
        more "$filename"
    else
        # Si no es regular, se indica por salida estándar
        echo "$filename no es un fichero."
    fi
done