FROM alpine:latest
LABEL maintainer 'y-yoshimoto'

RUN apk --no-cache add tzdata squid
COPY squid.conf /etc/squid/squid.conf
RUN mkdir -p /var/cache/squid && mkdir -p /var/spool/squid 

ENTRYPOINT ["/usr/sbin/squid", "-f" ,"/etc/squid/squid.conf", "--foreground", "-CY"]
# --foreground: Master process runs in foreground and creates worker kids.
# -C: Do not catch fatal signals.
# -Y: Only return UDP_HIT or UDP_MISS_NOFETCH during fast reload.
