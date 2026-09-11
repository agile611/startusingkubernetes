# Probar el clúster con Nginx

En esta práctica desplegaremos un pod con Nginx.

## Crear el pod

```bash
kubectl run nginx \
  --image=nginx:alpine \
  --port=80
```

Espera hasta que esté preparado:

```bash
kubectl wait \
  --for=condition=Ready \
  pod/nginx \
  --timeout=60s
```

## Comprobar el estado

```bash
kubectl get pod nginx -o wide
```

El pod debe aparecer como `Running`.

## Acceder a Nginx

En un terminal, ejecuta:

```bash
kubectl port-forward pod/nginx 8081:80
```

En otro terminal:

```bash
curl http://127.0.0.1:8081
```

Si recibes la página HTML de Nginx, el clúster funciona correctamente.

## Eliminar el pod

```bash
kubectl delete pod nginx
```
