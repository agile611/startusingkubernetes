# Configuració Global
NUM_WORKER_NODES = 2
IP_NW = "10.0.3."  # Use the 10.0.3.x subnet for eth1
IP_controlplane = "10.0.3.15"  # Control plane IP for eth1

Vagrant.configure("2") do |config|
  
  config.vm.define "controlplane" do |controlplane|
    controlplane.vm.box = "bento/ubuntu-24.04"
    controlplane.vm.network "private_network", ip: IP_controlplane  # eth1 IP
    controlplane.vm.hostname = "controlplane"
    controlplane.vm.synced_folder ".", "/home/vagrant/sync", type: "rsync"
    controlplane.vm.provision :shell, :path => "k3s_control.sh"
    
    # Forward necessary ports
    controlplane.vm.network :forwarded_port, guest: 80, host: 80
    controlplane.vm.network :forwarded_port, guest: 8080, host: 8080
    controlplane.vm.network :forwarded_port, guest: 6443, host: 6443
    controlplane.vm.network :forwarded_port, guest: 8472, host: 8472   # Flannel
    controlplane.vm.network :forwarded_port, guest: 10250, host: 10250 # Kubelet
    controlplane.vm.network :forwarded_port, guest: 10256, host: 10256 # Kube Proxy

    # Forward NodePort range
    for i in 30000..32767
      controlplane.vm.network :forwarded_port, guest: i, host: i
    end

    controlplane.vm.provider "virtualbox" do |vb|
        vb.memory = 2048 # Memoria RAM asignada
        vb.cpus = 2     # Número de CPUs asignades
      end
  end

  # --- Configuració dels WORKERS ---
  (1..NUM_WORKER_NODES).each do |i|
    config.vm.define "node0#{i}" do |node|
      node.vm.box = "bento/ubuntu-24.04"
      node.vm.network "private_network", ip: IP_NW + "#{15 + i}"  # eth1 IPs (10.0.3.16 and 10.0.3.17)
      node.vm.hostname = "worker-node0#{i}"
      node.vm.provider "virtualbox" do |vb|
          vb.memory = 1024 # 1GB per worker
          vb.cpus = 1
      end
    end
  end
end