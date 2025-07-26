#!/bin/bash
# 引数チェック
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <COMMON_NAME> <CERTIFICATE_NAME>"
    echo "Example: $0 127.0.0.1:443 server"
    echo "Running with default values."

fi
# 引数割り当て
COMMON_NAME=${1-'127.0.0.1:443'}
CERTIFICATE_NAME=${2-'server'}

# コンテナビルド
docker compose build
# 証明書生成
docker compose run caserver /bin/bash Create-ServerCertificate.sh ${COMMON_NAME} ${CERTIFICATE_NAME}
