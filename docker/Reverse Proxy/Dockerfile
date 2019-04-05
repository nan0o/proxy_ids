from debian:stable

RUN apt-get update && apt-get install nano nginx openssl "hids"

COPY nginx.conf /etc/nginx/nginx.conf 

RUN openssl req -x509 -sha256 -newkey rsa:4096 -nodes -keyout teleconet.mbernardi.com.ar.key -out teleconet.mbernardi.com.ar.crt -days 365 -subj "/CN=AR/ST=Cordoba/L=Rio Cuarto/O=teleconet/OU=tn/CN=teleconet.mbernadi.com.ar" 

'''req es de request
-sha256 es el modo que usa para crear el hash, este de 256 bits.
-newkey rsa:xxxx indica que crea una nueva key con tamaño rsa. Si ya tenes una key podes generar el certificado directamente con openssl req -key domain.key -new -out domain.csr
-nodes es para que no tengas que darle una contraseña
-keyout el nombre que va a tener la clave que generas
-out el nombre del certificado a la salida
-days la duración de validez del certificado
-subj es para darle lo que necesitas para crear el certificado (pais, provincia, ciudad, empresa,etc)
'''
