FROM alpine:3.14

RUN apk add py3-pip

RUN pip install kolibri

EXPOSE 8080

CMD kolibri start --foreground