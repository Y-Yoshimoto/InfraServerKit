# Redmineのセットアップについて

## 初期設定
`` docker-compose up -d ``で起動し``http://localhost``でアクセスする。
右上のログインを選択し、"Admin:zabbix"でログインする。

## ダンプファイルの取得
以下のコマンでダンプファイルを生成し、次起動時に読み込めるようにしておく
``docker ps -a | grep mariadb_zabbix``
上記コマンドでポート番号を特定し、以下のコマンドでダンプファイルを取得する(パスワード: zabbix)
``mysqldump -u root -p -h 127.0.0.1 -P {port} zabbix --hex-blob > mariadb_custom/zabbix_startup.sql``

## Agentの設定
yum install -y http://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-agent-4.0.8-1.el7.x86_64.rpm
yum install -y zabbix-agent
####
cp -p /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf.bk
vi /etc/zabbix/zabbix_agentd.conf
Server=10.0.0.30
ServerActive=10.0.0.30
Hostname=node01
####
systemctl start zabbix-agent
systemctl enable zabbix-agent
