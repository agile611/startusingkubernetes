server_ip = "192.168.56.10"

agents = { "agent1" => "192.168.56.11",
           "agent2" => "192.168.56.12",
           "agent3" => "192.168.56.13" }

server_script = <<-SHELL
    apt-get update
    apt-get install -y curl sudo nano
    export INSTALL_K3S_EXEC="--bind-address=#{server_ip} --node-ip=#{server_ip} --node-external-ip=#{server_ip} --flannel-iface=eth1"
    curl -sfL https://get.k3s.io | sh -
    echo "Waiting for k3s to become ready"
    export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
    for i in $(seq 1 12); do
      if kubectl get nodes >/dev/null 2>&1; then
        break
      fi
      echo "k3s not ready yet, waiting... ($i)"
      sleep 15
    done
    sudo chown vagrant:vagrant /etc/rancher/k3s/k3s.yaml
    cp /var/lib/rancher/k3s/server/token /vagrant_shared
    cp /etc/rancher/k3s/k3s.yaml /vagrant_shared
    sleep 15
    kubectl taint nodes server node-role.kubernetes.io/master=true:NoSchedule || true
SHELL

agent_script = <<-SHELL
    apt-get update
    apt-get install -y curl
    export K3S_TOKEN_FILE=/vagrant_shared/token
    export K3S_URL=https://#{server_ip}:6443
    export INSTALL_K3S_EXEC="--flannel-iface=eth1"
    curl -sfL https://get.k3s.io | sh -
SHELL

Vagrant.configure("2") do |config|
  config.vm.box = "bento/debian-13"

  config.vm.define "server", primary: true do |server|
    server.vm.network "private_network", ip: server_ip
    server.vm.synced_folder "./shared", "/vagrant_shared"
    server.vm.hostname = "server"
    server.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = "2"
    end
    server.vm.provision "shell", inline: server_script
  end

  agents.each do |agent_name, agent_ip|
    config.vm.define agent_name do |agent|
      agent.vm.network "private_network", ip: agent_ip
      agent.vm.synced_folder "./shared", "/vagrant_shared"
      agent.vm.hostname = agent_name
      agent.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.cpus = "1"
      end
      agent.vm.provision "shell", inline: agent_script
    end
  end
end