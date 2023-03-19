# Práctica 3

He aquí el orden tomado para cumplir con los requisitos del enunciado:
1. Se comprueba que el usuario tiene privilegios de root, comprobando si su *User ID* es 0 (root).
2. Se mira que el número de parámetros sea exactamente 2, haciendo uso de `$#`.
3. Si el número de parámetros es 2, se comprueba si el primer parámetro es `-a` o `-s`.
    * **Caso -a (añadir):** Para comprobar si previamente existe un usuario, se usa `id -u "$usuario"`. 
    
    Si no existe, creamos uno nuevo usando `useradd` con los siguientes parámetros `-m` para crear un directorio home, 
    * **Caso -s (suprimir):**