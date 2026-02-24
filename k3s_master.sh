echo "🚀 Instal·lant K3s Server (Master)..."

curl -sfL https://get.k3s.io | sh -s - server --tls-san 192.168.3.10

sudo chown vagrant:vagrant /etc/rancher/k3s/k3s.yaml
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

kubectl version
kubectl get nodes
kubectl get pods -A

curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
sudo mv kustomize /usr/local/bin
  
echo "✅ Master llest!"