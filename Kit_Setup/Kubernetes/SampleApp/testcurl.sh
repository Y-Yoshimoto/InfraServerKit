#/bin/bash
# cho "root"
# curl -X GET -L 'http://127.0.0.1:8000/'

# ホスト情報の取得
# ホスト名取得
curl -X GET -L 'http://127.0.0.1:8000/hostname'
# IPアドレス取得
curl -X GET -L 'http://127.0.0.1:8000/hostip'

# データベース操作型APIのテスト
# 全データ取得
curl -X GET -L 'http://127.0.0.1:8000/psql/data'
# 特定データ取得
curl -X GET -L 'http://127.0.0.1:8000/psql/data/1'
# データ件数取得
curl -X GET -L 'http://127.0.0.1:8000/psql/data/count'
# 存在しないデータ取得
curl -X GET -L 'http://127.0.0.1:8000/psql/data/999'
# データ挿入
curl -X POST -H "Content-Type: application/json" \
    -d '{"message": "test"}' \
    -L 'http://127.0.0.1:8000/psql/data'
# データ削除
curl -X DELETE -L 'http://127.0.0.1:8000/psql/data/clear'
# データ件数取得
curl -X GET -L 'http://127.0.0.1:8000/psql/data/count'

# Redis操作型APIのテスト
# Redis全データ取得
curl -X GET -L 'http://127.0.0.1:8000/redis/keys'
# Redisデータ挿入1
curl -X POST -H "Content-Type: application/json" \
    -d '{"key": "test_key1", "value": "test_value1", "ttl": 10}' \
    -L 'http://127.0.0.1:8000/redis/set'
# Redisデータ挿入2
curl -X POST -H "Content-Type: application/json" \
    -d '{"key": "test_key2", "value": "test_value2", "ttl": 10}' \
    -L 'http://127.0.0.1:8000/redis/set'
# Redis特定データ取得1
curl -X GET -L 'http://127.0.0.1:8000/redis/get?key=test_key1'
# Redis特定データ取得2
curl -X GET -L 'http://127.0.0.1:8000/redis/get?key=test_key2'
