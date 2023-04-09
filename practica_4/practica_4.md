# Práctica 4

## Configuración de las máquinas virtuales

Para configurar las máquinas virtuales según los requerimientos especificados, es necesario realizar los siguientes pasos:

En primer lugar, se debe instalar sudo con el comando `apt install sudo`. Luego, se procede a editar el archivo */etc/sudoers* utilizando el comando `sudo visudo` y agregar la línea `as ALL=(ALL) NOPASSWD:ALL` para permitir que el usuario *as* pueda ejecutar cualquier comando sin introducir su contraseña.

Seguidamente, se debe configurar la interfaz de red en */etc/network/interfaces* con los siguientes parámetros:

`auto enp0s3`
`iface enp0s3 inet static`
`address 192.168.56.11 # 192.168.56.12 para debian-as2`
`netmask 255.255.255.0`

Después, se comprueba con 

Posteriormente, se edita el archivo de configuración de SSH en */etc/ssh/sshd_config* con el comando `nano /etc/ssh/sshd_config` y se cambia la línea `PermitRootLogin` a `no` para deshabilitar el acceso de root mediante SSH.

Finalmente, para aplicar los cambios realizados, se reinicia el servicio SSH utilizando el comando `systemctl restart sshd`.

Con estos pasos se habrá completado la configuración de las máquinas virtuales según los requerimientos especificados.

## Generación de claves SSH