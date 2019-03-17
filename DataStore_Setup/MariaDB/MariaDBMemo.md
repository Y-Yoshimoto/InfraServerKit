# セットアップについて
## ダンプファイルの取得
以下のコマンでダンプファイルを生成し、次起動時に読み込めるようにしておく
``docker ps -a | grep mariadb``
上記コマンドでポート番号を特定し、以下のコマンドでダンプファイルを取得する
``mysqldump -u root -p -h 127.0.0.1 -P {port} root --hex-blob > mariadb_custom/startup.sql``
