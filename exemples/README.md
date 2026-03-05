## **Exemples — Resum i ús ràpid**

Aquest directori conté manifests Kubernetes d'exemple agrupats en subcarpetes. Són fitxers pensats per aprendre i desplegar recursos bàsics (Pods, Deployments, Services, StatefulSets, PVCs, Ingress, Secrets, etc.) en un clúster local o d'estudi.

## **Prerequisits**
- **Clúster**: Un clúster Kubernetes (k3s, minikube, kind, etc.).
- **kubectl**: Configurat per apuntar al clúster.

## **Com aplicar els exemples**
Per aplicar una carpeta sencera:

```bash
kubectl apply -f https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/exemples-inicials/
kubectl apply -f https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/practica-final/install.yaml
```

Aplica fitxers individuals amb `kubectl apply -f <ruta/al/fitxer>`.

## **Estructura i descripció dels fitxers**

**exemples-inicials/**
- **Fitxer**: [exemples/exemples-inicials/app-configurada.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/exemples-inicials/app-configurada.yaml) — Exemple de desplegament amb configuració (ConfigMap/variables) aplicada.
- **Fitxer**: [exemples/exemples-inicials/deploy.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/exemples-inicials/deploy.yaml) — Manifest d'un `Deployment` bàsic amb rèpliques.
- **Fitxer**: [exemples/exemples-inicials/nginx-clusterip.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/exemples-inicials/nginx-clusterip.yaml) — `Service` de tipus `ClusterIP` per Nginx.
- **Fitxer**: [exemples/exemples-inicials/nginx-deployment.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/exemples-inicials/nginx-deployment.yaml) — `Deployment` de Nginx.
- **Fitxer**: [exemples/exemples-inicials/nginx-ingress.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/exemples-inicials/nginx-ingress.yaml) — Regles d'`Ingress` per exposar Nginx (requereix controlador d'ingress).
- **Fitxer**: [exemples/exemples-inicials/pod.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/exemples-inicials/pod.yaml) — Manifest d'un `Pod` senzill per provar execució bàsica.
- **Fitxer**: [exemples/exemples-inicials/redis-deployment.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/exemples-inicials/redis-deployment.yaml) — `Deployment` de Redis (stateless, per proves).
- **Fitxer**: [exemples/exemples-inicials/redis-pod.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/exemples-inicials/redis-pod.yaml) — `Pod` de Redis (ús demostratiu).
- **Fitxer**: [exemples/exemples-inicials/redis-pvc.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/exemples-inicials/redis-pvc.yaml) — `PersistentVolumeClaim` per a Redis.
- **Fitxer**: [exemples/exemples-inicials/redis-stateful-replica.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/exemples-inicials/redis-stateful-replica.yaml) — Exemple de rèplica/escala en `StatefulSet` per Redis.
- **Fitxer**: [exemples/exemples-inicials/redis-stateful.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/exemples-inicials/redis-stateful.yaml) — `StatefulSet` per desplegament de Redis amb PVCs.
- **Fitxer**: [exemples/exemples-inicials/service.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/exemples-inicials/service.yaml) — Exemple genèric de `Service` (ClusterIP/NodePort segons configuració).

**maria-db/**
- **Fitxer**: [exemples/maria-db/mariadb-deployment.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/maria-db/mariadb-deployment.yaml) — `Deployment` (o StatefulSet) per MariaDB.
- **Fitxer**: [exemples/maria-db/mariadb-pvc.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/maria-db/mariadb-pvc.yaml) — `PersistentVolumeClaim` per l'emmagatzematge de la base de dades.

**mariadb-replication/**
- **Fitxer**: [exemples/mariadb-replication/mariadb-replication.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/mariadb-replication/mariadb-replication.yaml) — Manifests per muntar un entorn de replicació de MariaDB (master/replica) amb secrets i configuració.

**practica-final/**
- **Fitxer**: [exemples/practica-final/01-secret.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/practica-final/01-secret.yaml) — `Secret` amb credencials per la pràctica final.
- **Fitxer**: [exemples/practica-final/02-pvcs.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/practica-final/02-pvcs.yaml) — PVCs requerits per MariaDB/WordPress.
- **Fitxer**: [exemples/practica-final/03-mariadb.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/practica-final/03-mariadb.yaml) — Desplegament de MariaDB per la pràctica final.
- **Fitxer**: [exemples/practica-final/04-wordpress.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/practica-final/04-wordpress.yaml) — `Deployment`/`Service` de WordPress configurat per connectar amb MariaDB.
- **Fitxer**: [exemples/practica-final/05-ingress.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/practica-final/05-ingress.yaml) — `Ingress` per exposar WordPress públicament (requereix controlador d'ingress i DNS/hosts si s'usa hostname).
- **Fitxer**: [exemples/practica-final/install.yaml](https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/practica-final/install.yaml) — Fitxer compost per aplicar l'ordre correcta (secrets → PVCs → DB → app → ingress).

## **Suggeriments i consideracions**
- **Ordre d'aplicació**: Normalment `Secret` → `PVCs` → `Deployments/StatefulSets` → `Services` → `Ingress`.
- **Ingress**: Comprova que tens un controlador d'ingress actiu (traefik, nginx-ingress, etc.).
- **Persistència**: Si treballes en un entorn local, revisa la provisió de `StorageClass` per assegurar que els PVCs es vinculen.
- **Neteja**: Per eliminar recursos després de provar:

```bash
kubectl delete -f https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/practica-final/install.yaml
kubectl delete -f https://git.agile611.com/Agile611/startusingkubernetes/src/branch/main/exemples/exemples-inicials/
```