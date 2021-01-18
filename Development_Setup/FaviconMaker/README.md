# Makefavicon
    jpgファイルからfavicon.iconを作成
# 使用方法
```bash
convertfavicon.sh {元画像}
```
# 変換コマンド   
```bash
docker-compose run --rm faviconmaker icon.png
```
# 内部コマンド
```bash
convert /tmp/icon.png -define icon:auto-resize /tmp/favicon.ico
```