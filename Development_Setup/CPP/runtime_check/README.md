# 開発環境動作確認用

## ビルド/実行方法
### cmakeを順番に実行する
```bash
# configure
cmake -B build -S .
# generate
cmake --build build
# run
./build/main.out
```
### 一括実行
設定/実行/クリーンアップを一括で実行する
```bash
cmake -B build -S . \
&& cmake --build build --target run \
&& rm -rf build
```

### その他
```bash
# clean
cmake --build build --target clean
```

## ユニットテスト
### GoogleTestを使用
設定/テスト/クリーンアップを一括で実行する
```bash
cmake -B build -S . \
&& cmake --build build --target run \
&& rm -rf build


## 参考ドキュメント
- [GitHubページ](https://github.com/google/googletest?tab=readme-ov-file)
- [GoogleTestのドキュメント](https://google.github.io/googletest/)
- [cmakeのドキュメント](https://cmake.org/cmake/help/latest/)
- [cmakeのgoogletestドキュメント](https://cmake.org/cmake/help/git-stage/module/GoogleTest.html)