#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, [M], [3], [A]
#842236, Yubero Segura, Andres, [M], [3], [A]

dir=`stat -c %n,%Y ~/bin??? 2> /dev/null | sort -t ',' -k 2 | head -n 1 | cut -d ',' -f 1`

# Si no hay ningún directorio que siga el patrón binXXX
if test -z "$dir"
then
dir=`mktemp -d ~/binXXX` # Creamos un directorio nuevo
echo "Se ha creado el directorio $dir"
fi

echo "Directorio destino de copia: $dir"

count=0
for file in $(find . -maxdepth 1 -type f -executable); do
    cp "$file" "$dir"
    echo "$file ha sido copiado a $dir"
    ((count++))
done

if test $count -eq 0
then
    echo "No se ha copiado ningun archivo"
else
    echo "Se han copiado $count archivos"
fi