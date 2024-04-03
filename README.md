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

```
git clone https://github.com/pgraffigna/ansible_role_osticket.git
cd ansible_role_osticket
ansible-playbook main.yml
```

### Extras
* Archivo de configuración (Vagrantfile) para desplegar una VM descartable con ubuntu-22.04 con libvirt como hipervisor.
* Carpeta con scripts en php para realizar consultas sobre el controlador + los APs.
* Archivo ***.editorconfig*** para configurar los parametros en vscode/vscodium.

### Uso Vagrant (opcional)
```
vagrant up 
vagrant ssh
```