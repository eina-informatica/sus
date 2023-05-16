#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, M, 3, A
#842236, Yubero Segura, Andres, M, 3, A

OLDIFS=$IFS
# Leer las especificaciones de entrada estándar
while IFS=',' read -r group_name lv_name size fs_type mount_dir
do
    # Directorio del volumen
    vdir=$(echo "/dev/$group_name/$lv_name")
    # Miramos si hay coincidencia
    lvdisplay | grep "$vdir" &> /dev/null

    # Verificar si el volumen lógico ya existe
    if [ $? -eq 0 ]
        echo "El volumen lógico $lv_name ya existe. Lo ampliamos."
        # Extiende el volumen lógico
        lvextend -L$size $vdir
        # Redimensiona el sistema de archivos
        resize2fs $vdir
    else
        # Crear el volumen lógico
        lvcreate -L "$size" -n "$lv_name" "$group_name"
        
        if [ $? -eq 0 ]; then
            # Crear sistema de ficheros
            mkfs -t "$fs_type" "$vdir"
            
            # Crear el directorio de montaje si no existe
            if [ ! -d "$mount_dir" ]; then
                mkdir -p "$mount_dir"
            fi
            
            # Montar el volumen lógico
            mount "$vdir"
            
            # Agregar la entrada al archivo /etc/fstab si el volumen lógico es nuevo
            if ! grep -q "$lv_name" /etc/fstab; then
                echo "$vdir $mount_dir $fs_type defaults 0 0" >> /etc/fstab
            fi
        fi
    fi
done
IFS=$OLDIFS