# GhostOps CI/CD

## Proyecto académico

Implementación de una plataforma de publicación web mediante herramientas de integración y entrega continua (CI/CD).

## Descripción

GhostOps CI/CD es un proyecto académico que utiliza Ghost como plataforma de publicación web y MySQL como sistema gestor de bases de datos.

La infraestructura se implementa mediante contenedores Docker independientes, administrados con Docker Compose y conectados a través de una red privada.

El proyecto evolucionará hacia un pipeline de integración y entrega continua que permitirá automatizar validaciones, pruebas y despliegues.

## Tecnologías

- Ghost CMS 6
- MySQL 8.0
- Docker
- Docker Compose
- Git
- GitHub
- Jenkins (etapa posterior)
- Travis CI (etapa posterior)
- Codeship (etapa posterior)
- GitHub Actions (automatizaciones complementarias)

## Arquitectura inicial

La solución está compuesta por dos servicios:

1. Ghost: aplicación web de publicación.
2. MySQL: almacenamiento de datos relacional.

Ambos servicios se ejecutan en contenedores independientes y se comunican mediante la red Docker ghostops-network.

## Requisitos

- Windows 11.
- Docker Desktop.
- Docker Compose V2.
- Git.
- Visual Studio Code.

## Instalación

Clonar el repositorio:

```bash
git clone URL_DEL_REPOSITORIO
cd GhostOpsCICD