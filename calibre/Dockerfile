FROM lscr.io/linuxserver/calibre-web

RUN apt-get update && apt-get install -y wget unzip
ENV LIBRARY https://files.earthdefenderstoolkit.com/api/public/dl/-BVFCBDV/
RUN wget -c $LIBRARY -O /tmp/library.zip && \
    unzip /tmp/library.zip -d /books && \
    rm /tmp/library.zip
ENV LANGUAGE pt_BR.UTF-8
ENV LANG pt_BR.UTF-8
ENV LC_ALL pt_BR.UTF-8
