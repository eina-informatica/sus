#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, M, 3, A
#842236, Yubero Segura, Andres, M, 3, A

# Comprobamos si se ha proporcionado una dirección IP como parámetro
if [ $# -ne 1 ]; then
    echo "Debes pasar una dirección IP como parámetro"
    exit 1
fi

# Dirección IP del servidor remoto
ip=$1

# Comprobamos que podemos conectarnos a la máquina
ssh -n as@$ip &>/dev/null
if test "$?" -eq 0
then
    # Comprobamos la situación de uso y organización de espacio de disco
    echo "Discos duros disponibles y sus tamaños:"
    ssh -n as@$ip "sfdisk -s"
    echo "Particiones y sus tamaños:"
    ssh -n as@$ip "sfdisk -l"

    # Información de montaje de sistemas de ficheros (salvo tmpfs)
    echo "Información de montaje de sistemas de ficheros:"
    ssh -n as@$ip "df -hT -x tmpfs"

    exit 0
else 
    echo "Error al conectarse via SSH"
    exit 2
fi