# Evidencias Docker y CI

Las capturas locales se tomaron el 7 de noviembre de 2026 durante la ejecucion real del proyecto. Insertarlas en el documento en el orden indicado; las descripciones sirven como titulos de figura estilo APA 7.

| Archivo | Figura / descripcion | Evidencia |
|---|---|---|
| `01-docker-build.png` | **Figura 1.** Construccion de la imagen propia de Ghost. | `docker build` finaliza con codigo 0. |
| `02-docker-compose-up.png` | **Figura 2.** Inicio de los servicios con Docker Compose. | Ghost y MySQL quedan saludables. |
| `03-docker-ps.png` | **Figura 3.** Estado de los contenedores en ejecucion. | Los dos servicios aparecen saludables. |
| `04-docker-network-inspect.png` | **Figura 4.** Red Docker y contenedores conectados. | `ghostops-network` incluye Ghost y MySQL. |
| `05-comunicacion-ghost-mysql-terminal.png` | **Figura 5.** Verificacion de comunicacion desde la aplicacion a MySQL. | Se consulta la publicacion `coming-soon` en MySQL y Ghost devuelve HTTP 200 para esa ruta. |
| `05b-comunicacion-publicacion-web.png` | **Figura 6.** Publicacion servida por Ghost. | Captura del navegador en `/coming-soon/`. |
| `06-github-actions-ci.png` | **Figura 7.** Ejecucion exitosa del workflow Docker CI en GitHub Actions. | Run #1 finalizado con `success` en la rama `CICDEdinson`. [Ver ejecucion](https://github.com/JonathanFrancoS/GhostOpsCICD/actions/runs/42404274686). |

Debajo de cada figura, incluye una nota como: *Nota.* Captura de pantalla propia, ejecucion local del proyecto (7 de noviembre de 2026).

La publicacion `coming-soon` es contenido de demostracion inicial de Ghost. La captura confirma que el servicio sirve contenido consultado desde MySQL. Para demostrar tambien una escritura manual de la aplicacion, crea y publica una entrada con el slug `prueba-comunicacion` desde `/ghost` y ejecuta:

```powershell
.\scripts\verify-communication.ps1 -Slug prueba-comunicacion
```

La ejecucion de Actions valida la configuracion Compose, construye la imagen, inicia ambos servicios, comprueba Ghost por HTTP y verifica que MySQL contenga la tabla `posts`. El run completo finalizo correctamente; GitHub tambien muestra avisos informativos de mantenimiento que no afectan el resultado verde.
