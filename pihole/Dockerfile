# https://hub.docker.com/r/pihole/pihole/tags
FROM pihole/pihole:2022.10

# https://github.com/jacklul/pihole-updatelists#install-with-docker
RUN apt-get update && apt-get install -Vy wget php-cli php-sqlite3 php-intl php-curl
RUN wget -O - https://raw.githubusercontent.com/jacklul/pihole-updatelists/master/install.sh | bash /dev/stdin docker

WORKDIR /usr/src/app

ENV LOCAL_DOMAIN nhandeflix.com
ENV LOCAL_IP 192.168.1.13

COPY cont-init.d/ /etc/cont-init.d/

ENV DEBIAN_FRONTEND noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV INTERFACE eth0
ENV DNSMASQ_LISTENING single
ENV PIHOLE_DNS_ 1.1.1.1;1.0.0.1
ENV WEBPASSWORD jekupe
ENV TZ 'America/Sao_Paulo'
ENV WEB_PORT 84
ENV VIRTUAL_HOST balena-devices.com
