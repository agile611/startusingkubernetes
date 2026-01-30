echo "🚀 Instal·lant K3s Server (Master)..."
== 1. Update Your System ==
sudo apt update 
sudo apt upgrade -y

== 2. Install k3s ==
curl -sfL https://get.k3s.io | sh -

== 3. Give Non-root User Access to K3s Config ==
sudo chown $USER:$USER /etc/rancher/k3s/k3s.yaml
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

== 4. Verify Kubernetes Cluster ==
kubectl version
kubectl get nodes
kubectl get pods -A

== 5. Install Kustomize ==
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
sudo mv kustomize /usr/local/bin
  
echo "✅ Master llest!"