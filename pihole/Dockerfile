# https://hub.docker.com/r/pihole/pihole/tags
FROM pihole/pihole:2022.04.2

WORKDIR /usr/src/app

COPY cont-init.d/ /etc/cont-init.d/
COPY custom-dns/* /etc/dnsmasq.d/

ENV DEBIAN_FRONTEND noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV INTERFACE eth0
ENV DNSMASQ_LISTENING single
ENV PIHOLE_DNS_ 1.1.1.1;1.0.0.1
ENV WEBPASSWORD jekupe
ENV TZ 'America/Sao_Paulo'
ENV WEB_PORT 84
ENV VIRTUAL_HOST balena-devices.com
