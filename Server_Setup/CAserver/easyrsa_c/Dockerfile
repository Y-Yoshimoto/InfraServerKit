# https://hub.docker.com/_/ubuntu/
FROM ubuntu:24.04
LABEL maintaner='y-yoshimoto'

# Install Easy-RSA
## https://github.com/OpenVPN/easy-rsa
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    easy-rsa \
    sudo jq\
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

# Easy-RSAのリンク生成
RUN ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin/easyrsa

# CAディレクトの作成
RUN make-cadir /opt/cadir && \
    cp -p /usr/share/easy-rsa/vars.example /opt/cadir/
WORKDIR /opt/cadir
COPY ./vars /opt/cadir/


# ビルド引数の設定
ARG CA_NOPASS="false"
ARG CA_NAME="SSCA"
ARG CA_KEYPASS="password"
ARG CA_NOPASS="false"
ENV CA_NAME=$CA_NAME
ENV CA_KEYPASS=$CA_KEYPASS
# PKIツリーの場所を指定
ENV EASYRSA=/opt/cadir
ENV EASYRSA_PKI=/opt/cadir/pki

# PKIツリーを初期化(パスワード付きと無しの2種類で条件分岐)
RUN ./easyrsa init-pki && \
    if [ "$CA_NOPASS" = "true" ]; then \
    printf "%s\n" "$CA_NAME" | ./easyrsa build-ca nopass; \
    else \
    printf "%s\n%s\n%s\n" "$CA_KEYPASS" "$CA_KEYPASS" "$CA_NAME" | ./easyrsa build-ca; \
    fi \
    && mkdir -p ./work

CMD ["tail", "-f", "/dev/null"]
