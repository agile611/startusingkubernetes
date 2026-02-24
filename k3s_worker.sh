#Anem a buscar el node token al Master
#sudo cat /var/lib/rancher/k3s/server/node-token
#K3S_TOKEN=algun_string_random::server:segon_string_random

echo "🚀 Instal·lant K3s Agent (Worker) connectant a #{IP_MASTER}..."
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.3.10:6443 K3S_TOKEN=$K3S_TOKEN sh -

echo "✅ Worker unit al clúster!"