# Començar a utilitzar Kubernetes (k3s) amb Vagrant

Aquest repositori mostra com desplegar un clúster lleuger de Kubernetes (k3s) usant Vagrant per a desenvolupament i proves ràpides.

**Prerequisits**

- Vagrant instal·lat
- Un proveïdor de VM (VirtualBox, Parallels, o un proveïdor suportat)
- `curl` i `ssh` disponibles

Consulteu el `Vagrantfile` per a configuracions específiques del proveïdor.

**Ràpid Inici**

1. Arrancar les màquines amb Vagrant:

```bash
vagrant up
```

2. Comprovar l'estat del clúster (ssh a una màquina i utilitzar `kubectl` integrat):

```bash
vagrant ssh -c "sudo kubectl get nodes"
```

3. Parar i eliminar les màquines:

```bash
vagrant halt
vagrant destroy -f
```

**Detalls d'instal·lació**

Les instruccions d'instal·lació i els scripts utilitzats per configurar k3s estan en aquest repo. Revisa aquest fitxer per entendre com s'instal·la i s'inicia k3s dins de les VM.

**Personalitzar**

Modifica el [Vagrantfile](Vagrantfile) per canviar la mida de la VM, la xarxa o el nombre de nodes.

**Contribucions i errors**

Obre un issue o envia un PR amb millores o problemes trobats.

# Suport

Aquest tutorial és publicat al domini públic per [Agile611](http://www.agile611.com/) sota la llicència Creative Commons Attribution-NonCommercial 4.0 International.

[![License: CC BY-NC 4.0](https://img.shields.io/badge/License-CC_BY--NC_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc/4.0/)

Aquest fitxer README va ser escrit originalment per [Guillem Hernández Sola](https://www.linkedin.com/in/guillemhs/) i també és publicat al domini públic.

Si us plau, contacta amb Agile611 per a més detalls.

* [Agile611](http://www.agile611.com/)
* Laureà Miró 309
* 08950 Esplugues de Llobregat (Barcelona)

[![Agile611](https://www.agile611.com/wp-content/uploads/2020/09/cropped-logo-header.png)](http://www.agile611.com/)