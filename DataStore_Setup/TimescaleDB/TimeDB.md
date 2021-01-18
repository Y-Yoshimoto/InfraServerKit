# PostgreSQL with TimescaleDB

## 設定ファイル
    "/var/lib/postgresql/data/postgresql.conf"をベースに編集し、
    DockerfileにCOPYを追加する。

## 初期化用データ投入
    "/docker-entrypoint-initdb.d"配下に、初期構築用のSQLファイルをコピーする様にDockerfileでCOPYを追加する。

## Mac用クライアントのインストール
Homebrewをインストールし、以下のコマンドでインストールする。
    ``brew install postgresql``

## 接続
psql -U postgres -h localhost -p (32768)
    ポート番号は環境に合わせて指定

## 公式Dockerファイル
    [Docker Hub](https://hub.docker.com/r/timescale/timescaledb/)

## セットアップ参考情報
    [Timescale Docs](https://docs.timescale.com/v1.3/getting-started/setup)
