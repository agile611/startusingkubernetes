# MariaDB Replication

Manifests per muntar un entorn de replicació de MariaDB (master/replica). Inclou configuracions i possiblement `Secrets` per credencials.

Prerequisits
- Control de permisos i credencials (secrets).
- PVCs provisionats per emmagatzemar dades per a cada instància.

Com aplicar (ordre suggerida)
```bash
kubectl apply -f exemples/mariadb-replication/  # o aplicar fitxers per ordre si cal
```

Fitxers
- `mariadb-replication.yaml` — Conté la configuració principal per la replicació (roles, inicialització, serveis, etc.).

Consideracions
- La replicació pot requerir inicialització manual (dump/import), usuaris específics i configuracions del servidor MariaDB.
- Revisa l'estratègia de backups i restauració abans d'usar en producció.
