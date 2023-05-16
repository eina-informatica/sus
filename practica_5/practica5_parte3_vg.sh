#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, M, 3, A
#842236, Yubero Segura, Andres, M, 3, A

# Verificar que se proporcionaron los argumentos necesarios
if [ $# -lt 2 ]; then
  echo "Sintaxis: $0 <grupo_volumen> <particion1> [<particion2> ...]"
  exit 1
fi

# Primer parámetro: grupo volumen
grupo_volumen=$1

# Resto de los parámetros: particiones a añadir
particiones="${@:2}"

# Extender el grupo volumen
vgextend $grupo_volumen $particiones