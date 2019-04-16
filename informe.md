Servidor Web
============

Servidor Archivos
=================

Reverse Proxy
=============

HTTPS
-----

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
