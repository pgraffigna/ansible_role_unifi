#!/bin/bash
# script para instalar Ubiquiti Unifi Controller on Ubuntu 20.04.

# colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

# ctrl_c
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${ROJO}Programa Terminado por el usuario ${FIN}"
        exit 0
}

echo -e "${AMARILLO}unifi: actualizacion de los repos + instalacion ${FIN}"
sudo apt update && sudo apt install -y apt-transport-https

echo -e "\n${AMARILLO}unifi: descargando llave ${FIN}"
sudo wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg

echo -e "\n${AMARILLO}unifi: agregando repos ${FIN}"
echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list

echo -e "\n${AMARILLO}unifi: re-actualizando los repos + instalando unifi ${FIN}"
sudo apt update && sudo apt install -y openjdk-8-jre-headless unifi

echo -e "\n${VERDE}unifi: el servidor unifi ha sido instalado!! ${FIN}"


## instructivo 
## https://gist.github.com/davecoutts/5ccb403c3d90fcf9c8c4b1ea7616948d
