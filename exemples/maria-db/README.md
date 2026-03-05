# MariaDB

Conté manifests per desplegar una instància de MariaDB i el seu emmagatzematge persistent.

Prerequisits
- StorageClass funcional per enlazar PVCs.
- `kubectl` apuntant al clúster.

Com aplicar
```bash
kubectl apply -f exemples/maria-db/mariadb-pvc.yaml
kubectl apply -f exemples/maria-db/mariadb-deployment.yaml
```

Fitxers
- `mariadb-pvc.yaml` — `PersistentVolumeClaim` per a les dades de MariaDB.
- `mariadb-deployment.yaml` — Deployment o StatefulSet (segons el manifest) per MariaDB.

Notes
- Revisa els recursos del PVC (size, storageClassName) per adaptar-los al teu entorn.
- Si necessites replicació, mira la carpeta `mariadb-replication`.
