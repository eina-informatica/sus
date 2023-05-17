#!/bin/bash

# Obtener el prefijo y los directorios de entrada de los argumentos
prefijo=$1
directorios=${@:2}

# Obtener la fecha actual en el formato deseado (YYYY-MM-DD)
fecha=$(date +%Y-%m-%d)

# Crear el nombre del archivo tar utilizando el prefijo y la fecha
nombre_tar="hola$prefijo_$fecha.tar"
echo $nombre_tar

# Crear un archivo vacío para almacenar los nombres de los archivos encontrados
archivos_encontrados="archivos_encontrados.txt"
touch "$archivos_encontrados"

# Recorrer los directorios de entrada
for directorio in $directorios; do
  # Buscar los archivos que no han sido modificados en el último mes y agregarlos al archivo de salida
  find "$directorio" -type f -mtime +30 -print >> "$archivos_encontrados"
done

# Crear el archivo tar con los archivos encontrados
tar -cf "$nombre_tar" -T "$archivos_encontrados"

# Eliminar el archivo temporal de los nombres de los archivos
rm "$archivos_encontrados"

echo "Archivo tar creado: $nombre_tar"
