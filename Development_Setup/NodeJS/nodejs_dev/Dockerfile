FROM node:alpine
LABEL maintaner='y-yoshimoto'

RUN npm install -g request csv

RUN mkdir -p /app/src
WORKDIR /app/src
VOLUME /app/src

# COPY src/* ./

# コンテナ実行時の動作設定
ENTRYPOINT ["tail", "-f", "/dev/null"]