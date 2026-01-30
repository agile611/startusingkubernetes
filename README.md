[![Agile611](https://www.agile611.com/wp-content/uploads/2020/09/cropped-logo-header.png)](http://www.agile611.com/)
# Start Using Kubernetes (k3s) with Vagrant

Aquest repositori mostra com desplegar un clúster lleuger de Kubernetes (k3s) usant Vagrant per a desenvolupament i proves ràpides.

**Prerequisits**

- Vagrant instal·lat
- Un provider de VM (VirtualBox, Parallels, o un provider suportat)
- `curl` i `ssh` disponibles

Consulteu el `Vagrantfile` per a configuracions específiques del provider.

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

Les instruccions d'instal·lació i els scripts utilitzats per configurar k3s estan a [install_k3s.txt](install_k3s.txt). Revisa aquest fitxer per entendre com s'instal·la i s'inicia k3s dins de les VM.

**Personalitzar**

Modifica el [Vagrantfile](Vagrantfile) per canviar la mida de la VM, la xarxa o el nombre de nodes.

**Contribucions i errors**

Obre un issue o envia un PR amb millores o problemes trobats.

# Support

This tutorial is released into the public domain by [Agile611](http://www.agile611.com/) under Creative Commons Attribution-NonCommercial 4.0 International.

[![License: CC BY-NC 4.0](https://img.shields.io/badge/License-CC_BY--NC_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc/4.0/)


This README file was originally written by [Guillem Hernández Sola](https://www.linkedin.com/in/guillemhs/) and is likewise released into the public domain.

Please contact Agile611 for further details.

* [Agile611](http://www.agile611.com/)
* Laureà Miró 309
* 08950 Esplugues de Llobregat (Barcelona)

[![Agile611](https://www.agile611.com/wp-content/uploads/2020/09/cropped-logo-header.png)](http://www.agile611.com/)

