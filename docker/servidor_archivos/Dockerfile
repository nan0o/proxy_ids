from debian:stable

RUN apt-get update
RUN apt-get install -y nginx

#RUN mkdir /var/www/ ya existe
COPY servir_archivos /etc/nginx/sites-available/servir_archivos
RUN rm /etc/nginx/sites-enabled/default
RUN rm -r /var/www/html
RUN ln -s /etc/nginx/sites-available/servir_archivos /etc/nginx/sites-enabled/servir_archivos

COPY cracks.jpg /var/www/


#WORKDIR /var/www/html cd a esa carpeta

CMD ["nginx","-g","daemon off;"]
