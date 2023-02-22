#!/bin/bash

echo -n "Introduzca el nombre del fichero: "
read nomFich
# La variable nomFich toma el valor de un fichero escrito por el usuario a
# Comprobamos si es un fichero regular mediante el comando -f
if [ ! -f "$nomFich" ]
then
# Este mensaje solo se mostrará si el fichero no es regular
echo "$nomFich no existe"
else
# Si el fichero es un fichero regular mostramos sus permisos
echo -n "Los permisos del archivo $nomFich son: "
# Comprobamos si tiene permisos de lectura mediante el comando -r
if [ -r "$nomFich" ]
then
echo -n "r"
else
echo -n "-"
fi
# Comprobamos si tiene permisos de escritura mediante el comando -w
if [ -w "$nomFich" ]
then
echo -n "w"
else
echo -n "-"
fi
# Comprobamos si tiene permisos de ejecución mediante el comando -x
if [ -x "$nomFich" ]
then
echo "x"
else
echo "-"
fi
fi
