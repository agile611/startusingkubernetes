# Aquest script s'ha de fer servir amb el node agent ja provisionat
# Anem a buscar el node token al Master
# sudo cat /var/lib/rancher/k3s/server/node-token
# Això dóna un string com algun_string_random::server:segon_string_random

# NOTA: Executar les següents comandes als nodes que voleu que siguin workers
# K3S_TOKEN=algun_string_random::server:segon_string_random
# Ex: K3S_TOKEN=K108085cf047fe22375b5c2ac96fec70afffd8a36fa66e8066f0218233e97c8ce6b::server:f3e19f5b6ed1c93e4c1bf0992bb5dc68
# Quan ja tinguem els nodes preparats i penjats
# Recordar que 192.168.3.10 és la IP del controlplane
echo "🚀 Instal·lant K3s Agent (Worker) connectant a 192.168.3.10..."

curl -sfL https://get.k3s.io | K3S_URL=https://192.168.3.10:6443 K3S_TOKEN=$K3S_TOKEN sh -

echo "✅ Worker unit al clúster!"


#Executar això al Controplane, per tenir-los amb role de worker
#kubectl label node worker-node01 node-role.kubernetes.io/worker=worker
#kubectl label node worker-node02 node-role.kubernetes.io/worker=worker
#Desactivar que al node controlplane es puguin executar pods
#kubectl taint nodes controlplane node-role.kubernetes.io/master=true:NoSchedule