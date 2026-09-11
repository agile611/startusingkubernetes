# Començar a utilitzar Kubernetes (k3s) amb Vagrant

Aquest repositori mostra com desplegar un clúster lleuger de Kubernetes (k3s) amb Vagrant i exemples pràctics per aprendre a executar aplicacions en un entorn local.

## Contingut del repositori

- `Vagrantfile`: configuració principal per crear un clúster k3s amb Vagrant.
- `libvirtVagrantfile`: configuració alternativa per a entorns amb `libvirt` en lloc de VirtualBox.
- `boxes/`: imatges de VM i arxius de suport per a Vagrant.
- `shared/`: fitxers compartits i configuració comuna entre màquines.
- `debian/`, `ubuntu/`: catàlegs amb exemples específics per a cada distribució i scripts d'instal·lació.
- `exemples/`: manifests Kubernetes i pràctiques d'exemple per desplegar aplicacions.

## Exemple principal

El directori `exemples/practica-final` conté una pràctica completa de WordPress + MariaDB amb:

- `01-secret.yaml`: credencials de base de dades.
- `02-pvcs.yaml`: volum persistent per a WordPress.
- `03-mariadb.yaml`: MariaDB replicada com a `StatefulSet` de 3 rèpliques.
- `04-wordpress.yaml`: desplegament de WordPress connectat al primari de MariaDB.
- `05-ingress.yaml`: Ingress per exposar l'aplicació a `elmeublog.local`.
- `install.yaml`: manifest combinat per aplicar tota la pràctica amb un sol comandament.

### Com executar la pràctica final

1. Arrenca el clúster amb Vagrant:

```bash
vagrant up
```

2. Comprova l'estat del node i la connectivitat:

```bash
vagrant ssh -c "sudo kubectl get nodes"
```

3. Aplica la pràctica completa:

```bash
kubectl apply -f exemples/practica-final/install.yaml
```

4. Accedeix a WordPress des del navegador amb:

```text
http://elmeublog.local
```

> Assegura't d'afegir `127.0.0.1 elmeublog.local` al teu `/etc/hosts` si estàs treballant en local.

## Altres exemples

- `exemples/exemples-inicials`: manifestos bàsics de Kubernetes per a desplegar pods, serveis, ingress, Redis i Nginx.
- `exemples/maria-db`: exemple de MariaDB amb Deployment i PVC.
- `exemples/mariadb-replication`: configuració de replicació de MariaDB amb `StatefulSet` i `ConfigMap`.

## Requisits

- Vagrant instal·lat
- Proveïdor de VM compatible (per exemple, VirtualBox o libvirt)
- `curl` i `ssh` disponibles
- `kubectl` accessible dins de la VM o des de l'amfitrió si tens accés a la configuració del cluster

## Personalització

- Modifica el `Vagrantfile` per canviar la mida de la VM, el nombre de nodes o la xarxa.
- Utilitza `libvirtVagrantfile` si prefereixes treballar amb `libvirt`.
- Revisa els fitxers dins dels directoris `debian/` i `ubuntu/` per veure scripts específics d'instal·lació.

## Neteja

Per aturar i eliminar les màquines virtuals:

```bash
vagrant halt
vagrant destroy -f
```

Per eliminar la pràctica final de Kubernetes:

```bash
kubectl delete -f exemples/practica-final/install.yaml
```

## Contribucions

Si trobes un error o vols millorar aquesta guia, obre un issue o envia un PR.

## Suport i llicència

Aquest repositori es publica per Agile611 amb llicència Creative Commons Attribution-NonCommercial 4.0 International.

[![License: CC BY-NC 4.0](https://img.shields.io/badge/License-CC_BY--NC_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc/4.0/)

Aquest README s'ha creat per facilitar l'ús del repositori i ajudar a desplegar Kubernetes local amb exemples pràctics.
