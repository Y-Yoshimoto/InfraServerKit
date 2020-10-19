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
