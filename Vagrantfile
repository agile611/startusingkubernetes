# Configuració Global
NUM_WORKER_NODES = 2
IP_NW = "192.168.3."
IP_MASTER = "192.168.3.10" # Fixem la IP del Master per referenciar-la als workers

Vagrant.configure("2") do |config|
  
  config.vm.define "master" do |master|
    master.vm.box = "bento/ubuntu-24.04"
    master.vm.network "private_network", ip: "192.168.3.10"
    master.vm.hostname = "master"
    master.vm.synced_folder ".", "/home/vagrant/sync", type: "rsync"
    master.vm.provision :shell, :path => "k3s_master.sh"
    master.vm.network :forwarded_port, guest: 6443, host: 6443
    master.vm.network :forwarded_port, guest: 80, host: 8080
    master.vm.provider "virtualbox" do |vb|
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
      node.vm.provision "shell", path: "k3s_worker.sh"
      node.vm.provider "virtualbox" do |vb|
          vb.memory = 1024 # 1GB per worker
          vb.cpus = 1
      end
    end
  end
end
