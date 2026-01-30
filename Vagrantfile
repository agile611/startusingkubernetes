# Configuració Global
NUM_WORKER_NODES = 2
IP_NW = "192.0.3."
IP_MASTER = "192.0.3.10" # Fixem la IP del Master per referenciar-la als workers

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"
  config.vm.box_check_update = false

  # --- Configuració del MASTER ---
  config.vm.define "master" do |master|
    master.vm.hostname = "master-node"
    master.vm.network "private_network", ip: IP_MASTER
    
    master.vm.provider "virtualbox" do |vb|
        vb.memory = 2048 # Amb 2GB n'hi ha prou per K3s bàsic
        vb.cpus = 2
    end

    # Ports importants (API i Ingress HTTP/HTTPS)
    master.vm.network :forwarded_port, guest: 6443, host: 6443, id: "k8s-api"
    master.vm.network :forwarded_port, guest: 80, host: 8080, id: "ingress-http" # Accedeix a les apps via localhost:8080

    master.vm.provision "shell", path: "k3s_master.sh"
  end

  # --- Configuració dels WORKERS ---
  (1..NUM_WORKER_NODES).each do |i|
    config.vm.define "node0#{i}" do |node|
      node.vm.hostname = "worker-node0#{i}"
      node.vm.network "private_network", ip: IP_NW + "#{10 + i}"
      
      node.vm.provider "virtualbox" do |vb|
          vb.memory = 1024 # 1GB per worker
          vb.cpus = 1
      end

      node.vm.provision "shell", path: "k3s_worker.sh"
    end
  end
end
