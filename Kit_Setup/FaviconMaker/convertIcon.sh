#!/bin/ash
echo "Convert png / jpeg to icon"
# 引数の数を確認
if [ $# -ne 1 ]; then
    echo "usage: convertIcon.sh hoge.png" 1>&2
    exit 1
fi
# ファイルの存在確認
if [ ! -e /tmp/$1 ]; then
    echo "File not exists."
    exit 1
fi
# 画像ファイルの変数割り当て
ORIGINAL_IMAGE=$1
mkdir -p /tmp/output/
# 画像をアイコンに変換
magick /tmp/${ORIGINAL_IMAGE} -size 1024x1024 /tmp/output/icon.png
magick /tmp/${ORIGINAL_IMAGE} -size 1024x1024 /tmp/output/icon.jpg
magick /tmp/${ORIGINAL_IMAGE} -define icon:auto-resize=16,32,48,64,128,256 /tmp/output/favicon.ico
magick /tmp/${ORIGINAL_IMAGE} /tmp/output/icon.svg
# アイコンの確認
echo "Icon created successfully."
identify /tmp/output/favicon.ico