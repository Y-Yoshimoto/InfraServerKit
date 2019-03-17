#!/bin/sh
# イメージ確認
docker images | grep redis
# タグ付け
docker tag redis kube1:30500/datastore/redis

# ベースイメージ削除
docker rmi redis
# イメージプッシュ
docker push kube1:30500/datastore/redis
# レポジトリ表示
curl kube1:30500/v2/_catalog
