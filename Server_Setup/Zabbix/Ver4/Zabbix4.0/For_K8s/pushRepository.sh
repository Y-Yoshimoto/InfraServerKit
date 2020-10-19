#!/bin/sh
# イメージ確認
docker images | grep zabbix
# タグ付け
docker tag zabbix-ap kube1:30500/zabbix-k8s/zabbix-ap
docker tag zabbix-web kube1:30500/zabbix-k8s/zabbix-web
docker tag zabbix-mariadb kube1:30500/zabbix-k8s/zabbix-mariadb

# ベースイメージ削除
docker rmi zabbix-ap zabbix-web zabbix-mariadb
# イメージプッシュ
docker push kube1:30500/zabbix-k8s/zabbix-ap
docker push kube1:30500/zabbix-k8s/zabbix-web
docker push kube1:30500/zabbix-k8s/zabbix-mariadb
# レポジトリ表示
curl kube1:30500/v2/_catalog

# docker pull kube1:30500/zabbix-k8s/zabbix-web
# docker pull kube1:30500/zabbix-k8s/zabbix-mariadb
