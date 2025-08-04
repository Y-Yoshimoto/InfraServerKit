#/bin/bash
# cho "root"
# curl -X GET -L 'http://127.0.0.1:8000/'
echo "全データ取得￥n"
curl -X GET -L 'http://127.0.0.1:8000/psql/data'
echo "特定データ取得\n"
curl -X GET -L 'http://127.0.0.1:8000/psql/data/1'
echo "データ件数取得\n"
curl -X GET -L 'http://127.0.0.1:8000/psql/data/count'
echo "存在しないデータ取得\n"
curl -X GET -L 'http://127.0.0.1:8000/psql/data/999'
echo "データ挿入\n"
curl -X POST -H "Content-Type: application/json" -d '{"message": "test"}' -L 'http://127.0.0.1:8000/psql/data'
echo "データ削除\n"
curl -X DELETE -L 'http://127.0.0.1:8000/psql/data/clear'
echo "データ件数取得\n"
curl -X GET -L 'http://127.0.0.1:8000/psql/data/count'