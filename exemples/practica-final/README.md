# Pràctica final

Carpeta que agrupa els manifests per una pràctica completa de WordPress + MariaDB amb replicació.

Aquesta pràctica desplega:
- MariaDB en un `StatefulSet` de 3 rèpliques amb replicació.
- WordPress connectat al node primari de MariaDB.
- Un Ingress per exposar l'aplicació a `elmeublog.local`.

Prerequisits
- Controlador d'Ingress actiu (traefik, nginx-ingress, etc.).
- `kubectl` configurat al cluster.
- StorageClass disponible per proveir els PVCs.
- Opcional: afegir `127.0.0.1 elmeublog.local` al teu `/etc/hosts` si fas servir un cluster local.

Ordre d'aplicació recomanat
1. `kubectl apply -f exemples/practica-final/01-secret.yaml`
2. `kubectl apply -f exemples/practica-final/02-pvcs.yaml` # crea el PVC per WordPress
3. `kubectl apply -f exemples/practica-final/03-mariadb.yaml`
4. `kubectl apply -f exemples/practica-final/04-wordpress.yaml`
5. `kubectl apply -f exemples/practica-final/05-ingress.yaml`

Aquest ordre garanteix que el Secret i el volum de WordPress existeixin abans de desplegar MariaDB i WordPress. MariaDB crea els seus volums amb `volumeClaimTemplates` dins del `StatefulSet`.

Com aplicar tot junt
```bash
kubectl apply -f exemples/practica-final/install.yaml
```

Accés
- Navega a `http://elmeublog.local` després de desplegar l'Ingress.

Neteja
```bash
kubectl delete -f exemples/practica-final/install.yaml
```

Notes
- WordPress es connecta directament al pod primari de MariaDB: `mariadb-sts-0.servei-mariadb.default.svc.cluster.local`.
- La MariaDB es desplega com a `StatefulSet` de 3 rèpliques amb configuració de primari/secundari.
- Si l'Ingress no funciona, revisa que el controlador estigui actiu i que el host `elmeublog.local` estigui resoluble.
