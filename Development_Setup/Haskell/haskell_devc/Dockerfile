FROM haskell:slim-buster
# https://hub.docker.com/_/haskell
LABEL  maintainer "y.yoshimoto"

# スクリプト実行コマンドエイリアス追加
RUN echo 'alias haskell="runghc"' >> /etc/bash.bashrc \
    && echo 'alias hs="runghc"' >> /etc/bash.bashrc \
    && echo 'alias hsi="runghci"' >> /etc/bash.bashrc

# ユーザー追加
ARG USERNAME=vscode
ARG USER_UID=501
ARG USER_GID=20
RUN useradd -m -s /bin/bash -u $USER_UID -g $USER_GID $USERNAME

# 作業ディレクトリ追加
RUN mkdir -p /code/ && chown $USERNAME /code/
#COPY ./haskell_c/code/* /code/
RUN mkdir -p /home/$USERNAME/code/ && chown $USERNAME /home/$USERNAME/code/
WORKDIR /home/$USERNAME/code/
CMD [ "tail", "-f", "/dev/null"]