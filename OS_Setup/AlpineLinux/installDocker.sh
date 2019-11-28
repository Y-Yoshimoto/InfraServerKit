#/bin/ash
apk update
apk upgrade
apk upgrade musl
# リポジトリ追加
cp -p /etc/apk/repositories /etc/apk/repositories.org
echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# apkからインストール
apk add git docker docker-compose

# Dockerサービス起動, 有効化
rc-update add docker boot
rc-service docker start
rc-service docker status
