# Entrega 1 - Infraestructura Docker

## 1. Objetivo

Implementar una infraestructura de software basada en contenedores Docker que permita ejecutar Ghost y MySQL como servicios independientes y establecer comunicación entre ambos.

## 2. Descripción de la solución

La solución utiliza Ghost como plataforma de publicación web y MySQL como sistema gestor de bases de datos relacional.

Los servicios se administran mediante Docker Compose, que permite definir y ejecutar la infraestructura desde un único archivo de configuración.

## 3. Servicios implementados

### 3.1 Ghost

Aplicación web responsable de gestionar y publicar contenido.

### 3.2 MySQL

Servicio encargado de almacenar la información utilizada por Ghost.

## 4. Comunicación entre contenedores

Los servicios se conectan mediante una red Docker de tipo bridge denominada ghostops-network.

Ghost utiliza el nombre del servicio mysql como dirección de conexión interna.

## 5. Persistencia

Se definen dos volúmenes:

- ghostops_mysql_data: conserva los datos de MySQL.
- ghostops_ghost_content: conserva el contenido de Ghost.

## 6. Disponibilidad de servicios

MySQL incorpora una comprobación de salud mediante healthcheck.

Docker Compose utiliza esta comprobación para esperar a que la base de datos esté disponible antes de iniciar Ghost.

## 7. Pruebas de validación

Se realizarán las siguientes verificaciones:

- Validación de la configuración Docker Compose.
- Descarga de las imágenes.
- Ejecución de ambos contenedores.
- Verificación del estado de salud de MySQL.
- Inspección de la red Docker.
- Acceso a Ghost desde el navegador.
- Consulta de la base de datos MySQL.
- Comprobación de las tablas creadas por Ghost.

Los resultados y capturas se incorporarán una vez ejecutadas las pruebas.

## 8. Evidencias

Las capturas de pantalla de esta entrega se almacenarán en docs/evidencias/entrega-1.

## 9. Conclusión

La implementación permite establecer una primera infraestructura basada en contenedores, separando la aplicación web de su sistema gestor de bases de datos.

Esta arquitectura constituye la base para incorporar posteriormente herramientas de integración y entrega continua.
