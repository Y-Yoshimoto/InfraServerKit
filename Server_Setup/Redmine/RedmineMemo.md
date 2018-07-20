# Redmineのセットアップについて

## 初期設定
`` docker-compose up -d ``で起動し``http://localhost``でアクセスする。
右上のログインを選択し、"admin:admin"でログインする。
設定変更後のパスワードは、"adminadmin"とする。

## ダンプファイルの取得
以下のコマンでダンプファイルを生成し、次起動時に読み込めるようにしておく
``docker ps -a | grep mariadb_redmine``
上記コマンドでポート番号を特定し、以下のコマンドでダンプファイルを取得する
``mysqldump -u root -p -h 127.0.0.1 -P {port} redmine --hex-blob > mariadb_custom/redmine_startup.sql``

## サブディレクトリについて
 "/usr/src/redmine/config.ru"ファイルを同梱物のように設定し、"relative_url_root"を利用するように設定を変更する。
 dokcer-compose.yamlで、環境変数として、"RAILS_RELATIVE_URL_ROOT: /redmine"を設定する。
