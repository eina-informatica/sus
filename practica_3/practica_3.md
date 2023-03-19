# Práctica 3

He aquí el orden tomado para cumplir con los requisitos del enunciado:
1. Se comprueba que el usuario tiene privilegios de root, comprobando si su *User ID* es 0 (root).
2. Se mira que el número de parámetros sea exactamente 2, haciendo uso de `$#`.
3. Si el número de parámetros es 2, se comprueba si el primer parámetro es `-a` o `-s`.
    * **Caso -a (añadir):** Para comprobar si previamente existe un usuario, se usa `id -u "$usuario"`. Si no existe, creamos uno nuevo usando `useradd` con los siguientes parámetros:     
        * `-m` para crear un directorio home.
        * `-k /etc/skel` para inicializar el directorio home con los ficheros de /etc/skel.
        * `-c "$nombre"` para añadir un comentario (en este caso el nombre completo del usuario).
        * `-K UID_MIN=1815` para establecer que el UID sea mayor o igual que 1815.
        * `-U` para crear un grupo con el mismo nombre del usuario, y añadir al usuario a ese grupo.
        * `"$usuario"` para crear un usuario con el nombre dado por *$usuario*.
        
    sfdsfsf
    * **Caso -s (suprimir):**Se crea una nuevo directorio */extra/backup* con el comando `mkdir`.
    Se lee de linea en linea del fichero introducido como parámetro para sacar los usuarios. Con el comando `getent passwd "$usuario"`  