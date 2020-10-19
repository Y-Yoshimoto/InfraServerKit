FROM alpine:latest AS build-env
MAINTAINER y.yoshimoto
# apk curlのインストール
RUN apk --no-cache add postfix curl
# 日本語用 IPAexフォントの取得
RUN curl -O  https://ipafont.ipa.go.jp/IPAfont/ipagp00303.zip
RUN unzip ipagp00303.zip 

# Zabbix Imageへのコピー
FROM zabbix/zabbix-web-nginx-mysql:alpine-5.0-latest
COPY --from=build-env /ipagp00303/ipagp.ttf /usr/share/zabbix/assets/fonts/DejaVuSans.ttf