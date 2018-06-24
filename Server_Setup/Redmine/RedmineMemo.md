# Redmineのセットアップについて

## 初期設定
`` docker-compose up -d ``で起動し``http://localhost``でアクセスする。
右上のログインを選択し、"admin:admin"でログインする。

## ダンプファイルの取得
mysqldump -u root -p -h 127.0.0.1 -d redmine > redmine_startup.sql
