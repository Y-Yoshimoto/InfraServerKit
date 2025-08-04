#/bin/bash
# cho "root"
#/bin/bash
# cho "root"
# curl -X GET -L "http://127.0.0.1:${PORT}/"
# APIテストスクリプト
# defaultポートは8000, k8s環境では31800を指定
PORT=${1:-8000} 
echo "Testing API on port ${PORT}"

# ホスト情報の取得
# ホスト名取得
n=${2:-10}
for i in $(seq 1 $n)
do
    echo "\nRedisデータ挿入($i):"
    curl -X POST -H "Content-Type: application/json" \
    -d '{"key": "test_key('$i')", "value": "('$i')", "ttl": 2}' \
    -L "http://127.0.0.1:${PORT}/redis/set"
done
echo "--------------------------------------------"

echo "Redis全データ取得:"
curl -X GET -L "http://127.0.0.1:${PORT}/redis/keys"
echo "\nRedis全データ取得:"
curl -X GET -L "http://127.0.0.1:${PORT}/redis/keys"
echo "\nRedis全データ取得:"
curl -X GET -L "http://127.0.0.1:${PORT}/redis/keys"
echo "\nRedis全データ件数:"
curl -X GET -L "http://127.0.0.1:${PORT}/redis/keys/count"
echo "\nRedis全データ件数:"
curl -X GET -L "http://127.0.0.1:${PORT}/redis/keys/count"
echo "\nRedis全データ件数:"
curl -X GET -L "http://127.0.0.1:${PORT}/redis/keys/count"