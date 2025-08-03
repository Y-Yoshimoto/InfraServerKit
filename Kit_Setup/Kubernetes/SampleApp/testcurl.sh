#/bin/bash
# cho "root"
# curl -X GET -L 'http://127.0.0.1:8000/'
echo "All get\n"
curl -X GET -L 'http://127.0.0.1:8000/psql/data'
echo "get 200 \n"
curl -X GET -L 'http://127.0.0.1:8000/psql/data/1'
echo "get 404 \n"
curl -X GET -L 'http://127.0.0.1:8000/psql/data/999'