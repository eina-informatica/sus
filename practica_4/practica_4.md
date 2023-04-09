# Práctica 4

## Configuración de las máquinas virtuales

Para configurar las máquinas virtuales según los requerimientos especificados, es necesario realizar los siguientes pasos:

En primer lugar, se debe instalar sudo con el comando `apt install sudo`. Luego, se procede a editar el archivo */etc/sudoers* utilizando el comando `sudo visudo` y agregar la línea `as ALL=(ALL) NOPASSWD:ALL` para permitir que el usuario *as* pueda ejecutar cualquier comando sin introducir su contraseña.

Seguidamente, se debe configurar la interfaz de red en */etc/network/interfaces* con los siguientes parámetros:

`auto enp0s8`
`iface enp0s8 inet static`
`address 192.168.56.11 # 192.168.56.12 para debian-as2`
`netmask 255.255.255.0`

Después, se aplican los cambios usando `sudo ifdown enp0s8 && sudo ifup enp0s8`, y se comprueba mediante el comando `ip` y sus opciones que la red se ha configurado correctamente. Además se usa `ping IP de la máquina` para comprobar que ambas máquinas se pueden comunicar con el host.

Posteriormente, se instala el servidor SSH con `sudo apt install openssh-server`, se edita el archivo de configuración de SSH en */etc/ssh/sshd_config* con el comando `nano /etc/ssh/sshd_config` y se añade la línea `PermitRootLogin no` para deshabilitar el acceso de root mediante SSH.

Finalmente, para aplicar los cambios realizados, se reinicia el servicio SSH utilizando el comando `systemctl restart sshd`.

## Generación de claves SSH

En primer lugar, se debe generar una clave ssh para el usuario *as* utilizando el comando `ssh-keygen -f $HOME/.ssh/id_as_ed25519 -t ed25519`. La opción `-f` especifica el nombre y la ruta del archivo donde se guardarán las claves generadas, en este caso en el directorio *.ssh* del directorio home del usuario actual. La opción `-t` especifica el tipo de algoritmo a utilizar para generar las claves, en este caso *ed25519*.

Para poder iniciar sesión en las máquinas virtuales *192.168.56.11* y *192.168.56.12* sin necesidad de introducir una contraseña, se debe copiar en ellas la clave pública. Para ello, se utiliza el comando `ssh-copy-id -i $HOME/.ssh/id_as_ed25519.pub as@192.168.56.11`, el cual copia la clave pública en el servidor remoto con dirección IP *192.168.56.11* y permite el inicio de sesión sin contraseña.

Se repite el mismo comando para copiar la clave pública en el servidor remoto con dirección IP *192.168.56.12*, de modo que el usuario *as* pueda iniciar sesión en ambos servidores remotos sin necesidad de introducir una contraseña.