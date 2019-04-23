from debian:stable

RUN apt-get update \
    && apt-get install -y nginx openssh-server

RUN mkdir -p /var/www/
COPY servir_pagina /etc/nginx/sites-available/servir_pagina
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/servir_pagina /etc/nginx/sites-enabled/servir_pagina

COPY html /var/www/

RUN ssh-keygen -A \
    && echo root:serverWeb | chpasswd
COPY sshd_config /etc/ssh/sshd_config
RUN mkdir /run/sshd

CMD /usr/sbin/sshd -D & nginx -g "daemon off;"
