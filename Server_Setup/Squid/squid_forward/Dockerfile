FROM alpine:latest
LABEL maintainer 'y-yoshimoto'

RUN apk --no-cache add squid
COPY squid.conf /etc/squid/squid.conf

ENTRYPOINT ["/usr/sbin/squid", "-f" ,"/etc/squid/squid.conf", "--foreground", "-CY"]
# --foreground: Master process runs in foreground and creates worker kids.
# -C: Do not catch fatal signals.
# -Y: Only return UDP_HIT or UDP_MISS_NOFETCH during fast reload.
