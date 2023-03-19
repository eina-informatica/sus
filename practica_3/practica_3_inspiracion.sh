#!/bin/bash
# Realizar un script que permita añadir y suprimir un conjunto de usuarios especificados en un fichero. Cada línea contendrá 3 
# campos separados por comas: "<username>,<passwd>,<full_username>"
# El script debe cumplir los siguientes requisitos:
#   a) Comprobación de usuario con privilegios de administración. Si el script no está siendo ejecutado por un usuario privilegiado, 
#      terminará escribiendo por pantalla: "Este script necesita privilegios de administracion" y el status de salida será 1.
#   b) Dentro de la máquina virtual, el usuario as podrá emplear sudo sin password.
#   c) La creación o borrado de usuarios se especifica mediante el parámetro [-a|-s]. Cualquier otra opción generará el mensaje de 
#      error: "Opcion invalida" por la salida de error, stderr.
#   d) La sintaxis del script es practica_3.sh [-a|-s] <nombre_fichero>. Cuando el número de argumentos sea distinto de 2. El script 
#      mostrará el siguiente mensaje de error: "Numero incorrecto de parametros"
#   e) Para borrar usuarios, sólo es necesario el primer campo del fichero. Es decir, se permiten ficheros que sólo tengan un campo.
#   f) Al añadir usuarios, la caducidad de la nueva contraseña establecida será de 30 días y se escribirá por pantalla el siguiente 
#      mensaje: "<nombre completo del usuario> ha sido creado".
#   g) Al añadir usuarios, si el usuario existe, ni se añadirá ni se cambiará su contraseña y se mostrará el siguiente mensaje por 
#      pantalla: "El usuario <identificador> ya existe". Después de mostrar el mensaje, el script continuará procesando el fichero 
#      de entrada.
#   h) Al añadir usuarios, se comprobará que los 3 campos son distintos de la cadena vacía, si alguno de ellos es igual se abortará la 
#   ejecución y se mostrará el siguiente mensaje: "Campo invalido".
#   i) Al borrar usuarios, si el usuario no existe, se continuará procesando el fichero sin escribir nada por pantalla.
#   j) Es necesario utilizar los comandos: useradd, userdel, usermod y chpasswd.
#   k) Los usuarios deberán tener un UID mayor o igual que 1815.
#   l) Cada usuario tendrá como grupo por defecto uno con su mismo nombre.
#   m) El directorio home de cada usuario se inicializará con los ficheros de /etc/skel.
#   n) El proceso ha de ser completamente automático, sin interacción del administrador.
#   o) El borrado de usuarios será completo, incluyendo su directorio home.
#   p) Antes de borrar un usuario, el script realizará un backup de su directorio home (mediante tar y con nombre <usuario>.tar) que 
#      será guardado en el directorio /extra/backup.
#   q) Si el argumento es “-s”, borrado usuarios, se debe crear el directorio /extra/backup aunque no se borre ningún usuario.
#   r) En caso de que el backup no pueda ser completado satisfactoriamente, no se realizará el borrado.
#
#"$USER ALL=(ALL) NOPASSWD:ALL"
if [ $EUID -ne 0 ]; then echo "Este script necesita privilegios de administracion"; exit 1; fi
if [ $# -eq 2 ]
then
    # ADD USER
    if [ $1 = "-a" ]
    then
        # READING USER PER USER
        while IFS= read -r user
        do
            IFS=,
            read -ra user_fields <<< "$user"
            if [ ${#user_fields[@]} -ne 3 ]; then exit 1; fi
            for i in "${user_fields[@]}"
            do 
                if [ -z i ]; then echo "Campo invalido"; exit 1; fi
            done
            # ADDING NEW USER
            useradd -m -k /etc/skel -U -K UID_MIN=1815 -c "${user_fields[2]}" "${user_fields[0]}" &>/dev/null
            if [ $? -eq 0 ]
            then
                usermod -aG 'sudo' ${user_fields[0]}
                passwd -x 30 ${user_fields[0]} &>/dev/null
                echo "${user_fields[0]}:${user_fields[1]}" | chpasswd
                echo "${user_fields[2]} ha sido creado"
            else echo "El usuario ${user_fields[0]} ya existe".
            fi
        done < $2
    # DELETE USER
    elif [ $1 = "-s" ]
    then
        # BACKUP DIRECTORY CREATION
        if [ ! -d /extra ]; then mkdir -p /extra/backup
        elif [ ! -d /extra/backup ]; then mkdir /extra/backup
        fi
        # READING USER PER USER
        while IFS= read -r user
            do
                IFS=,
                read -ra user_fields <<< "$user"
                if [ ${#user_fields[@]} -ne 1 -a ${#user_fields[@]} -ne 3 ]; then exit 1; fi
                for i in "${user_fields[@]}"
                do 
                    if [ -z i ]; then echo "Campo invalido"; exit 1; fi
                done
                # ADDING NEW USER
                user_home="$(getent passwd ${user_fields[0]} | cut -d: -f6)"
                tar cvf /extra/backup/${user_fields[0]}.tar $user_home &>/dev/null
                if [ $? -eq 0 ]; then userdel -f ${user_fields[0]} &>/dev/null; fi
            done < $2
    # INVALID OPTION
    else echo "Opcion invalida" 1>&2
    fi
else echo "Numero incorrecto de parametros"
fi
