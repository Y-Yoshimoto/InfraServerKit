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
    echo "\nPostgreSQLデータ挿入($i):"
    curl -X POST -H "Content-Type: application/json" \
    -d '{"message": "Data: '$i'"}' \
    -L "http://127.0.0.1:${PORT}/psql/data"
done
echo "--------------------------------------------"

echo "\nデータ件数取得:"
curl -X GET -L "http://127.0.0.1:${PORT}/psql/data/count"
echo "\nデータ件数取得:"
curl -X GET -L "http://127.0.0.1:${PORT}/psql/data/count"
echo "\nデータ件数取得:"
curl -X GET -L "http://127.0.0.1:${PORT}/psql/data/count"
echo "\nデータ削除:"
curl -X DELETE -L "http://127.0.0.1:${PORT}/psql/data/clear"