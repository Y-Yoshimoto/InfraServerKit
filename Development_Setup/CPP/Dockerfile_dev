FROM debian:bookworm-slim
LABEL maintaner='y-yoshimoto'

# aptインストール
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    git make make jq curl wget sudo\
    clang clang-format clang-tidy \
    build-essential cmake\
    pipx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# 実行ユーザー/作業ディレクトリ作成
ARG USERNAME=vscode
ARG UID=1000
ARG GID=1000
RUN useradd --non-unique -m -s /bin/bash -u $UID -g $GID $USERNAME \
    && usermod -a -G 0 $USERNAME \
    && mkdir -p /usr/dev \
    && chown -R $USERNAME /usr/dev \
    && mkdir -p /vscode/vscode-server/ \
    && chown $USERNAME /vscode/vscode-server/.*

# install cpplint
RUN sudo -u $USERNAME pipx install cpplint \
    && sudo -u $USERNAME pipx ensurepath

WORKDIR /usr/dev
VOLUME /usr/dev

ENTRYPOINT ["tail", "-f", "/dev/null"]