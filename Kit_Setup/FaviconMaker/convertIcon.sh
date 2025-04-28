#!/bin/ash
echo "Convert png to icon"
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
PNGIMAGE=$1
# 画像をアイコンに変換
magick /tmp/${PNGIMAGE} -define icon:auto-resize=16,32,48,64,128,256 /tmp/favicon.ico
# アイコンの確認
echo "Icon created successfully."
identify /tmp/favicon.ico