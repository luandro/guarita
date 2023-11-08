FROM alpine

RUN apk add py3-pip

ENV KOLIBRI_HTTP_PORT 81
RUN pip install kolibri

EXPOSE 81

CMD kolibri start --foreground