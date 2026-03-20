ENV['VAGRANT_DEFAULT_PROVIDER'] = 'libvirt'
IMAGEN = "alvistack/ubuntu-24.04"
HOSTNAME = "unifi-os.home.local"

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.vm.box_check_update = false
  config.vm.synced_folder ".", "/vagrant", type: "rsync", disabled: true

  config.vm.define :server do |s|
    s.vm.box = IMAGEN
    s.vm.hostname = HOSTNAME
    s.vm.provision :docker
    s.vm.provision :docker_compose

    s.vm.provider :libvirt do |v|
      v.memory = 2048
      v.cpus = 2
      v.graphics_type = "none"
      v.cpu_mode = "host-passthrough"
      v.nic_model_type = "virtio"
      v.disk_bus = "virtio"
    end
  end
end
