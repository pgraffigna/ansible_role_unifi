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

# función de limpieza
function cleanup() {
    if [[ -f "/tmp/${UNIFI_OS_INSTALLER}" ]]; then
        rm -f "/tmp/${UNIFI_OS_INSTALLER}"
    fi
}

# variables globales
USUARIO="vagrant"
UNIFI_OS_VERSION="5.0.6"
UNIFI_OS_URL="https://fw-download.ubnt.com/data/unifi-os-server/1856-linux-x64-${UNIFI_OS_VERSION}-33f4990f-6c68-4e72-9d9c-477496c22450.6-x64"
UNIFI_OS_INSTALLER="uos_${UNIFI_OS_VERSION}_installer"

# ejecutar cleanup al salir (por cualquier motivo)
trap cleanup EXIT

# validar root
if [[ "$EUID" -ne 0 ]]; then
  echo -e "${ROJO}El script debe ejecutarse como root.${FIN}"
  exit 1
fi

echo -e "${AMARILLO}====== Actualiza los repos / Instala Podman ======${FIN}"
apt update && apt upgrade -y
apt install podman slirp4netns uidmap -y

echo -e "${AMARILLO}====== Instala dependencias de podman ======${FIN}"
apt install -y netavark

echo -e "${AMARILLO}====== Descarga UniFi OS Server ======${FIN}"
wget -q --show-progress --progress=bar:force 2>&1 "${UNIFI_OS_URL}" -O "/tmp/${UNIFI_OS_INSTALLER}"

echo -e "${AMARILLO}====== Instala Unifi OS Server ======${FIN}"
chmod +x "/tmp/${UNIFI_OS_INSTALLER}"
"/tmp/${UNIFI_OS_INSTALLER}"

echo -e "${VERDE}====== La instalación termino exitosamente! ======${FIN}"

