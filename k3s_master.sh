  echo "🚀 Instal·lant K3s Server (Master)..."
  curl -sfL https://get.k3s.io | sh -s - --node-ip #{IP_MASTER} --flannel-iface eth1

  echo "🔑 Guardant el Token a la carpeta compartida..."
  # Copiem el token a /vagrant (que és la carpeta del teu PC) perquè els workers el vegin
  sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/node-token
  sudo chmod 644 /vagrant/node-token
  
  echo "✅ Master llest!"