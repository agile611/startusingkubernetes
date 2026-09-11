[![Agile611](https://www.agile611.com/wp-content/uploads/2020/09/cropped-logo-header.png)](http://www.agile611.com/)

# Agile611 — Entorno de laboratorio Kubernetes — Un clúster Kubernetes multinodo con k3d

Vamos a instalar **Docker, kubectl, Helm y k3d** en Debian / Ubuntu. Después crearás un clúster Kubernetes con un nodo de control y tres nodos de trabajo. Finalmente, desplegarás Nginx para comprobar que todo funciona, básicamente para ver que el entorno funciona.

## 🎯 Objetivos del entorno controlado de laboratorio

Al finalizar serás capaz de:

- Instalar las herramientas necesarias para trabajar con Kubernetes.
- Crear un clúster local basado en k3s.
- Identificar los nodos que forman el clúster.
- Crear y consultar un pod.
- Acceder a una aplicación mediante `port-forward`.
- Detener, iniciar y eliminar el laboratorio.

### Requisitos previos

Necesitarás:

- Una máquina con **Debian o Ubuntu**. Este readme está basado en distros que usen apt-get.
- Un usuario con permisos para ejecutar `sudo`.
- Conexión a Internet.
- Al menos **8 GB de RAM**, aunque se recomiendan 16 GB.
- Aproximadamente **10 GB de espacio libre**.

> [IMPORTANTE] Ejecuta los comandos en el orden indicado. 

---

## 1. Preparar el entorno

Usaremos **k3d**, una herramienta que permite ejecutar nodos k3s como contenedores Docker.

Más info [https://k3s.io](https://k3s.io)

La arquitectura del laboratorio es:

```text
Ubuntu 24.04
└── Docker
    └── Clúster k3d "curso"
        ├── server-0        Nodo de control
        ├── agent-0         Nodo de trabajo
        ├── agent-1         Nodo de trabajo
        ├── agent-2         Nodo de trabajo
        └── serverlb        Balanceador de entrada
```

Cada nodo aparecerá como un nodo independiente para Kubernetes, aunque todos compartirán el mismo sistema operativo y el mismo kernel.

### 1.1. Actualizar la información de los paquetes

Abre un terminal y ejecuta:

```bash
sudo apt update
```

### 1.2. Instalar Docker

Instala Docker y algunas herramientas auxiliares:

```bash
sudo apt install -y docker.io curl ca-certificates
```

Activa Docker para que se inicie automáticamente:

```bash
sudo systemctl enable --now docker
```

Comprueba el estado del servicio:

```bash
sudo systemctl status docker --no-pager
```

Busca esta línea en la salida:

```text
Active: active (running)
```

### 1.3. Permitir el uso de Docker sin `sudo`

Añade tu usuario al grupo `docker`:

```bash
sudo usermod -aG docker "$USER"
```

Aplica temporalmente el cambio en el terminal actual:

```bash
newgrp docker
```

> También puedes cerrar la sesión en la máquina huésped y volver a iniciarla. Esto aplica correctamente la nueva pertenencia al grupo.

Comprueba que puedes ejecutar Docker sin `sudo`:

```bash
docker run --rm hello-world
```

La ejecución será correcta si aparece un mensaje similar a:

```text
Hello from Docker!
```

Si recibes un error de permisos, cierra la sesión del usuario, vuelve a entrar y repite el comando.

### 1.4. Instalar kubectl

`kubectl` es la herramienta de línea de comandos utilizada para administrar Kubernetes.

Instálala con:

```bash
sudo snap install kubectl --classic
```

Comprueba la instalación:

```bash
kubectl version --client
```

Deberías obtener información sobre la versión instalada.

### 1.5. Instalar Helm

Helm es un gestor de paquetes para Kubernetes. No es necesario para la primera prueba, pero se utilizará en prácticas posteriores.

```bash
sudo snap install helm --classic
```

Comprueba la instalación:

```bash
helm version
```

### 1.6. Instalar k3d

Descarga el script oficial de instalación:

```bash
curl -fsSLo /tmp/install-k3d.sh \
  https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh
```

Puedes revisar el script antes de ejecutarlo:

```bash
less /tmp/install-k3d.sh
```

Pulsa `q` para salir del visor.

Ejecuta el instalador:

```bash
sudo bash /tmp/install-k3d.sh
```

Comprueba que k3d está disponible:

```bash
k3d version
```

La salida debe mostrar las versiones de k3d y k3s.

### Punto de control

Antes de continuar, comprueba las cuatro herramientas:

```bash
docker --version
kubectl version --client
helm version
k3d version
```

Si los cuatro comandos muestran información de versión, el entorno está preparado.

---

## 2. Crear el clúster Kubernetes

Ahora vas a crear un clúster llamado `curso` con:

- Un nodo de control.
- Tres nodos de trabajo.
- Un balanceador de entrada.
- Puertos para HTTP y HTTPS.

### 2.1. Crear el clúster

Ejecuta:

```bash
k3d cluster create curso \
  --servers 1 \
  --agents 3 \
  --api-port "127.0.0.1:6550" \
  -p "8080:80@loadbalancer" \
  -p "8443:443@loadbalancer" \
  --wait
```

El proceso puede tardar uno o dos minutos, especialmente durante la primera ejecución, porque Docker deberá descargar las imágenes necesarias.

Los puertos utilizados serán:

| **Servicio** | **Puerto local** | **Función** |
|---|---:|---|
| API de Kubernetes | `6550` | Administración del clúster |
| HTTP | `8080` | Acceso HTTP al balanceador |
| HTTPS | `8443` | Acceso HTTPS al balanceador |

> Si alguno de estos puertos ya está ocupado, la creación del clúster fallará. Puedes comprobarlo con `sudo ss -lntp`.

### 2.2. Comprobar el contexto activo

k3d configura automáticamente `kubectl` para conectarse al nuevo clúster.

Ejecuta:

```bash
kubectl config current-context
```

El resultado esperado es:

```text
k3d-curso
```

Si tienes varios clústeres configurados y no aparece `k3d-curso`, selecciónalo manualmente:

```bash
kubectl config use-context k3d-curso
```

### 2.3. Consultar la información del clúster

Ejecuta:

```bash
kubectl cluster-info
```

Este comando debe mostrar las direcciones del plano de control y de los servicios principales.

### 2.4. Consultar los nodos

Ejecuta:

```bash
kubectl get nodes
```

Deberías ver cuatro nodos:

```text
NAME                     STATUS   ROLES
k3d-curso-server-0       Ready    control-plane,master
k3d-curso-agent-0        Ready    <none>
k3d-curso-agent-1        Ready    <none>
k3d-curso-agent-2        Ready    <none>
```

Muestra información adicional:

```bash
kubectl get nodes -o wide
```

Comprueba lo siguiente:

- Hay **cuatro nodos**.
- Todos aparecen en estado `Ready`.
- Uno es el nodo de control.
- Tres son nodos de trabajo.

> Los roles exactos pueden variar ligeramente según la versión de k3s. Lo importante es que todos los nodos estén en estado `Ready`.

### 2.5. Observar los contenedores de Docker

Los nodos del clúster son contenedores Docker. Puedes verlos con:

```bash
docker ps --format \
  'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
```

Deberían aparecer contenedores con nombres similares a:

```text
k3d-curso-server-0
k3d-curso-agent-0
k3d-curso-agent-1
k3d-curso-agent-2
k3d-curso-serverlb
```

### Punto de control

El clúster se ha creado correctamente si:

- `kubectl config current-context` muestra `k3d-curso`.
- `kubectl get nodes` muestra cuatro nodos.
- Todos los nodos aparecen como `Ready`.
- `docker ps` muestra los contenedores de k3d.

---

## 3. Desplegar una aplicación de prueba

Para comprobar el funcionamiento del clúster, desplegarás un pod con el servidor web **Nginx**.

Esta prueba verificará que:

- La API de Kubernetes responde.
- El scheduler puede asignar el pod a un nodo.
- El nodo puede descargar la imagen.
- El contenedor puede arrancar.
- La aplicación es accesible desde tu máquina.

### 3.1. Crear el pod

Ejecuta:

```bash
kubectl run nginx \
  --image=nginx:alpine \
  --port=80
```

La respuesta esperada es:

```text
pod/nginx created
```

### 3.2. Esperar hasta que el pod esté preparado

Ejecuta:

```bash
kubectl wait \
  --for=condition=Ready \
  pod/nginx \
  --timeout=60s
```

Si todo funciona correctamente, aparecerá:

```text
pod/nginx condition met
```

### 3.3. Consultar el estado del pod

Ejecuta:

```bash
kubectl get pod nginx
```

El estado esperado es:

```text
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          ...
```

El valor `1/1` indica que el pod tiene un contenedor y que ese contenedor está preparado.

Consulta ahora información ampliada:

```bash
kubectl get pod nginx -o wide
```

Observa la columna `NODE`. Esta columna indica el nodo en el que se está ejecutando el pod.

### 3.4. Revisar los detalles del pod

Ejecuta:

```bash
kubectl describe pod nginx
```

Busca los siguientes apartados:

- `Node`: nodo asignado.
- `Status`: estado actual.
- `IP`: dirección IP interna.
- `Containers`: información del contenedor.
- `Events`: acontecimientos registrados durante su creación.

La sección `Events` resulta especialmente útil para diagnosticar problemas.

### 3.5. Acceder a Nginx

Usa `port-forward` para conectar un puerto de Ubuntu con el puerto del pod.

Ejecuta en el terminal actual:

```bash
kubectl port-forward pod/nginx 8081:80
```

Deberías ver:

```text
Forwarding from 127.0.0.1:8081 -> 80
Forwarding from [::1]:8081 -> 80
```

> Se utiliza el puerto local `8081` porque el puerto `8080` ya está reservado por el balanceador del clúster.

Mantén este comando en ejecución y abre **otro terminal**.

En el segundo terminal, ejecuta:

```bash
curl http://127.0.0.1:8081
```

Deberías recibir el código HTML de la página de bienvenida de Nginx:

```html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
...
```

También puedes abrir esta dirección en un navegador:

```text
http://127.0.0.1:8081
```

Para detener el `port-forward`, vuelve al primer terminal y pulsa:

```text
Ctrl+C
```

### 3.6. Consultar los logs

Aunque Nginx normalmente no muestra muchos mensajes al arrancar, puedes consultar sus registros:

```bash
kubectl logs nginx
```

Después de acceder con `curl`, deberías ver una petición HTTP similar a:

```text
GET / HTTP/1.1
```

### Resultado esperado

La prueba se considera correcta si:

1. Los nodos aparecen como `Ready`.
2. El pod aparece como `Running`.
3. `kubectl port-forward` no produce errores.
4. `curl` devuelve la página HTML de Nginx.
5. `kubectl logs nginx` muestra la petición HTTP.

---

## 4. Limpiar y administrar el laboratorio

Cuando termines la prueba, puedes eliminar únicamente el pod o gestionar el clúster completo.

### 4.1. Eliminar el pod

Ejecuta:

```bash
kubectl delete pod nginx
```

Comprueba que ya no existe:

```bash
kubectl get pods
```

La salida esperada es:

```text
No resources found in default namespace.
```

### 4.2. Detener el clúster

Puedes detener el clúster sin eliminarlo:

```bash
k3d cluster stop curso
```

Los contenedores se detendrán, pero conservarás la configuración y los recursos del clúster.

Comprueba el estado:

```bash
k3d cluster list
```

### 4.3. Volver a iniciar el clúster

Para continuar trabajando:

```bash
k3d cluster start curso
```

Espera unos segundos y comprueba los nodos:

```bash
kubectl get nodes
```

### 4.4. Eliminar completamente el clúster

Cuando ya no necesites el laboratorio, puedes eliminarlo:

```bash
k3d cluster delete curso
```

Comprueba que ha desaparecido:

```bash
k3d cluster list
```

> Este comando elimina el clúster y sus recursos internos. No desinstala Docker, kubectl, Helm ni k3d.

---

## ✅ Resumen de la práctica

Durante esta práctica has utilizado los siguientes comandos principales:

| **Acción** | **Comando** |
|---|---|
| Crear el clúster | `k3d cluster create curso ...` |
| Ver los nodos | `kubectl get nodes` |
| Crear un pod | `kubectl run nginx --image=nginx:alpine` |
| Ver el estado del pod | `kubectl get pod nginx -o wide` |
| Acceder al pod | `kubectl port-forward pod/nginx 8081:80` |
| Consultar los logs | `kubectl logs nginx` |
| Eliminar el pod | `kubectl delete pod nginx` |
| Detener el clúster | `k3d cluster stop curso` |
| Iniciar el clúster | `k3d cluster start curso` |
| Eliminar el clúster | `k3d cluster delete curso` |

El laboratorio estará funcionando correctamente cuando los cuatro nodos aparezcan como **`Ready`**, el pod Nginx alcance el estado **`Running`** y puedas obtener su página mediante `curl`.

---

## Contribuciones

Si encuentras un error o quieres mejorar esta guía, abre un issue o envía un PR.

## Soporte y licencia

Publicado por [Agile611](http://www.agile611.com/) bajo licencia **Creative Commons Attribution-NonCommercial 4.0 International**.

[![License: CC BY-NC 4.0](https://img.shields.io/badge/License-CC_BY--NC_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc/4.0/)

README escrito por [Guillem Hernández Sola](https://www.linkedin.com/in/guillemhs/).

**Contacto:**
- 🌐 [agile611.com](http://www.agile611.com/)
- 📍 Carrer Laureà Miró 309, 08950 Esplugues de Llobregat (Barcelona)