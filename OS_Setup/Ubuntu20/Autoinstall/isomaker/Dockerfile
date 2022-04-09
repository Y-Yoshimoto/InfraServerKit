FROM ubuntu:20.04
LABEL maintaner='y-yoshimoto'

## apt install
RUN apt update && apt install -y wget xorriso genisoimage && rm -rf /var/lib/apt/lists/*

## VOLUME
WORKDIR /usr/src
VOLUME /usr/src

ENTRYPOINT ["tail", "-f", "/dev/null"]