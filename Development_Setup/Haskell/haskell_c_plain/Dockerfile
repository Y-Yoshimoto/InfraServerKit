FROM haskell:slim-buster
# https://hub.docker.com/_/haskell
LABEL  maintainer "y.yoshimoto"

# スクリプト実行コマンドエイリアス追加
RUN echo 'alias haskell="runghc"' >> /etc/bash.bashrc \
    && echo 'alias hs="runghc"' >> /etc/bash.bashrc 

# ユーザー追加
RUN useradd -m -s /bin/bash -u 501 -g 20 run

# 作業ディレクトリ追加
RUN mkdir -p /code/ && chown run /code/
#COPY ./haskell_c/code/* /code/
WORKDIR /code
CMD [ "tail", "-f", "/dev/null"]