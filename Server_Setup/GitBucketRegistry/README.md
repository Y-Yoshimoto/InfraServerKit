# GitBucket+Registry

## 初期パスワード
root:root

## 参考リンク
 - [Github](https://github.com/gitbucket)
 - [DockerHub](https://hub.docker.com/r/gitbucket/gitbucket/)

### レジストリ登録
ubuntuのコンテナをローカルリポジトリに登録する
```bash
docker pull ubuntu
docker tag ubuntu localhost:5000/ubuntu
docker push localhost:5000/ubuntu
```
