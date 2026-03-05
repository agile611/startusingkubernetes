# Exemples inicials

Aquest directori conté exemples bàsics per aprendre a desplegar recursos Kubernetes senzills: `Pod`, `Deployment`, `Service`, `Ingress` i exemples de Redis (stateless i stateful).

Prerequisits
- Un clúster Kubernetes (k3s, minikube, kind, etc.).
- `kubectl` configurat per apuntar al clúster.

Com aplicar
```bash
kubectl apply -f exemples/exemples-inicials/
```

Fitxers i propòsit
- `app-configurada.yaml` — Exemple de Deployment amb configuració (ConfigMap/variables d'entorn).
- `deploy.yaml` — Deployment genèric amb rèpliques.
- `nginx-clusterip.yaml` — Service `ClusterIP` per Nginx.
- `nginx-deployment.yaml` — Deployment de Nginx.
- `nginx-ingress.yaml` — Regles d'Ingress per Nginx (requereix controlador d'ingress).
- `pod.yaml` — Pod senzill per proves ràpides.
- `redis-deployment.yaml` — Deployment de Redis sense persistència (proves).
- `redis-pod.yaml` — Pod de Redis demostratiu.
- `redis-pvc.yaml` — PVC per a Redis (per usar amb StatefulSet).
- `redis-stateful-replica.yaml` — Exemple de rèplica amb StatefulSet.
- `redis-stateful.yaml` — StatefulSet de Redis amb persistència.
- `service.yaml` — Exemple genèric de Service.

Notes
- Aplica PVCs abans de StatefulSets si cal persistència.
- Comprova el controlador d'Ingress si utilitzes `nginx-ingress.yaml`.
