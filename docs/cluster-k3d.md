# Crear el clúster con k3d

Vamos a crear un clúster con un nodo de control y tres nodos de trabajo.

## Crear el clúster

```bash
k3d cluster create curso \
  --servers 1 \
  --agents 3 \
  --api-port "127.0.0.1:6550" \
  -p "8080:80@loadbalancer" \
  -p "8443:443@loadbalancer" \
  --wait
```

## Comprobar el contexto

```bash
kubectl config current-context
```

La salida esperada es:

```text
k3d-curso
```

## Comprobar los nodos

```bash
kubectl get nodes -o wide
```

Todos los nodos deben aparecer como `Ready`.

!!! warning "Antes de continuar"
    No continúes con las prácticas si alguno de los nodos permanece
    en estado `NotReady`.
