# https://hub.docker.com/_/alpine
FROM alpine:latest
LABEL maintainer="y.yoshimoto"
RUN apk --no-cache add imagemagick
COPY ./convertIcon.sh /convertIcon.sh 
RUN chmod +x /convertIcon.sh
# CMD ["tail", "-f", "/dev/null"]
ENTRYPOINT [ "/convertIcon.sh"]
