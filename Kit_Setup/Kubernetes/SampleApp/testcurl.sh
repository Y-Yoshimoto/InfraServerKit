#/bin/bash
# cho "root"
# curl -X GET -L "http://127.0.0.1:${PORT}/"
# APIテストスクリプト
# defaultポートは8000, k8s環境では31800を指定
PORT=${1:-8000} 
echo "Testing API on port ${PORT}"

# ホスト情報の取得
# ホスト名取得
echo "\nホスト名取得:"
curl -X GET -L "http://127.0.0.1:${PORT}/hostname"
echo "\nIPアドレス取得:\n"
curl -X GET -L "http://127.0.0.1:${PORT}/hostip"

echo "\n\nデータベース操作型APIのテスト:"
# データベース操作型APIのテスト
echo "全データ取得:"
curl -X GET -L "http://127.0.0.1:${PORT}/psql/data"
echo "\n特定データ取得:"
curl -X GET -L "http://127.0.0.1:${PORT}/psql/data/1"
echo "\nデータ件数取得:"
curl -X GET -L "http://127.0.0.1:${PORT}/psql/data/count"
echo "\n存在しないデータ取得:"
curl -X GET -L "http://127.0.0.1:${PORT}/psql/data/999"
echo "\nデータ挿入:"
curl -X POST -H "Content-Type: application/json" \
    -d '{"message": "test"}' \
    -L "http://127.0.0.1:${PORT}/psql/data"
echo "\nデータ削除:"
curl -X DELETE -L "http://127.0.0.1:${PORT}/psql/data/clear"
echo "\nデータ件数取得:"
curl -X GET -L "http://127.0.0.1:${PORT}/psql/data/count"

# Redis操作型APIのテスト
echo "\n\nRedis操作型APIのテスト:"
echo "Redis全データ取得:"
curl -X GET -L "http://127.0.0.1:${PORT}/redis/keys"
echo "\nRedisデータ挿入1:"
curl -X POST -H "Content-Type: application/json" \
    -d '{"key": "test_key1", "value": "test_value1", "ttl": 30}' \
    -L "http://127.0.0.1:${PORT}/redis/set"
echo "\nRedisデータ挿入2:"
curl -X POST -H "Content-Type: application/json" \
    -d '{"key": "test_key2", "value": "test_value2", "ttl": 30}' \
    -L "http://127.0.0.1:${PORT}/redis/set"
echo "\nRedis特定データ取得1:"
curl -X GET -L "http://127.0.0.1:${PORT}/redis/get?key=test_key1"
echo "\nRedis特定データ取得2:"
curl -X GET -L "http://127.0.0.1:${PORT}/redis/get?key=test_key2"
echo "\nRedis全データ件数:"
curl -X GET -L "http://127.0.0.1:${PORT}/redis/keys/count"
