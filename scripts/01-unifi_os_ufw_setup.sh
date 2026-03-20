#!/usr/bin/env bash
#
# Autor: Pablo Graffigna
# URL: www.linkedin.com/in/pablo-graffigna
#
set -e

# colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

# funcion ctrl-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${ROJO}=== Programa Terminado por el usuario ===${FIN}"
        exit 0
}

# validar root
if [[ "$EUID" -ne 0 ]]; then
    echo -e "${ROJO}El script debe ejecutarse como root.${FIN}"
    exit 1
fi

echo -e "${VERDE}Verificando UFW...${FIN}"
if ! command -v ufw &> /dev/null; then
    echo -e "${AMARILLO}UFW no está instalado. Instalando...${FIN}"
    apt update && apt install -y ufw
else
    echo -e "${VERDE}UFW ya está instalado.${FIN}"
fi

echo -e "${VERDE}Creando profile de UniFi para UFW...${FIN}"
cat <<EOF > /etc/ufw/applications.d/unifi
[UNIFI]
title=UniFi OS Server
description=3478 STUN | 5005 Discovery | 6789 Adoption | 8080 HTTP | 8443 HTTPS | 8880 Redirect HTTP | 8881 Redirect HTTPS | 10003 Monitoring | 11443 WebSockets | 8843 Server
ports=3478/udp|5005/udp|6789/tcp|8080/tcp|8443/tcp|8880/tcp|8881/tcp|10003/udp|11443/tcp|8843/tcp
EOF

echo -e "${VERDE}Actualizando perfiles de UFW...${FIN}"
ufw app update UNIFI

echo -e "${VERDE}Aplicando reglas de UniFi...${FIN}"
ufw allow UNIFI

# verificar si UFW está activo
if ! ufw status | grep -q "Status: active"; then
    echo -e "${AMARILLO}UFW no está activo. Habilitando...${FIN}"
    ufw --force enable
else
    echo -e "${VERDE}UFW ya está activo.${FIN}"
fi

echo -e "${VERDE}Configuración de UFW completa / Mostrando perfil UNIFI${FIN}"
ufw app info UNIFI