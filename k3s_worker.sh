  echo "⏳ Esperant que el Master generi el token..."
  while [ ! -f /vagrant/node-token ]; do sleep 2; done
  
  K3S_TOKEN=$(cat /vagrant/node-token)
  NODE_IP=$(ip addr show eth1 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

  echo "🚀 Instal·lant K3s Agent (Worker) connectant a #{IP_MASTER}..."
  curl -sfL https://get.k3s.io | K3S_URL=https://#{IP_MASTER}:6443 K3S_TOKEN=$K3S_TOKEN sh -s - --node-ip $NODE_IP --flannel-iface eth1
  
  echo "✅ Worker unit al clúster!"