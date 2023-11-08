FROM lscr.io/linuxserver/calibre-web

ENV LIBRARY https://files.earthdefenderstoolkit.com/api/public/dl/JG1EQd-A/
RUN wget -c $LIBRARY -O /tmp/library.zip && \
    unzip /tmp/library.zip -d /books && \
    rm /tmp/library.zip
