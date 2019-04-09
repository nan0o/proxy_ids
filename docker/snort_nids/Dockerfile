FROM fedora:29

RUN set -x

RUN dnf -y install https://forensics.cert.org/cert-forensics-tools-release-29.rpm \
    && dnf -y install snort

RUN rm -r /etc/snort

COPY etc/* /etc/

