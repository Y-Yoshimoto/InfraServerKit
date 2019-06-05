# Redmineのセットアップについて

## 初期設定
`` docker-compose up -d ``で起動し``http://localhost``でアクセスする。
右上のログインを選択し、"Admin:zabbix"でログインする。

###timescaleDB関連
管理 > 一般設定 > データの保存期間
    - アイテムのヒストリの保存期間設定を上書き
    - アイテムのトレンドの保存期間設定を上書き
    上記2つの設定を変更する

## ダンプファイルの取得
以下のコマンでダンプファイルを生成し、次起動時に読み込めるようにしておく
``docker ps -a | grep zabbix-timescaledb`
上記コマンドでポート番号を特定し、以下のコマンドでダンプファイルを取得する
``pg_dump -U zabbix -h localhost -p {port} zabbix > timescaledb_custom/zabbix_startup.sql``

## Agentの設定
yum install -y http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-1.el7.centos.noarch.rpm
yum install -y zabbix-agent
#### コンフィグサンプル
cp -p /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf.bk
vi /etc/zabbix/zabbix_agentd.conf
Server=192.168.1.0/24
ServerActive=192.168.1.0/24
Hostname=node01
####
systemctl start zabbix-agent
systemctl enable zabbix-agent
