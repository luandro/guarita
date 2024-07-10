FROM httpd:alpine

COPY index.html /usr/local/apache2/htdocs/
COPY fundo.jpg /usr/local/apache2/htdocs/
RUN printf "<Directory \"/usr/local/apache2/htdocs\">\n        Header set Access-Control-Allow-Origin \"*\"\n</Directory>\n" >> /usr/local/apache2/conf/httpd.conf