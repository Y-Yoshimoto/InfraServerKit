#!/bin/sh
# イメージ確認
docker images | grep k8s_sample_
# タグ付け
docker tag k8s_sample_postgres_c 127.0.0.1:32000/datastore/k8s_sample_postgres_c
docker tag k8s_sample_fastapi_c 127.0.0.1:32000/datastore/k8s_sample_fastapi_c
docker tag k8s_sample_redis_c 127.0.0.1:32000/datastore/k8s_sample_redis_c


# ベースイメージ削除
docker rmi k8s_sample_redis_c
docker rmi k8s_sample_fastapi_c
docker rmi k8s_sample_postgres_c
# イメージプッシュ
docker push 127.0.0.1:32000/datastore/k8s_sample_redis_c
docker push 127.0.0.1:32000/datastore/k8s_sample_fastapi_c
docker push 127.0.0.1:32000/datastore/k8s_sample_postgres_c
# レポジトリ表示
curl 127.0.0.1:32000/v2/_catalog
