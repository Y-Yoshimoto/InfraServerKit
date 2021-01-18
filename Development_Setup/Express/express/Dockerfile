FROM node:latest
LABEL  maintainer "y.yoshimoto"

# ワークディレクトリ作成
WORKDIR /usr/src/app
# npmパッケージ
COPY package*.json ./
RUN npm install
# RUN npm install --only=production
# ソースコード配置
COPY contents/* ./

EXPOSE 8040
CMD [ "node", "server.js" ]