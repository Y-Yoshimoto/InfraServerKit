FROM centos
MAINTAINER y.yoshimoto

# nginxのインストール
RUN yum install -y gnuplot \
    && yum clean all

# コンテナ実行時の動作設定
ENTRYPOINT ["tail", "-f", "/dev/null"]

# Dockerfileのビルド, 実行, コンテナ内操作
