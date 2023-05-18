Después de crear las máquinas virtuales, renombramos los hostnames para identificarlas mejor con nano /etc/hostname.

IPs para cada red interna
Red interna 1: 192.168.11.0/24
Red interna 2: 192.168.12.0/24
Red interna 3: 192.168.13.0/24

Configuramos la red en cada debian con nano /etc/network/interfaces
Debian1:
	auto enp0s8 
iface enp0s8 inet static 
address 192.168.57.2

# Red interna 1
auto enp0s9
iface enp0s9 inet static
address 192.168.11.1
netmask 255.255.255.0
broadcast 192.168.11.255
network 192.168.11.0

# Red interna 2
auto enp0s10
iface enp0s10 inet static
address 192.168.12.1
netmask 255.255.255.0
broadcast 192.168.12.255
network 192.168.12.0

Debian2:
# Red interna 1
auto enp0s3
iface enp0s3 inet static
address 192.168.11.2
netmask 255.255.255.0
gateway 192.168.11.1
network 192.168.11.0

Debian3:
# Red interna 2
auto enp0s3
allow-hotplug enp0s3
iface enp0s3 inet dhcp

Debian4:
# Red interna 2
auto enp0s3
allow-hotplug enp0s3
iface enp0s3 inet dhcp

Debian5: 
# Red interna 3
auto enp0s3
iface enp0s3 inet static
address 192.168.13.2
netmask 255.255.255.0
gateway 192.168.13.1
network 192.168.13.0

Debian6:
	# Red interna 2
auto enp0s3
iface enp0s3 inet static
address 192.168.12.2
netmask 255.255.255.0
gateway 192.168.12.1
network 192.168.12.0

# Red interna 3
auto enp0s8
iface enp0s8 inet static
address 192.168.13.1
netmask 255.255.255.0
network 192.168.13.0
	
 systemctl restart networking

Configuración servidor DHCP
sudo apt install isc-dhcp-server
nano /etc/dhcp/dhcpd.conf

Configuración de la red interna en /etc/dhcp/dhcpd.conf
subnet 192.168.12.0 netmask 255.255.255.0 {
  range 192.168.12.3 192.168.12.9;
  option domain-name-servers ns1.internal.example.org;
  option domain-name "internal.example.org";
  option routers 192.168.12.1;
  option broadcast-address 192.168.12.255;
  default-lease-time 600;
  max-lease-time 7200;
}

nano /etc/default/isc-dhcp-server
INTERFACESv4=”enp0s10”

nano /etc/sysctl.conf
Descomentar net.ipv4.ip_forward=1

/etc/hosts -> Cambiar as-debian por debian1
sudo service isc-dhcp-server status
sudo /etc/init.d/isc-dhcp-server restart
Configurar firewall y router
sudo apt install iptables-persistent

Se ejecutan las siguientes reglas de iptables:
# LIMPIEZA DE REGLAS EN IPTABLES
iptables -F

# Políticas por defecto
iptables -P INPUT DROP
iptables -P FORWARD DROP

# Se da acceso a las tres redes internas
iptables -t nat -A POSTROUTING -s 192.168.11.0/24 -o enp0s3 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.12.0/24 -o enp0s3 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.13.0/24 -o enp0s3 -j MASQUERADE

# A todo lo que sale a la extranet se le proporciona la IP de debian1
iptables -t nat -A POSTROUTING -o enp0s3 -j SNAT --to 192.168.57.2
iptables -t nat -A POSTROUTING -o enp0s8 -j SNAT --to 192.168.57.2

# Redirección de peticiones desde el NAT al servidor web de Apache de debian2 y al servidor ssh de debian5
iptables -t nat -A PREROUTING -i enp0s3 -p tcp --dport 22 -j DNAT --to 192.168.13.2:22
iptables -t nat -A PREROUTING -i enp0s3 -p tcp --dport 80 -j DNAT --to 192.168.11.2:80

# Redirección de peticiones desde el host al servidor web de Apache de debian2 y al servidor ssh de debian5
iptables -t nat -A PREROUTING -i enp0s8 -p tcp --dport 22 -j DNAT --to 192.168.13.2:22
iptables -t nat -A PREROUTING -i enp0s8 -p tcp --dport 80 -j DNAT --to 192.168.11.2:80

# Se permite el paso del tráfico hacia la extranet (SSH y servidor web)
iptables -A FORWARD -i enp0s3 -p all -j ACCEPT
iptables -A FORWARD -i enp0s8 -p all -j ACCEPT

# Se permite todo el paso hacia red interna 1 y red interna 2
iptables -A FORWARD -i enp0s9 -p all -j ACCEPT
iptables -A FORWARD -i enp0s10 -p all -j ACCEPT

# Se permite el tráfico hacia debian5 por el puerto 22 (ssh) y hacia debian2 por el puerto 80
iptables -A FORWARD -p tcp --dport 22 -d 192.168.13.2 -j ACCEPT
iptables -A FORWARD -p tcp --dport 80 -d 192.168.11.2 -j ACCEPT

# Permite que entre todo el tráfico de intranet
iptables -A INPUT -i lo -p all -j ACCEPT
iptables -A INPUT -i enp0s9 -p all -j ACCEPT
iptables -A INPUT -i enp0s10 -p all -j ACCEPT

# Preservación de las reglas iptables
iptables-save > /etc/iptables/rules.v4

Se comprueban que los paquetes que llegan a un debian con
tcpdump -i <nombre interfaz>

Instalar nginx
apt install nginx
systemctl status nginx
systemctl start nginx

Para ver la web por terminal se puede usar “curl”
apt install curl

Configuración en /etc/network/interfaces
Debian1
up ip route add 192.168.13.0/24 via 192.168.12.2 dev enp0s10
up ip route add 192.168.57.0/24 via 192.168.57.2 dev enp0s8

Instalar ssh
Posteriormente, se instala el servidor SSH con `sudo apt install openssh-server`, se edita el archivo de configuración de SSH en */etc/ssh/sshd_config* con el comando `nano /etc/ssh/sshd_config` y se añade la línea `PermitRootLogin no` para deshabilitar el acceso de root mediante SSH.