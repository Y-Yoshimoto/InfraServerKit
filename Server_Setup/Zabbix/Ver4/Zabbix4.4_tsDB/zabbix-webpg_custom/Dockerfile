FROM zabbix/zabbix-web-nginx-pgsql:alpine-4.4-latest
MAINTAINER y.yoshimoto

# apk curlのインストール
RUN apk update
RUN apk add curl

# 日本語用 IPAexフォントの設定
RUN curl -O  https://ipafont.ipa.go.jp/IPAfont/ipagp00303.zip
RUN unzip ipagp00303.zip; mv ipagp00303/ipagp.ttf /usr/share/zabbix/assets/fonts/DejaVuSans.ttf

#RUN ln -sf /usr/share/fonts/ipaexg00301/ipaexg.ttf /usr/share/zabbix/fonts/graphfont.ttf

EXPOSE 80
EXPOSE 443
