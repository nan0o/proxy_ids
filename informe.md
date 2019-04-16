Servidor Web y Archivos
=======================
Para implementar el servidor web de la empresa se utilizó Docker. Como servidor
web, se utilizó nginx, también se podría haber usado apache, pero como ya lo
probamos decidimos usar nginx.
Está compuesto por tres archivos:
- Dockerfile: Contiene los pasos necesarios para el correcto funcionamiento del
  contenedor, como la instalación de nginx, comandos para ejecutar el servidor y
  copia de archivos necesarios.
- Archivo de configuración de nginx: Este se encarga de configurar nginx de
  forma tal que sepa en qué carpeta brindar el servicio y el puerto a escuchar.
- Página html: Contiene los archivos html, css y las imágenes de la página.

El servidor de archivos es similar, con la diferencia de que no creamos una
página html, sino que creamos una carpeta con los archivos a servir de la
empresa. También se utilizó un módulo dentro del archivo de configuración de
nginx llamado _auto-index_. Este procesa las peticiones que terminan con el
caracter ('/') y produce una lista de directorios.

Reverse Proxy
==============

HTTPS
-----

Snort NIDS
==========

Docker y GNS3
=============
