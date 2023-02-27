#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, [M], [3], [A]
#842236, Yubero Segura, Andres, [M], [3], [A]

# Define el patrón del nombre de directorio
DIR_PATTERN="bin*"

# Encuentra el directorio más antiguo que sigue el patrón
OLD_DIR=$(find ~ -maxdepth 1 -type d -name "$DIR_PATTERN" -printf "%T@ %p\n" | sort -n | head -n 1 | cut -f2- -d' ')

# Si no hay ningún directorio que sigue el patrón, crea uno nuevo
if [ -z "$OLD_DIR" ]; then
  NEW_DIR=$(mktemp -d ~/binXXX)
else
  # Si hay al menos un directorio que sigue el patrón, utiliza el más antiguo
  NEW_DIR=$(mktemp -d --directory --suffix= "${OLD_DIR##*/}")
fi

echo "Se ha creado el directorio $NEW_DIR"
echo "Directorio destino de copia: $NEW_DIR"

# Copia los archivos ejecutables al nuevo directorio
count=0
for file in $(find . -maxdepth 1 -type f -executable); do
  cp -v "$file" "$NEW_DIR"
  ((count++))
done

if [ $count -eq 0 ]; then
  echo "No se ha copiado ningún archivo."
else
  echo "Se han copiado $count archivos."
fi

exit 0
