FROM ubuntu:22.04
LABEL maintaner='y-yoshimoto'

RUN apt-get update \
    && apt-get install -y --no-install-recommends easy-rsa\
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && update-ca-certificates

CMD ["tail", "-f", "/dev/null"]
