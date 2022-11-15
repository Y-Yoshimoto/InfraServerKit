FROM ubuntu:22.04
LABEL maintaner='y-yoshimoto'

RUN apt-get update \
    && apt-get install -y --no-install-recommends easy-rsa\
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*


RUN make-cadir /opt/ca
WORKDIR /opt/ca
COPY ./vars /opt/ca/

ARG CAKEYPASS="passward"
ARG CANAME="Easy-RSA CA"
RUN ./easyrsa init-pki \
    && echo $CANAME"\n" > ./caname \
    && ./easyrsa build-ca nopass < ./caname \
    #&& echo $CAKEYPASS"\n"$CAKEYPASS"\n"$CANAME"\n" > ./caname \
    #&& ./easyrsa build-ca < ./caname \
    && rm ./caname

CMD ["tail", "-f", "/dev/null"]
