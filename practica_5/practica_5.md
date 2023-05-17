# PRÁCTICA 5

## PARTE I
1. Se han empleado las máquinas de la práctica anterior para realizar esta práctica. Antes de iniciarla hemos añadido un disco duro de 4MB en el controlador SATA.
2. Instalar parted con `sudo apt install parted`
3. Instalar lvm2 con `sudo apt install lvm2` y comprobar con `systemctl list-units` que el servicio lvm2 está corriendo.
4. Con `lvmdiskscan` se listan los volúmenes físicos.
5. Generar un tabla de particiones GUID con el comando `sudo parted /dev/sdb`
	> mklabel gpt (Para crear tabla de particiones)
	> mkpart primary ext3 0% 50%
	> mkpart primary ext4 50% 100%
	> print (Para ver la info)
	> quit
6. Se verifica la partición con `sudo fdisk -l /dev/sdb`
7. Se crean los directorios para montar las particiones:
	mkdir /mnt/ext3
	mkdir /mnt/ext4
8. Crear sistemas de ficheros
	mkfs.ext3 /dev/sdb1
	mkfs.ext4 /dev/sdb2
9. Se montan las particiones
	mount /dev/sdb1 /mnt/ext3
	mount /dev/sdb2 /mnt/ext4
10. Se verifica el correcto montaje con `cat /etc/mtab`
11. Se abre el fichero "/etc/fstab" con `sudo nano /etc/fstab` y añadimos:
	/dev/sdb1    /mnt/ext3    ext3    defaults    0    2
	/dev/sdb2    /mnt/ext4    ext4    defaults    0    2

12. Se ejecuta `sudo reboot`
13. Usamos `mount` para ver si se ha montado correctamente.

## PARTE II
Se ha realizado el script `practica5_parte2.sh`.

## PARTE III
1. Se emplea `lvmdiskscan` para listar los volúmenes físicos.
2. Ejecutamos `sudo fdisk /dev/sdc`
	> n (Nueva partición a añadir)
	> p (Partición primaria)
	> 1 (Número de partición)
	> Valor predeterminado en los sectores
	> t (Cambiar el tipo de partición)
	> 8e (Código de Linux LVM)
	> w (Abandonar el entorno fdisk)
3. Ejecutamos `sudo parted /dev/sdc set 1 lvm on`
4. Se crea un grupo volumen con `sudo vgcreate vg_p5 /dev/sdc1`, y se procede a probar el script `practica5_parte3_vg.sh`, desmontando 
5. Desmontamos con `umount -l /dev/sdb1`
6. Probamos el script con `./practica5_parte3_vg.sh vg_p5 /dev/sdb1 /dev/sdb2`
7. Se comprueba con `vgdisplay` que se ha hecho todo correctamente.
8. Ejecutamos el segundo script con `cat volumenes.txt | ./practica5_parte3_lv.sh`
9. Con `lvdisplay` nos aseguramos que todo esté correcto.
