# Redmineのセットアップについて

## 初期設定
`` docker-compose up -d ``で起動し``http://localhost``でアクセスする。
右上のログインを選択し、"Admin:zabbix"でログインする。

## ダンプファイルの取得(maraidb)
以下のコマンでダンプファイルを生成し、次起動時に読み込めるようにしておく
``docker ps -a | grep mariadb_zabbix``
上記コマンドでポート番号を特定し、以下のコマンドでダンプファイルを取得する(パスワード: zabbix)
``mysqldump -u root -p -h 127.0.0.1 -P {port} zabbix --hex-blob > mariadb_custom/zabbix_startup.sql``

## Agentの設定
### ZabbixServer用(Agentコンテナ利用)
    1. 環境変数"ZBX_SERVER_HOST"の値を"zabbix-ap"のコンテナ名に設定する。
    2. ZabbixServer起動後ZabbixサーバGUI上で"Zabbix Server"のDNS名を"zabbix-agent"コンテナ名に変更する。

### 監視対象ホスト
    ZabbixAgetnSetUp配下のLinux,Windows用をそれぞれ実行する。
    IPアドレス等を実環境に合わせて修正
    ps1ファイルについては"Set-ExecutionPolicy RemoteSigned"コマンドでスクリプトを有効化すること

## SNMP
    "/snmp_data/mibs"配下に追加のmibファイルを追加
