pipeline {
    agent any

    // Revisar GitHub automáticamente cada dos minutos.
    triggers {
        pollSCM('H/2 * * * *')
    }

    // Evitar ejecuciones simultáneas y mostrar la hora en los registros.
    options {
        timestamps()
        disableConcurrentBuilds()
    }

    // Variables necesarias para Docker Compose.
    // Las contraseñas se obtienen de las credenciales de Jenkins.
    environment {
        MYSQL_USER = 'ghostuser'
        MYSQL_DATABASE = 'ghost'
        GHOST_URL = 'http://localhost:8080'

        MYSQL_PASSWORD = credentials('ghostops-mysql-password')
        MYSQL_ROOT_PASSWORD = credentials('ghostops-mysql-root-password')

        // Cada ejecución utiliza un proyecto aislado.
        COMPOSE_PROJECT_NAME = "ghostops-ci-${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Descargando el codigo fuente desde GitHub.'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Validando Docker Compose.'
                sh 'docker compose -f compose.yaml config --quiet'

                echo 'Construyendo las imagenes de Ghost y MySQL.'
                sh 'docker compose -f compose.yaml build mysql ghost'
            }
        }

        stage('Test') {
            steps {
                echo 'Iniciando los servicios para las pruebas.'
                sh 'docker compose -f compose.yaml up -d --wait --wait-timeout 300'

                echo 'Verificando el estado de los servicios.'
                sh 'docker compose -f compose.yaml ps'

                echo 'Comprobando la comunicacion entre Ghost y MySQL.'
                sh '''
                    docker compose -f compose.yaml exec -T ghost node -e '
                    const net = require("net");

                    const connection = net.createConnection({
                        host: "mysql",
                        port: 3306
                    });

                    connection.setTimeout(10000);

                    connection.on("connect", () => {
                        console.log("OK: Ghost puede conectarse a MySQL mediante el servicio mysql.");
                        connection.end();
                    });

                    connection.on("error", (error) => {
                        console.error("ERROR de conexion:", error.message);
                        process.exit(1);
                    });

                    connection.on("timeout", () => {
                        console.error("ERROR: tiempo de espera agotado al conectar con MySQL.");
                        connection.destroy();
                        process.exit(1);
                    });
                    '
                '''
            }
        }
    }

    // Limpieza del entorno temporal de pruebas en Docker-in-Docker.
    // No afecta los contenedores ni los volumenes del Ghost principal.
    post {
        always {
            echo 'Limpiando el entorno aislado de pruebas.'
            sh 'docker compose -f compose.yaml down --volumes --remove-orphans || true'
        }
    }
}
