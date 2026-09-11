# Curso de Kubernetes con k3s

Bienvenido a la documentación del curso de **Kubernetes con k3s**.

Durante el curso aprenderás a crear y administrar un clúster Kubernetes
local utilizando **k3d**.

## Objetivos

Al finalizar el curso serás capaz de:

- Comprender la arquitectura de Kubernetes.
- Crear un clúster local con varios nodos.
- Desplegar aplicaciones.
- Configurar Services e Ingress.
- Administrar almacenamiento y configuración.
- Trabajar con Helm.
- Diagnosticar problemas básicos.

## Laboratorio

La arquitectura utilizada será:

```text
Ubuntu 24.04
└── Docker
    └── Clúster k3d
        ├── server-0
        ├── agent-0
        ├── agent-1
        └── agent-2
```

!!! info "Entorno de prácticas"
    Los nodos de Kubernetes se ejecutan como contenedores Docker
    dentro de una única máquina Ubuntu.
