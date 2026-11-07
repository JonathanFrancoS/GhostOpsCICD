# Entrega 1 - Infraestructura Docker y CI

## Objetivo

Desplegar una aplicación web y una base de datos como servicios separados, demostrar su comunicación con persistencia y validar la construcción y ejecución con Docker Compose y GitHub Actions.

## Arquitectura

Ghost 6.0.0 Alpine se construye desde el `Dockerfile` propio del proyecto. MySQL 8.0.46 es el segundo servicio. Ambos comparten la red bridge `ghostops-network`; Ghost se conecta al host `mysql` por el puerto interno 3306. Compose publica Ghost en el puerto 8080 del host, espera el healthcheck de MySQL y conserva los datos con los volúmenes `mysql_data` y `ghost_content`.

## Configuración y seguridad

- Las contraseñas se proporcionan desde `.env`, que está ignorado por Git y `.dockerignore`.
- `.env.example` documenta las variables requeridas sin contener credenciales reales.
- MySQL solo es accesible en la red privada de Compose; no se publica su puerto en el host.
- Las imágenes usan etiquetas de versión fijada, no `latest`.

## Prueba de comunicación

1. Iniciar con `docker compose up --detach --wait`.
2. Completar la configuración de Ghost desde `http://localhost:8080/ghost`.
3. Crear y publicar desde Ghost una entrada con slug `prueba-comunicacion`.
4. Leer la publicación desde `http://localhost:8080/prueba-comunicacion/`.
5. Ejecutar `.\scripts\verify-communication.ps1 -Slug prueba-comunicacion` y capturar la fila consultada en MySQL y la respuesta HTTP.

La entrada creada y servida por Ghost, junto con su registro en MySQL, prueba el flujo de escritura y lectura entre servicios.

## Evidencias para el PDF

Guardar las capturas legibles en `screenshot/` y reunirlas en el PDF final. El indice contiene los nombres y pies de figura sugeridos en formato APA:

1. `screenshot/01-docker-build.png`: construccion de la imagen completada correctamente.
2. `screenshot/02-docker-compose-up.png`: servicios iniciados y saludables.
3. `screenshot/03-docker-ps.png`: estado de ambos contenedores.
4. `screenshot/04-docker-network-inspect.png`: red y contenedores conectados.
5. `screenshot/05-comunicacion-ghost-mysql-terminal.png` y `screenshot/05b-comunicacion-publicacion-web.png`: registro consultado en MySQL y pagina servida por Ghost.
6. La ejecucion verde del workflow Docker CI en GitHub Actions, pendiente de generar despues de subir el workflow al repositorio.

Incluye en el PDF el diagrama de arquitectura del README, las conclusiones de la prueba y las referencias bibliográficas listadas al final de ese README.

## Conclusiones

La aplicación y la base de datos se despliegan como contenedores independientes. El DNS interno de Docker permite que Ghost use el nombre de servicio `mysql`, mientras los volúmenes conservan los datos y el healthcheck ordena el arranque. El workflow de CI valida el build, la disponibilidad de los servicios y la inicialización de la base de datos en cada push y pull request.
