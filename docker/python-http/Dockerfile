from debian:stable

RUN apt-get update
RUN apt-get install -y python3

RUN mkdir /var/www

COPY index.html /var/www/indexa.html

WORKDIR /var/www

CMD ["python3", "-m", "http.server", "8080"]
