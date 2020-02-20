FROM busybox:latest
LABEL maintainer 'y-yoshimoto'

RUN mkdir -p /squidlog

ENTRYPOINT ["tail", "-f" ,"squidlog/access.log"]

