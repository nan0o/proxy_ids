Servidor Web y Archivos
=======================
Para implementar el servidor web de la empresa se utilizó Docker. Como servidor
web, se utilizó nginx, también se podría haber usado apache, pero como ya lo
probamos decidimos usar nginx.
Está compuesto por tres archivos:
- **Dockerfile**: Contiene los pasos necesarios para el correcto funcionamiento del
  contenedor, como la instalación de nginx, comandos para ejecutar el servidor y
  copia de archivos necesarios.
- **Archivo de configuración de nginx**: Este se encarga de configurar nginx de
  forma tal que sepa en qué carpeta brindar el servicio y el puerto a escuchar.
- **Página html**: Contiene los archivos html, css y las imágenes de la página.

El servidor de archivos es similar, con la diferencia de que no creamos una
página html, sino que creamos una carpeta con los archivos a servir de la
empresa. También se utilizó un módulo dentro del archivo de configuración de
nginx llamado _auto-index_. Este procesa las peticiones que terminan con el
caracter ('/') y produce una lista de directorios.

Sin embargo, el servidor web y archivos se encuentran separados en distintos
contenedores, como si fuesen distintos hosts dentro de la empresa, de forma tal
que el proxy reverso sea el encargado de redirigir el tráfico al correspondiente.

HTML Y CSS
----------
HTML (Hyper Text Markup Language) es el lenguaje estándar de marcado en el
diseño de páginas web. Un lenguaje de marcado o marcas es uno en el cual el texto
va acompañado de marcas o etiquetas que contienen información adicional sobre
la estructura del documento. 
CSS (Cascading Style Sheets) describe el formato de presentación de una página
html. Sirve para ahorrar trabajo cuando se tienen varias páginas web a servir.
La forma más común de implementación es crear los estilos de los elementos html
en un archivo externo y después importarlo en el documento.

El diseño de la página se realizó en HTML5 y en CSS desde cero. Existen varias
modificaciones en esta versión de HTML como la incorporación de soporte nativo
para JavaScript, cambios en la semántica de la estructura del documento, etc..

![Dif HTML](https://www.hostinger.com/tutorials/wp-content/uploads/sites/2/2017/03/differences-between-html-and-html5.png "Diferencias HTML y HTML5")

En nuestra página, cuando alguien clickea el botón de "Descargas", es redireccionado
al servidor de archivos que se encuentra en otro host por el proxy reverso. 

Reverse Proxy
=============
El proxy inverso es un servidor que es capaz de manejar multiples servidores, por ejemplo web, php o python, y dividir las peticiones para cada uno de ellos individualmente. Por ejemplo, cuando un cliente desea ingresar a alguno de los servidores administrados por este proxy inverso, este redirecciona la petición al servidor indicado y devuelve al cliente lo solicitado. Una gran ventaja de esto es la posibilidad de tener múltiples servidores en una misma dirección IP.
Para este trabajo se desarrolló un proxy inverso, que administra un servidor con la página web de la empresa y un servidor de archivos también como página web, mediante la herramienta NGINX. El server se realizó de la siguiente manera:

```
server {
	listen 80;
	server_name teleconet.mbernardi.com.ar;

	location / {
		proxy_pass http://10.0.0.11:80/;
	}
	location /archivos {
		proxy_pass http://10.0.0.12:80/;
	}
}

```
En esta parte del código de nginx se puede ver como se crea el servidor. Debido a que los servidores son solo http, el proxy inverso escucha en el puerto 80 y redirecciona de acuerdo a si la petición fue para la página principal o los archivos haciendo un proxy_pass a la IP indicada o bien puede ser a un dominio determinado en caso que exista un dns.

https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/ Página de nginx

HTTPS
-----
Debido a que http es poco seguro, utilizamos https para darle mayor seguridad a nuestra red. Es decir, que las peticiones que se hacen a los servidores http en realidad estan cifradras en https hasta que llegan al servidor proxy y este se encarga de interpretar. Para ello es necesario crear un certificado que generen la clave de cifrado que permita encriptar la información. A su vez, también es necesario que el servidor no solo trabaje en el puerto 80 de http, sino que también utilice el puerto 443 que es de https.
Para lograr que el servidor maneje https dentro del código en nginx se debe agregar:
```
	listen 443 ssl;
	ssl_certificate teleconet.mbernardi.com.ar.crt;
	ssl_certificate_key teleconet.mbernardi.com.ar.key;
	ssl_protocols TLSv1 TLSv1.1 TLSv1.2;

	ssl_ciphers 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256';

	ssl_prefer_server_ciphers on;
```
¿Hace falta explicar TLS y ciphers?

Snort NIDS
==========

Hacer muchos juicios de valor?

Buscar si se puede suar un Cisco para mandar todo el trafico a un puerto como si
fuera un hub.

Snort se puede utilizar de tres formas:

- Sniffer mode: Lee paquetes presentes en la red y los muestra en la consola,
  similar a Wireshark.

- Packet logger mode: Lee paquetes presentes en la red y los guarda en un
  archivo.

- Network Intrusion Detection System (NIDS) mode: Lee paquetes presentes en la
  red y los analiza para determinar si es necesario realizar una acción. Puede
  trabajar en modo pasivo o Inline:

    - Pasivo: Es lo que utilizamos, analiza el tráfico para observar paquetes
      sospechosos y advertir al administrador.

    - Inline: Se coloca el servidor Snort de forma que éste pueda bloquear
      tráfico dependiendo de los patrones observados, como si se tratase de un
      firewall.

Nosotros utilizamos y recomendamos el modo Pasivo, al menos en un principio ya
que al utilizarse en modo Inline se necesita mucho cuidado, un gran
mantenimiento y mucho trabajo. Un error de configuración, o una falla en el
servidor por otras causas dejaría fuera de línea al sitio web de la empresa.
Además pequeños errores de configuración pueden significar problemas para sólo
algunos usuarios y sería difícil darse cuenta y corregirlo.

Suponemos que es una empresa chica y no dispondrá de un administrador disponible
todo el tiempo, por ejemplo que se tenga un administrador que trabaja en varias
empresas o que tiene otros trabajos dentro de la empresa, y le dedica solamente
2hs por semana a los servidores. Por eso nos parece útil tener un NIDS que
genere alertas para notificar al administrador o que las almacene para que la
semana siguiente el administrador las revise.

Por lo tanto lo usamos sólo para alertar (notificar) al administrador sobre
paquetes sospechosos, los paquetes a alertar se determinan a partir de reglas
escritas por el administrador.

Nuestra prioridad es detectar tráfico que indique:

- Que indique que ya se ha comprometido un servidor dentro de la red, por
  ejemplo si uno de los servidores está originando tráfico UDP, o si hay tráfico
  desde y hacia una IP local que no debería existir.

- Que indique que desde fuera se está realizando un escaneo de la red, por
  ejemplo si hay muchas solicitudes simultáneas, o si están accediendo a muchas
  URLs que dan 404.

- Que indique algunas cosas que no deberían suceder, por ejemplo tráfico SSH
  desde alguna máquina que no sea la del administrador.

Hay que tener en cuenta que el router de la empresa ya funciona como un firewall
básico y no debería haber tráfico que no sea por los puertos 80 y 443.

Arquitectura
------------

Se debe usar un Hub pero recomendamos utilizar un switch que permita mostrar
todo el tráfico de la red en una de sus bocas para conectar ahí el servidor de
Snort.

http://manual-snort-org.s3-website-us-east-1.amazonaws.com/

Docker y GNS3
=============
