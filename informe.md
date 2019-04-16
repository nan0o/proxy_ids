Servidor Web
============

Servidor Archivos
=================
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

Docker y GNS3
=============
