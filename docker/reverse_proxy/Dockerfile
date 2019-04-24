from debian:stable

RUN apt-get update \
    && apt-get install -y nano nginx openssl openssh-server

COPY nginx.conf /etc/nginx/nginx.conf

RUN openssl req -x509 -sha256 -newkey rsa:4096 -nodes \
    -keyout /etc/nginx/teleconet.mbernardi.com.ar.key \
    -out /etc/nginx/teleconet.mbernardi.com.ar.crt -days 365 \
    -subj "/CN=AR/ST=Cordoba/L=Rio Cuarto/O=teleconet/OU=tn/CN=teleconet.mbernadi.com.ar"

RUN ssh-keygen -A \
    && echo root:serverProxy | chpasswd
COPY sshd_config /etc/ssh/sshd_config
RUN mkdir /run/sshd

CMD /usr/sbin/sshd -D & nginx -g "daemon off;"
