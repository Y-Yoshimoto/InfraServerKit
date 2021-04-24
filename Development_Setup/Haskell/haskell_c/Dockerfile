# build
FROM fedora:latest
# https://hub.docker.com/_/haskell?tab=description
LABEL  maintainer "y.yoshimoto"
RUN dnf install -y ghc cabal-install stack && \
    dnf clean all

# add code
RUN mkdir /code
COPY . /code/
WORKDIR /code
CMD [ "tail", "-f", "/dev/null"]