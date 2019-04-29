FROM zabbix/zabbix-web-nginx-mysql:alpine-3.4-latest
MAINTAINER y.yoshimoto

# apk curlのインストール
RUN apk update
RUN apk add curl

# 日本語用 IPAexフォントの設定
RUN curl -O  https://oscdl.ipa.go.jp/IPAexfont/ipaexg00301.zip
RUN unzip ipaexg00301.zip -d /usr/share/fonts/
RUN ln -sf /usr/share/fonts/ipaexg00301/ipaexg.ttf /usr/share/zabbix/fonts/graphfont.ttf

EXPOSE 80
EXPOSE 443
