# Pràctica final

Carpeta que agrupa els manifests per una pràctica completa (WordPress + MariaDB) amb secrets, PVCs, base de dades i ingress.

Prerequisits
- Controlador d'Ingress actiu (traefik, nginx-ingress, etc.).
- `kubectl` configurat.
- StorageClass per proveir PVCs.

Ordre d'aplicació recomanat
1. `01-secret.yaml` — Crear `Secret` amb credencials.
2. `02-pvcs.yaml` — Crear `PersistentVolumeClaim` per MariaDB i WordPress.
3. `03-mariadb.yaml` — Desplegar MariaDB.
4. `04-wordpress.yaml` — Desplegar WordPress connectat a MariaDB.
5. `05-ingress.yaml` — Crear Ingress per exposar l'aplicació.

Com aplicar tot junt
```bash
kubectl apply -f exemples/practica-final/install.yaml
```

Neteja
```bash
kubectl delete -f exemples/practica-final/install.yaml
```

Notes
- Revisa que els secrets (usuaris/contrassenyes) i les connexions (host/port) entre WordPress i MariaDB estiguin correctes abans d'executar la pràctica.
- Si utilitzes hostnames en l'Ingress, afegeix les entrades corresponents al teu `/etc/hosts` o DNS de desenvolupament.
