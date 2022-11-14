FROM alpine
MAINTAINER y.yoshimoto

RUN apk add libressl && rm -rf /var/cache/apk/*
COPY opennssl.cnf /etc/ssl/opennssl.cnf
