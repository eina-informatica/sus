#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, M, 3, A
#842236, Yubero Segura, Andres, M, 3, A

# Comprobamos que el usuario tiene privilegios de administración
if test "$UID" -ne 0
then
    # No tiene privilegios de administración
    echo "Este script necesita privilegios de administracion"
    exit 1
fi

# Comprobamos que el fichero tiene exactamente dos parámetros
if test $# -eq 2
then 
    # Comprobamos si tenemos que añadir un usuario
    if test $1 = "-a"
    then 
        # Cambiamos el IFS, guardando su valor actual el oldIFS
        oldIFS=$IFS
        IFS=,
        # Leemos cada una de las líneas del fichero (hay una línea por usuario)
        while read -r usuario clave nombre
        do
            # Comprobamos que no hay campos inválidos
            if test -z "$usuario" || test -z "$clave" || test -z "$nombre"
            then
                echo "Campo invalido"
                exit 2
            else
                # Comprobamos si el usuario ya existe
                if id -u "$usuario" >/dev/null 2>&1
                then
                    echo "El usuario $usuario ya existe"
                else
                    # Creamos el usuario
                    useradd -m -k /etc/skel -c "$nombre" -K UID_MIN=1815 -U "$usuario" &>/dev/null
                    if test $? -eq 0
                    then
                        # Cambiamos la contraseña del usuario
                        echo "$usuario:$clave" | chpasswd &>/dev/null
                        # Establecemos la contraseña para 30 días
                        passwd -x 30 "$usuario" &>/dev/null
                        # Añadimos el usuario al grupo de sudoers
                        usermod -aG "sudo" "$usuario" &>/dev/null
                        echo "$nombre ha sido creado"
                    fi
                fi
            fi
        done < $2
        # Devolvemos el valor original a IFS
        IFS=$oldIFS
        
    # Comprobamos si tenemos que suprimir un usuario
    elif test $1 = "-s"
    then
        # Se crea el directorio de respaldo para los directorios home de los usuarios borrados
        mkdir -p /extra/backup

        # Leemos cada una de las líneas del fichero (hay una línea por usuario)
        while read -r linea
        do
            # Conseguimos el nombre del usuario
            usuario=$(echo "$linea" | cut -d, -f1)
            # Obtenemos el directorio home
            home_dir=$(getent passwd "$usuario" | cut -d: -f6)
            # Hacer backup del directorio home del usuario
            tar -cf "/extra/backup/$usuario.tar" "$home_dir" &>/dev/null
            # Si no ha habido ningún problema con el comando anterior
            if test $? -eq 0
            then
                # Eliminamos el usuario
                userdel -fr "$usuario" &>/dev/null
            fi
        done < $2
    # El primer parámetro no es ninguna de las dos opciones anteriores
    else
        echo "Opcion invalida">&2
    fi
else
    # Si no tiene dos parámetros, mostramos el siguiente mensaje por salida estándar
    echo "Numero incorrecto de parametros"
fi
