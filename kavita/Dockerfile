FROM lscr.io/linuxserver/kavita

RUN apt update && apt install -y wget unzip
ENV LIBRARY https://files.earthdefenderstoolkit.com/api/public/dl/-BVFCBDV/
RUN wget -c $LIBRARY -O /tmp/library.zip && \
    unzip /tmp/library.zip -d /data && \
    rm /tmp/library.zip
