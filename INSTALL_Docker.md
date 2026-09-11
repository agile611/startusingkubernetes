Para emular varios nodos de Kubernetes dentro de una sola máquina Ubuntu, la opción más práctica es **k3d**: ejecuta cada nodo de **k3s como un contenedor Docker**. Obtendrás servidores, agentes, red, balanceador y almacenamiento sin tener que levantar varias máquinas virtuales.

## 🧭 Arquitectura recomendada

Un laboratorio inicial equilibrado sería:

```text
Ubuntu 24.04
└── Docker
    └── Cluster k3d "curso"
        ├── server-0        Control plane
        ├── agent-0         Worker
        ├── agent-1         Worker
        ├── agent-2         Worker
        └── serverlb        Balanceador de entrada
```

### ¿Por qué k3d y no instalar varios servicios k3s directamente?

Cada nodo de Kubernetes necesita su propia identidad, red, almacenamiento y proceso `kubelet`. Intentar simularlos directamente sobre el mismo sistema operativo causa conflictos.

**k3d resuelve el aislamiento utilizando contenedores**, por lo que puedes:

- Crear y destruir clústeres en segundos.
- Simular la caída de nodos.
- Practicar `cordon`, `drain`, afinidades, taints y tolerations.
- Crear clústeres con uno o varios control planes.
- Reiniciar completamente un laboratorio entre clases.
- Ejecutar varios clústeres simultáneamente.

---

## 🛠️ Instalación en Ubuntu 24.04

### 1. Instalar Docker

```bash
sudo apt update
sudo apt install -y docker.io curl ca-certificates

sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"
```

Aplica el nuevo grupo sin reiniciar la máquina:

```bash
newgrp docker
```

Comprueba el funcionamiento:

```bash
docker run --rm hello-world
```

> En un entorno docente conviene usar versiones fijadas y probarlas antes del curso. Evita que una actualización sorpresa convierta la primera práctica en una clase avanzada de resolución de incidentes.

### 2. Instalar `kubectl` y Helm

```bash
sudo snap install kubectl --classic
sudo snap install helm --classic
```

Comprueba las herramientas:

```bash
kubectl version --client
helm version
```

### 3. Instalar k3d

Descarga primero el instalador para poder revisarlo antes de ejecutarlo:

```bash
curl -fsSLo /tmp/install-k3d.sh \
  https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh

less /tmp/install-k3d.sh
sudo bash /tmp/install-k3d.sh
```

Comprueba la instalación:

```bash
k3d version
```

---

## 🚀 Crear el clúster del curso

Este clúster tendrá **un control plane y tres workers**:

```bash
k3d cluster create curso \
  --servers 1 \
  --agents 3 \
  --api-port "127.0.0.1:6550" \
  -p "8080:80@loadbalancer" \
  -p "8443:443@loadbalancer" \
  --wait
```

Los puertos quedan así:

| **Servicio** | **Puerto Ubuntu** | **Destino** |
|---|---:|---|
| API de Kubernetes | `6550` | API server |
| HTTP | `8080` | Ingress del clúster |
| HTTPS | `8443` | Ingress del clúster |

k3d añade automáticamente el contexto al fichero de kubeconfig. Verifica el acceso:

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

Deberías ver algo parecido a:

```text
k3d-curso-server-0
k3d-curso-agent-0
k3d-curso-agent-1
k3d-curso-agent-2
```

También puedes ver los contenedores que representan los nodos:

```bash
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
```

---

## 🧪 Primera aplicación de prueba

### Crear el deployment y el servicio

```bash
kubectl create deployment web \
  --image=nginx:alpine \
  --replicas=3

kubectl expose deployment web \
  --port=80 \
  --target-port=80
```

Comprueba en qué nodos se ejecutan los pods:

```bash
kubectl get pods -o wide
```

### Publicar la aplicación mediante Ingress

k3s instala **Traefik** por defecto:

```bash
kubectl create ingress web \
  --class=traefik \
  --rule="curso.local/*=web:80"
```

Prueba el acceso sin modificar `/etc/hosts`:

```bash
curl -H 'Host: curso.local' http://127.0.0.1:8080
```

También puedes añadir una resolución local:

```bash
echo "127.0.0.1 curso.local" | sudo tee -a /etc/hosts
```

Y abrir:

```text
http://curso.local:8080
```

## 🏗️ Clúster para enseñar alta disponibilidad

Para una práctica específica de alta disponibilidad, crea otro clúster con tres servidores y dos workers:

```bash
k3d cluster create curso-ha \
  --servers 3 \
  --agents 2 \
  --api-port "127.0.0.1:6551" \
  -p "8081:80@loadbalancer" \
  -p "8444:443@loadbalancer" \
  --wait
```

Comprueba los nodos:

```bash
kubectl get nodes
```

Este escenario sirve para trabajar:

- Quórum del control plane.
- Fallo de un servidor.
- Diferencia entre servidores y agentes.
- Disponibilidad de la API.
- Distribución de cargas.

No es necesario mantener ambos clústeres activos constantemente:

```bash
k3d cluster stop curso-ha
k3d cluster start curso-ha
```

---

## 📦 Registro local de imágenes

Para enseñar construcción y despliegue de imágenes sin depender de Docker Hub, puedes crear un registro local:

```bash
k3d registry create curso-registry.localhost --port 5000
```

Al crear el clúster, añade:

```bash
--registry-use k3d-curso-registry.localhost:5000
```

Ejemplo completo:

```bash
k3d cluster create curso-registry \
  --servers 1 \
  --agents 3 \
  --api-port "127.0.0.1:6552" \
  -p "8082:80@loadbalancer" \
  --registry-use k3d-curso-registry.localhost:5000 \
  --wait
```

Flujo de publicación:

```bash
docker build -t localhost:5000/mi-aplicacion:v1 .
docker push localhost:5000/mi-aplicacion:v1
```

Dentro de Kubernetes, la imagen se referencia mediante el nombre visible desde la red de k3d:

```yaml
image: k3d-curso-registry.localhost:5000/mi-aplicacion:v1
```

---

## ⚠️ Limitaciones de la emulación

k3d es excelente para formación, pero los nodos **comparten el kernel del host**.

| **Tema** | **k3d** | **Máquinas virtuales** |
|---|---|---|
| Deployments, Services e Ingress | Excelente | Excelente |
| Scheduling, labels y taints | Excelente | Excelente |
| Caída lógica de nodos | Buena | Muy realista |
| Administración de `systemd` | No representativa | Realista |
| Configuración del kernel | Compartida | Independiente |
| Discos físicos y CSI | Limitada | Más realista |
| Instalación manual de k3s | Oculta por k3d | Completa |
| Consumo de recursos | Bajo | Alto |

Para enseñar **objetos Kubernetes, despliegue de aplicaciones, Helm, GitOps, observabilidad y troubleshooting**, k3d es una elección muy sólida.

Para módulos sobre **instalación de k3s, systemd, discos, redes del sistema operativo, kubelet o fallos reales de máquinas**, conviene complementar el curso con máquinas virtuales mediante **Multipass, Incus/LXD, libvirt o Proxmox**.

---

## 💡 Diseño recomendado del curso

Una progresión práctica podría ser:

1. **Cluster básico:** un servidor y tres agentes.
2. **Pods, Deployments y ReplicaSets.**
3. **Services, DNS e Ingress.**
4. **ConfigMaps, Secrets y almacenamiento.**
5. **Labels, afinidades, taints y tolerations.**
6. **Fallo, cordon, drain y recuperación de nodos.**
7. **Helm y registro local de imágenes.**
8. **Observabilidad con Prometheus y Grafana.**
9. **Alta disponibilidad con tres servidores.**
10. **Seguridad: RBAC, ServiceAccounts y NetworkPolicies.**

Como dimensionamiento orientativo, una máquina con **16 GB de RAM y 6–8 CPU** permite trabajar cómodamente con el clúster básico y varias aplicaciones docentes. Para observabilidad, service meshes o varios clústeres simultáneos, **32 GB de RAM** ofrece bastante más margen.