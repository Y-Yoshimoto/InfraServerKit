#!/bin/bash
# サーバー証明書生成スクリプト

# 引数チェック
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <COMMON_NAME> <CERTIFICATE_NAME>"
    echo "Example: $0 127.0.0.1:443 server"
    exit 1
fi

# 引数割り当て
COMMON_NAME=${1-'127.0.0.1:443'}
CERTIFICATE_NAME=${2-'server'}
# 作業ディレクトリ/収納先ディレクトリ作成
WORK_DIR='/opt/cadir/work'
COLL_DIR="${WORK_DIR}/${CERTIFICATE_NAME}"
mkdir -p ${COLL_DIR}

# 証明書ファイル名/パス
CSR="${COLL_DIR}/${CERTIFICATE_NAME}.csr"
CRT="${COLL_DIR}/${CERTIFICATE_NAME}.crt"
TMP_CRT="/opt/cadir/pki/issued/${CERTIFICATE_NAME}.crt"
KEY="${COLL_DIR}/${CERTIFICATE_NAME}.key"
# CA証明書ファイル名
CA_CRT_ORG="/opt/cadir/pki/ca.crt"
CA_CRT="${COLL_DIR}/caroot.crt"
# pem形式変換後の証明書ファイル名
CRT_PEM="${COLL_DIR}/${CERTIFICATE_NAME}.pem"
CA_CRT_PEM="${COLL_DIR}/caroot.pem"
# 証明書情報ファイル
CERTIFICATE_INFO="${COLL_DIR}/${CERTIFICATE_NAME}.info"
# ZIPファイル名
ZIP_FILE="${COLL_DIR}.zip"

# 秘密鍵と署名要求生成
openssl genrsa -out ${KEY} 4096
openssl req -new -key ${KEY} -out ${CSR} -subj "/CN=${COMMON_NAME}"
# openssl req -new -key ${KEY} -out ${CSR} -subj "/CN=${COMMON_NAME}" -passin pass:${PASSWORD}

# 署名要求をCAで署名
easyrsa import-req ${CSR} ${CERTIFICATE_NAME}
easyrsa --batch sign-req server ${CERTIFICATE_NAME}
# 署名された証明書をコピー
cp -f ${TMP_CRT} ${CRT}
# CA証明書をコピー
cp -f ${CA_CRT_ORG} ${CA_CRT}

# pem形式変換
openssl x509 -in ${CRT} -out ${CRT_PEM} -outform PEM
openssl x509 -in ${CA_CRT} -out ${CA_CRT_PEM} -outform PEM

# 証明書の確認
echo "CERTIFICATE_NAME: ${CERTIFICATE_NAME}" > ${CERTIFICATE_INFO}
echo "COMMON_NAME: ${COMMON_NAME}" >> ${CERTIFICATE_INFO}
echo "========================" >> ${CERTIFICATE_INFO}
echo "=== ${CERTIFICATE_NAME}.crt ===" >> ${CERTIFICATE_INFO}
openssl x509 -in ${CRT} -text -noout >> ${CERTIFICATE_INFO}
echo "=== caroot.csr ===" >> ${CERTIFICATE_INFO}
openssl x509 -in ${CA_CRT} -text -noout >> ${CERTIFICATE_INFO}
echo "=== ${CERTIFICATE_NAME}.csr ===" >> ${CERTIFICATE_INFO}
openssl req -in ${CSR} -text -noout >> ${CERTIFICATE_INFO}
echo "=== ${CERTIFICATE_NAME}.key ===" >> ${CERTIFICATE_INFO}
openssl rsa -in ${KEY} -text -noout >> ${CERTIFICATE_INFO}
echo "========================" >> ${CERTIFICATE_INFO}

# zipファイルの作成/移動
zip -r ${COLL_DIR}.zip ${COLL_DIR}/*
mv ${COLL_DIR}.zip ${COLL_DIR}
