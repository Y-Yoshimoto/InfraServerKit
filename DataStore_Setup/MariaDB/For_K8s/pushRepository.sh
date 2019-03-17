#!/bin/sh
# イメージ確認
docker images | grep mariadb
# タグ付け
docker tag mariadb kube1:30500/datastore/mariadb

# ベースイメージ削除
docker rmi mariadb
# イメージプッシュ
docker push kube1:30500/datastore/mariadb
# レポジトリ表示
curl kube1:30500/v2/_catalog

# docker pull kube1:30500/zabbix-k8s/zabbix-web
# docker pull kube1:30500/zabbix-k8s/zabbix-mariadb
