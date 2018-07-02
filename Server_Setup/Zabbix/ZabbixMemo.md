# Redmineのセットアップについて

## 初期設定
`` docker-compose up -d ``で起動し``http://localhost``でアクセスする。
右上のログインを選択し、"Admin:zabbix"でログインする。

## ダンプファイルの取得
以下のコマンでダンプファイルを生成し、次起動時に読み込めるようにしておく
``docker ps -a | grep mariadb_zabbix``
上記コマンドでポート番号を特定し、以下のコマンドでダンプファイルを取得する
``mysqldump -u root -p -h 127.0.0.1 -P {port} zabbix --hex-blob > mariadb_custom/zabbix_startup.sql``
