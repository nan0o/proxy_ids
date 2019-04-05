from debian:stable

RUN apt-get update && apt-get install nano nginx openssl "hids"

COPY nginx.conf /etc/nginx/nginx.conf 

RUN openssl req -x509 -sha256 -newkey rsa:4096 -nodes -keyout teleconet.mbernardi.com.ar.key -out teleconet.mbernardi.com.ar.crt -days 365 -subj "/CN=AR/ST=Cordoba/L=Rio Cuarto/O=teleconet/OU=tn/CN=teleconet.mbernadi.com.ar" 
