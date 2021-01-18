# build
FROM alpine:latest
# https://hub.docker.com/_/alpine
LABEL  maintainer "y.yoshimoto"
RUN apk --no-cache add imagemagick
RUN echo -e "#!/bin/ash \n convert /tmp/\$1 -define icon:auto-resize /tmp/favicon.ico" > /convertIcon.sh && \
    chmod 777 /convertIcon.sh
#CMD [ "tail", "-f", "/dev/null"]
ENTRYPOINT [ "/convertIcon.sh"]