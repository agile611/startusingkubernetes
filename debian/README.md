# Debian Vagrant — Descripció i ús

Aquest directori inclou una infraestructura Vagrant per muntar màquines Debian que suporten un petit clúster k3s d'estudi.

Contingut
- `Vagrantfile` — Fitxer principal per crear les màquines virtuals (controlador i agents).
- `.vagrant/` — Estat local de Vagrant (no versionar).
- `shared/` — Conté fitxers compartits entre host i les VM:
  - `k3s.yaml` — Fitxer kubeconfig generat pel clúster k3s dins les VM.
  - `token` — Token d'unió per a workers (k3s join token).

Prerequisits
- Instal·lar `Vagrant` i un provider (ex. VirtualBox). Si fas servir `libvirt` o un altre provider, configura'l prèviament.
- Xarxa i permisos per crear màquines virtuals.

Com arrencar el lab
1. Situa't a la carpeta `debian`:

```bash
cd debian
```

2. Inicia totes les màquines:

```bash
vagrant up
```

3. Opcional — iniciar només una màquina concreta (ex.: `server`):

```bash
vagrant up server
```

Accedir al kubeconfig
- Un cop el clúster està operatiu, trobaràs el `kubeconfig` generat a `shared/k3s.yaml`. Per usar-lo localment, pots fer:

```bash
export KUBECONFIG=$PWD/shared/k3s.yaml
kubectl get nodes
```

o copiar-lo al teu fitxer de kubeconfig:

```bash
cp shared/k3s.yaml ~/.kube/config
```

Ús del token
- El fitxer `shared/token` conté normalment el token per unir workers al clúster. No el comparteixis públicament.

Neteja i aturada
- Aturar màquines:

```bash
vagrant halt
```

- Destruir màquines i alliberar recursos:

```bash
vagrant destroy -f
```

Consells i consideracions
- No versionis la carpeta `.vagrant` ni fitxers sensibles (secrets, tokens) al repositori.
- Si utilitzes un provider diferent de VirtualBox (ex. libvirt), assegura't d'haver instal·lat i configurat el plugin de Vagrant corresponent.
- Si el `kubeconfig` mostra nodes en estat NotReady, comprova que les VM tenen connectivitat i que k3s està en execució (`vagrant ssh server` i `sudo systemctl status k3s`).

Vols que:
- faci un `git commit` d'aquest `README.md`?
- o que generi instruccions més detallades per personalitzar la topologia (nombre d'agents, recursos, etc.)?
