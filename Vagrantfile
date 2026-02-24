# Configuració Global
NUM_WORKER_NODES = 2
IP_NW = "192.168.3."
IP_controlplane = "192.168.3.10" # Fixem la IP del controlplane per referenciar-la als workers

Vagrant.configure("2") do |config|
  
  config.vm.define "controlplane" do |controlplane|
    controlplane.vm.box = "bento/ubuntu-24.04"
    controlplane.vm.network "private_network", ip: "192.168.3.10"
    controlplane.vm.hostname = "controlplane"
    controlplane.vm.synced_folder ".", "/home/vagrant/sync", type: "rsync"
    controlplane.vm.provision :shell, :path => "k3s_control.sh"
    controlplane.vm.network :forwarded_port, guest: 6443, host: 6443
    controlplane.vm.network :forwarded_port, guest: 8080, host: 8080
    controlplane.vm.network :forwarded_port, guest: 80, host: 80
    for i in 30000..32767
      controlplane.vm.network :forwarded_port, guest: i, host: i
    end
    controlplane.vm.provider "virtualbox" do |vb|
        vb.memory = 2048 # Memoria RAM asignada
        vb.cpus = 2     # Número de CPUs asignadas
      end
  end

  # --- Configuració dels WORKERS ---
  (1..NUM_WORKER_NODES).each do |i|
    config.vm.define "node0#{i}" do |node|
      node.vm.box = "bento/ubuntu-24.04"
      node.vm.hostname = "worker-node0#{i}"
      node.vm.network "private_network", ip: IP_NW + "#{10 + i}"
      node.vm.provider "virtualbox" do |vb|
          vb.memory = 1024 # 1GB per worker
          vb.cpus = 1
      end
    end
  end
end
