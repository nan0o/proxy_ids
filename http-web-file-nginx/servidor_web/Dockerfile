from debian:stable

RUN apt-get update
RUN apt-get install -y nginx

#RUN mkdir /var/www/ ya existe
COPY servir_pagina /etc/nginx/sites-available/servir_pagina
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/servir_pagina /etc/nginx/sites-enabled/servir_pagina

COPY html /var/www/

#WORKDIR /var/www/html cd a esa carpeta

CMD ["nginx","-g","daemon off;"]
