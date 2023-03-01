#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, M, 3, A
#842236, Yubero Segura, Andres, M, 3, A

# Explicación de la primera línea de código
# - Con "stat -c %n,%Y ~/bin???" obtenemos los directorios del estilo binXXX 
#   que se encuentran en root
# - Con "2> /dev/null" nos deshacemos de la salida de error del comando anterior
# - Con "sort -t ',' -k 2", ordenamos los resultados usando la coma como separador
#   en función de la fecha de modificación (segunda clave), más antiguo primero
# - Con "head -n 1" seleccionamos la primera línea del resultado del "sort"
# - Finalmente cortamos usando la coma y seleccionando el primer campo que es el nombre
dir=`stat -c %n,%Y ~/bin??? 2> /dev/null | sort -t ',' -k 2 | head -n 1 | cut -d ',' -f 1`

# Si no hay ningún directorio que siga el patrón binXXX
if test -z "$dir"
then
    # Creamos un directorio nuevo
    dir=`mktemp -d ~/binXXX` 
    # Indicamos que se ha creado el directorio
    echo "Se ha creado el directorio $dir"
fi

# Mostramos el directorio destino al que vamos a copiar
echo "Directorio destino de copia: $dir"

# Variable contadora para mostrar posteriormente el número de ficheros movidos
count=0
# Iteramos por cada fichero ejecutable
for file in $(find . -maxdepth 1 -type f -executable); do
    # Movemos el fichero al directorio "$dir"
    cp "$file" "$dir"
    # Indicamos que el fichero se ha copiado
    echo "$file ha sido copiado a $dir"
    # Incrementamos el contador
    ((count++))
done

# Si el número de ficheros movidos es cero
if test $count -eq 0
then
    # Indicamos que no se ha copiado ningún fichero
    echo "No se ha copiado ningun archivo"
else
    # Mostramos por salida estándar el número de archivos copiados
    echo "Se han copiado $count archivos"
fi