# Instalación del entorno

En esta sección instalaremos las herramientas necesarias.

## Instalar Docker

```bash
sudo apt update
sudo apt install -y docker.io curl ca-certificates
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"
```

Cierra la sesión y vuelve a iniciarla. Después, comprueba Docker:

```bash
docker run --rm hello-world
```

## Instalar kubectl y Helm

```bash
sudo snap install kubectl --classic
sudo snap install helm --classic
```

Comprueba las versiones:

```bash
kubectl version --client
helm version
```

## Instalar k3d

```bash
curl -fsSLo /tmp/install-k3d.sh \
  https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh

sudo bash /tmp/install-k3d.sh
```

Comprueba la instalación:

```bash
k3d version
```
