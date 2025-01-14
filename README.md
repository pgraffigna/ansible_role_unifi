## ansible_role_unifi
Ansible rol para instalar un controlador Unifi para gestión de redes wifi.

Testeado con Vagrant + QEMU + ubuntu_22.04.

---
### Descripción

La idea del proyecto es automatizar vía ansible la instalación/configuración de un servicio [unifi](https://help.ui.com/hc/en-us/articles/360012282453-Self-Hosting-a-UniFi-Network-Server) para pruebas de laboratorio, el repo cuenta con 2 roles:

1. mongo
2. unifi

### Dependencias

* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html)
* [Vagrant](https://developer.hashicorp.com/vagrant/install) (opcional)

### Uso
```shell
git clone https://github.com/pgraffigna/ansible_role_unifi.git
cd ansible_role_unifi
ansible-playbook main.yml
```

### Extras
* Archivo de configuración (Vagrantfile) para desplegar una VM descartable con ubuntu-22.04 con libvirt como hipervisor.
* Archivo ***.editorconfig*** para configurar los parametros en vscode/vscodium.
* Carpeta ***docker*** con archivos para desplegar un controlador via docker-compose
* Script en bash para consultar estado de los vouchers de todos los sitios del controlador.

### Uso Vagrant (opcional)
```shell
vagrant up
vagrant ssh
```

### Vouchers via API
```shell
# Autenticando contra el controlador
curl -sk -c /tmp/cookies.txt -X POST https://URL/api/login -H "Content-Type: application/json" \
		-d '{ "username":USERNAME,"password":PASSWORD}'

# Chequeando el estado de los vouchers
curl -sk -X GET "https://URL:8443/api/s/ID_SITIO/stat/voucher" -H "Content-Type: application/json" \
    -b /tmp/cookies.txt
```

