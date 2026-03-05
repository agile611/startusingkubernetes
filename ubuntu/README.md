# Ubuntu Vagrant + k3s — Guia ràpida

Aquest directori inclou fitxers i scripts per muntar un petit entorn de desenvolupament basat en Ubuntu amb k3s utilitzant Vagrant.

Contingut principal
- `Vagrantfile` — Fitxer de Vagrant per crear les VM (controlador i agents).
- `libvirtVagrantfile` — Variante per a provider `libvirt` (si s'utilitza).
- `k3s_control.sh` — Script d'inicialització/gestió per al node controlador k3s.
- `k3s_worker.sh` — Script per unir nodes worker al clúster.
- `.vagrant/` — Estat local de Vagrant (no versionar).
- `shared/` — Fitxer compartit amb el host:
  - `k3s.yaml` — kubeconfig generat pel clúster dins les VM.
  - `token` — Token per unir workers (mantenir privat).

Prerequisits
- `Vagrant` instal·lat i un provider configurat (VirtualBox, libvirt, etc.).
- Accés suficient per crear màquines virtuals i configurar xarxes.

Arrencar l'entorn
1. Obre un terminal i entra a la carpeta `ubuntu`:

```bash
cd ubuntu
```

2. Inicia les màquines (totes):

```bash
vagrant up
```

3. Si utilitzes `libvirt` i tens el `libvirtVagrantfile`, inicia amb el provider corresponent:

```bash
vagrant up --provider=libvirt
```

Ús dels scripts
- Per preparar o controlar k3s al node controlador, pots executar `k3s_control.sh` (pot requerir `vagrant ssh server` o execució dins la VM):

```bash
vagrant ssh server -- "sudo /vagrant/k3s_control.sh"
```

- Per unir un worker manualment utilitzant el token compartit:

```bash
vagrant ssh agent1 -- "sudo /vagrant/k3s_worker.sh $(cat /vagrant/token)"
```

Accedir al kubeconfig
- El `kubeconfig` generat pel clúster es troba a `shared/k3s.yaml`. Per utilitzar-lo localment:

```bash
export KUBECONFIG=$PWD/shared/k3s.yaml
kubectl get nodes
```

o copiar-lo al teu `~/.kube/config`:

```bash
cp shared/k3s.yaml ~/.kube/config
```

Token i seguretat
- `shared/token` conté el token per unir nodes; tracta'l com a secret i no el versionis.

Aturar i netejar
- Aturar les màquines:

```bash
vagrant halt
```

- Destruir-les (alliberar recursos):

```bash
vagrant destroy -f
```

Consells i resolució d'errors comuns
- Si alguna màquina no arrenca, comprova el provider (VirtualBox/libvirt) i l'espai disponible.
- Si els nodes surten `NotReady`, fes `vagrant ssh server` i comprova l'estat de k3s:

```bash
sudo systemctl status k3s
sudo journalctl -u k3s -n 200
```

- Revisa permisos i SELinux/ AppArmor si tens problemes de muntatge de carpetes compartides.

Vols que:
- faci un `git commit` d'aquest `README.md`?
- o que modifiqui els scripts per fer-los més automàtics (per exemple, script que arrenca i configuri tot automàticament)?
