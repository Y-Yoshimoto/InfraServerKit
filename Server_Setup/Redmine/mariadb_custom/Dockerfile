FROM mariadb
MAINTAINER mariadb_redmine

# 設定ファイルのコピー
COPY my.cnf /etc/mysql/my.cnf

# ポートエクスポート
EXPOSE 3306

# 初期構築データのコピー
COPY redmine_startup.sql /docker-entrypoint-initdb.d/redmine_startup.sql
