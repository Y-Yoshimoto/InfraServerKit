# https://hub.docker.com/_/ubuntu/
FROM ubuntu:24.04
LABEL maintaner='y-yoshimoto'

# Install Easy-RSA
## https://github.com/OpenVPN/easy-rsa
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    easy-rsa \
    sudo jq zip \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*


# CAディレクトの作成, vars.exampleのコピー, easyrsaのシンボリックリンク作成
RUN make-cadir /opt/cadir \
    && cp -p /usr/share/easy-rsa/vars.example /opt/cadir/ \
    && ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin/easyrsa
COPY ./vars /opt/cadir/
COPY ./Create-ServerCertificate.sh /opt/cadir/

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

# コンテナ実行ユーザー追加(既存ユーザーとIDが一致する場合はユーザー名を変更する)
## ユーザー作成 && グループ追加 && 権限変更
ARG USERNAME=causer
ARG UID=1000
ARG GID=1000
RUN useradd --non-unique -m -s /bin/bash -u $UID -g $GID $USERNAME || usermod -l $USERNAME ubuntu --non-unique \
    && usermod -a -G $GID $USERNAME \
    && export GROUP_NAME=$(getent group $GID | awk -F: '{print $1}') \
    && chown -R $USERNAME:$GROUP_NAME /opt/cadir \
    && chmod -R 755 /opt/cadir

# CA作成用の環境設定
USER $USERNAME
WORKDIR /opt/cadir

# PKIツリーを初期化(パスワード付きと無しの2種類で条件分岐)
RUN ./easyrsa init-pki && \
    if [ "$CA_NOPASS" = "true" ]; then \
    printf "%s\n" "$CA_NAME" | ./easyrsa build-ca nopass; \
    else \
    printf "%s\n%s\n%s\n" "$CA_KEYPASS" "$CA_KEYPASS" "$CA_NAME" | ./easyrsa build-ca; \
    fi \
    && mkdir -p ./work

CMD ["tail", "-f", "/dev/null"]
