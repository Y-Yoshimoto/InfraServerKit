#!/bin/sh
# イメージ確認
docker images | grep zabbix
# タグ付け
docker tag zabbix-ap localhost:30500/zabbix-k8s/zabbix-ap
docker tag zabbix-web localhost:30500/zabbix-k8s/zabbix-web
docker tag zabbix-mariadb localhost:30500/zabbix-k8s/zabbix-mariadb

# ベースイメージ削除
docker rmi zabbix-ap zabbix-web zabbix-mariadb
# イメージプッシュ
docker push localhost:30500/zabbix-k8s/zabbix-ap
docker push localhost:30500/zabbix-k8s/zabbix-web
docker push localhost:30500/zabbix-k8s/zabbix-mariadb
# レポジトリ表示
curl localhost:30500/v2/_catalog

# docker pull localhost:30500/zabbix-k8s/zabbix-web
# docker pull localhost:30500/zabbix-k8s/zabbix-mariadb
