# Linux キックインストール用ツール

## Distributor
    KSファイル, 構築用スクリプト配布用Webサーバ
    セットアップ素材を"web_container/contents/"配下に設置し、コンテナを起動
    
    "smb://127.0.0.1:8445/Distributor" に対して接続する

### セットアップ資材のコピー
cp ../../OS_Setup/CentOS8/* ./Distributor/web_container/contents/

## ISOmaker
    ISOファイルの再生成用