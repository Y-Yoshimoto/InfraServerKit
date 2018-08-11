FROM centos
MAINTAINER gnuplot_custom

# nginxのインストール
RUN yum install -y gnuplot
# RUN yum install -y nginx

# コンテツファイルの設置
# COPY contents/* /usr/share/nginx/html/

# nginx設定ファイルの設置

# コンテナ実行時の動作設定
ENTRYPOINT ["tail", "-f", "/dev/null"]

# Dockerfileのビルド, 実行, コンテナ内操作
## docker build --tag="centos/apinginx:0.1" .
## docker build -f ./Dockerfile -t centos/apinginx --no-cache .
## docker run -d --name apinginx -i -t -p 80:80 centos/apinginx:0.1
## docker exec -it apinginx /bin/bash
