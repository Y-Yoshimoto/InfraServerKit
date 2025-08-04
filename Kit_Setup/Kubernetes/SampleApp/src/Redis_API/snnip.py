#!/usr/bin/env python
# coding:utf-8
from Redis_CONNECTOR.connector import Connector
from Redis_CONNECTOR.connector import RedisEndpoint

# 環境変数を読み込む
import os

# Redis接続情報の設定
config = RedisEndpoint(
    host=os.getenv("ENDPOINT_REDIS"),
    port=6379
)

def main():
    print("main.py")
    print(f"Connecting to Redis with config: {config}")
    connector = Connector(config)
    print("Connector created successfully")

    # Redisに値をセット
    connector.set("test_key", "test_value", ttl=60)
    connector.set("test_key1", "t1", ttl=60)
    connector.set("test_key2", "t2", ttl=60)


    # Redisから値を取得
    value = connector.get("test_key")
    print(f"Retrieved value: {value}")

    # Redisから値を取得
    value = connector.get("test_none")
    print(f"Retrieved value: {value}")
    # すべてのキーを取得
    keys = connector.get_all_keys()
    print(f"All keys: {keys}")

if __name__ == "__main__":
    main()
