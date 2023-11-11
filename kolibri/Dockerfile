FROM alpine

RUN apk add py3-pip

ENV KOLIBRI_HTTP_PORT 87
RUN pip install kolibri

EXPOSE 87

CMD kolibri start --foreground