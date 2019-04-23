from debian:stable

RUN apt-get update \
    && apt-get install -y nginx nginx-extras openssh-server

RUN mkdir -p /var/www/
COPY servir_archivos /etc/nginx/sites-available/servir_archivos
RUN rm /etc/nginx/sites-enabled/default
RUN rm -r /var/www/html
RUN ln -s /etc/nginx/sites-available/servir_archivos /etc/nginx/sites-enabled/servir_archivos

COPY Teleconet /var/www/Teleconet

CMD ["/usr/sbin/sshd","-D","&",";","nginx","-g","daemon off;"]
