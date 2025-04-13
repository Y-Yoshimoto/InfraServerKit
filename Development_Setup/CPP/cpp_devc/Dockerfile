FROM debian:bookworm-slim
LABEL maintaner='y-yoshimoto'

# aptインストール
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    git make make jq curl wget\
    clang \
    build-essential cmake\
    pipx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# install cpplint
RUN pipx install cpplint

# 実行ユーザー/作業ディレクトリ作成
ARG USERNAME=vscode
ARG UID=1000
ARG GID=1000
RUN useradd --non-unique -m -s /bin/bash -u $UID -g $GID $USERNAME \
    && usermod -a -G 0 $USERNAME \
    && mkdir -p /usr/src \
    && chown -R $USERNAME /usr/src \
    && mkdir -p /vscode/vscode-server/ \
    && chown $USERNAME /vscode/vscode-server/.*
WORKDIR /usr/src
VOLUME /usr/src

ENTRYPOINT ["tail", "-f", "/dev/null"]