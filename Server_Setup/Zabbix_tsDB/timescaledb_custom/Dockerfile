FROM timescale/timescaledb
MAINTAINER y.yoshimoto

# 設定ファイルのコピー
# sample: /usr/share/postgresql/postgresql.conf.sample
# COPY postgresql.conf /var/lib/postgresql/data/postgresql.conf

# 初期構築データのコピー
COPY zabbix_startup.sql /docker-entrypoint-initdb.d/zabbix_startup.sql
