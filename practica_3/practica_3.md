# Práctica 3

He aquí el orden tomado para cumplir con los requisitos del enunciado:
1. Se comprueba que el usuario tiene privilegios de root, comprobando si su *User ID* es 0 (root).
2. Se mira que el número de parámetros sea exactamente 2, haciendo uso de `$#`.
3. Si el número de parámetros es 2, se comprueba si el primer parámetro es `-a` o `-s`.
    * **Caso -a (añadir):** See lee cada una línea del fichero con `while read -r usuario clave nombre`, y posteriormente se verifica en con `test -z` que ninguno de los tres parámetros necesarios es vacío.

        Para comprobar si previamente existe un usuario, se usa `id -u "$usuario"`. Si no existe, creamos uno nuevo usando `useradd` con los siguientes parámetros:     
        * `-m` para crear un directorio home.
        * `-k /etc/skel` para inicializar el directorio home con los ficheros de /etc/skel.
        * `-c "$nombre"` para añadir un comentario (en este caso el nombre completo del usuario).
        * `-K UID_MIN=1815` para establecer que el UID sea mayor o igual que 1815.
        * `-U` para crear un grupo con el mismo nombre del usuario, y añadir al usuario a ese grupo.
        * `"$usuario"` para crear un usuario con el nombre dado por *$usuario*.
        
        Si no ha habido errores con el comando anterior (lo comprobamos con `$?`), se procede cambiar la contraseña del usuario con `chpasswd` y a establecer con `passwd -x 30 "$usuario"` un periodo de duración de la contraseña de 30 días.
    * **Caso -s (suprimir):** Se crea una nuevo directorio */extra/backup* con el comando `mkdir`.
    Se lee de linea en linea del fichero introducido como parámetro para sacar los usuarios. Con el comando `getent passwd "$usuario"` se obtiene la entrada del usuario del archivo passwd y esta se le pasa al comando `cut -d: -f6` para guadar la ruta home en la variable *home_dir*.

    Se hace un respaldo del home de usuario, que se procederá a eliminar, y se guarda en el
    directorio */extra/backup* en formato *.tar* con el nombre del usuario.