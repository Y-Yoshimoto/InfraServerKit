#/bin/ash

# リポジトリ追加
cp -p /etc/apk/repositories /etc/apk/repositories.org
echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# アップグレード
apk update
apk upgrade
apk upgrade musl


# apkからインストール
apk add curl git vim
apk add docker docker-compose

# Dockerサービス起動, 有効化
rc-update add docker boot
rc-service docker start
rc-service docker status

# Proxy配下の場合 Proxyサーバ情報を追記
# PROXY = 127.0.0.1:3128
# sed -i -e "s/PROXY/$PROXY/" ./config.json
# cp ./config.json ~/.docker/config.json