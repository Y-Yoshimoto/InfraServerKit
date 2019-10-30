FROM mariadb
MAINTAINER y.yoshimoto

# 設定ファイルのコピー
COPY my.cnf /etc/mysql/my.cnf

# ポートエクスポート
EXPOSE 3306

# 初期構築データのコピー
#COPY zabbix_startup.sql /docker-entrypoint-initdb.d/zabbix_startup.sql
