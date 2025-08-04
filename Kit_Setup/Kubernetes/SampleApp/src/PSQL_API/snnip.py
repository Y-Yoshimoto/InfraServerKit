#!/usr/bin/env python
# coding:utf-8

from PSQL_CONNECTOR.connSample import connect_db, connect_db_pool, connect_db_async_pool
from PSQL_CONNECTOR.connSample import DbEndpoint

from PSQL_CONNECTOR.connector import Connector

# 環境変数を読み込む
import os

# DB接続情報の設定
config = DbEndpoint(
    dbname="sampledb",
    user="postgres",
    password="postgres",
    # host="postgres_c",
    host=os.getenv("ENDPOINT_POSTGRES"),
    port=5432
)

def main():
    print("main.py")
    print(f"Connecting to database with config: {config}")
    # コネクタのインスタンスを生成
    connector = Connector(config)
    print("Connector created successfully")
    # コネクションプールを使用してSELECTクエリを実行
    try:
        results = connector.execute_select_query("SELECT * FROM request_data;")
        for record in results:
            print(record)
    except Exception as e:
        print(f"Error executing query: {e}")

    connector.execute_commit_query("INSERT INTO request_data (message) VALUES ('Hello, World!') RETURNING id;")

    try:
        results = connector.execute_select_query("SELECT * FROM request_data;")
        for record in results:
            print(record)
    except Exception as e:
        print(f"Error executing query: {e}")

    # print('1 ---------------------')
    # connect_db(config)

    # print('2 ---------------------')
    # connect_db_pool(config)

    # print('3 ---------------------')
    # asyncio.run(connect_db_async_pool(config))

    # print("Finished database operations")

if __name__ == "__main__":
    main()
