# https://hub.docker.com/_/scratch
# FROM scratch
# https://hub.docker.com/_/busybox
# FROM busybox:latest
# https://hub.docker.com/_/alpine
FROM alpine:latest
# Install rsync
RUN apk add --no-cache rsync \
    && mkdir -p /data \
    && mkdir -p /orgdata
# Define a volume for syncing
VOLUME [ "/data" ]
# Copy data into the container
COPY ./data /orgdata
# Sync /orgdata to /sync on container start
CMD ["sh", "-c", "rsync -av --delete /orgdata/ /data/"]