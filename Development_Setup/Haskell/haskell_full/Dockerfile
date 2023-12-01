FROM ubuntu:lunar
# https://hub.docker.com/_/ubuntu
LABEL  maintainer "y.yoshimoto"

# apt-get
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential curl \
    libffi-dev libgmp-dev libnuma-dev\
    libffi8ubuntu1 libgmp10 libncurses-dev libncurses5 libtinfo5 \
    && apt-get reinstall -y ca-certificates \
    && update-ca-certificates  \
    && rm -rf /var/lib/apt/lists/* 

# ユーザー追加
ARG USERNAME=vscode
ARG USER_UID=501
ARG USER_GID=20
RUN useradd -m -s /bin/bash -u $USER_UID -g $USER_GID $USERNAME


# スクリプト実行コマンドエイリアス追加
RUN echo 'alias haskell="runghc"' >> /etc/bash.bashrc \
    && echo 'alias hs="runghc"' >> /etc/bash.bashrc 

# ユーザー変更
USER $USERNAME
# GHCupインストール
RUN bash -c "curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh"
# Add ghcup to PATH
ENV PATH=${PATH}:/home/$USERNAME/.local/bin
ENV PATH=${PATH}:/home/$USERNAME/.ghcup/bin
RUN ghcup upgrade && ghcup install hls

# 作業ディレクトリ追加
RUN mkdir -p /home/$USERNAME/code/
COPY ./code/* /home/$USERNAME/code/
WORKDIR /home/$USERNAME/code/
CMD [ "tail", "-f", "/dev/null"]