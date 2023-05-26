#!/bin/bash

# Ejecuta traceroute y almacena la salida en un archivo temporal
traceroute_output=$(traceroute -q 3 www.google.com > traceroute_output.txt)

# Extrae los nodos visitados y sus RTT medios del archivo temporal
nodes_rtt=$(grep -oP ' \d+\.\d+ ms' traceroute_output.txt | awk '{print $1}')

# Cuenta el número de nodos visitados
num_nodes=$(echo "$nodes_rtt" | wc -l)

# Muestra el número de nodos visitados
echo "Número de nodos visitados: $num_nodes"

# Muestra los 5 nodos con mayor RTT medio
echo -e "\nLos 5 nodos con mayor RTT medio:"

# Ordena los RTT medios en orden descendente y toma los 5 primeros
top_nodes_rtt=$(echo "$nodes_rtt" | sort -rn | head -n 5)

# Recorre los RTT medios y muestra los nodos correspondientes
while read -r rtt; do
    node=$(grep -oP "\d+\.\d+\.\d+\.\d+" traceroute_output.txt | grep -B1 "$rtt" | head -n 1)
    echo "Nodo: $node - RTT medio: $rtt"
done <<< "$top_nodes_rtt"

# Elimina el archivo temporal
rm traceroute_output.txt

