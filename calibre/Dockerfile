FROM lscr.io/linuxserver/calibre-web

RUN apt-get update && apt-get install -y wget unzip
ENV LIBRARY https://files.earthdefenderstoolkit.com/api/public/dl/-BVFCBDV/
RUN wget -c $LIBRARY -O /tmp/library.zip && \
    unzip /tmp/library.zip -d /books && \
    rm /tmp/library.zip
COPY setup.py /tmp/setup.py
RUN python /tmp/setup.py
