FROM jenkins/jenkins:lts-jdk21

# Instalamos las herramientas como administrador del contenedor.
USER root

# Agregamos el repositorio oficial de Docker para Debian.
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    lsb-release \
    && install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg \
       -o /etc/apt/keyrings/docker.asc \
    && chmod a+r /etc/apt/keyrings/docker.asc \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
       > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends docker-ce-cli docker-compose-plugin \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Regresamos al usuario normal de Jenkins.
USER jenkins

# Instalamos los complementos necesarios para CI/CD.
RUN jenkins-plugin-cli --plugins \
    "git github workflow-aggregator docker-workflow credentials-binding"
