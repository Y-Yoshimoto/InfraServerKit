# プライベート認証局

## easy-rsa

[公式リポジトリ](https://github.com/OpenVPN/easy-rsa)
[使用方法](https://github.com/OpenVPN/easy-rsa/blob/master/doc/EasyRSA-Readme.md)
[オプション](https://github.com/OpenVPN/easy-rsa/blob/master/doc/EasyRSA-Advanced.md)

## サーバ証明書作成

### 証明書署名要求生成

```bash
# 秘密鍵の生成
openssl genrsa -out webserver.key
# 証明書署名要求の生成
openssl req -new -key ./webserver.key -out ./webserver.csr -subj "/CN=example.com"
# 証明書署名要求の内容確認
openssl req -in webserver.csr -noout -text
```

パスワード付き/標準暗号化

```bash
openssl genrsa -des3 -out ./webserver.key 2048
openssl req -new -key ./webserver.key -out ./webserver.csr -subj "/CN=example.com"
openssl req -in webserver.csr -noout -text
```

### easy-rsaを使用して証明書署名要求を生成

```bash
easyrsa gen-req webserver nopass
```

#### 秘密鍵のパスワード解除

```bash
openssl rsa -in ./webserver.key -out ./webserver_nopass.key
```

### 署名

```bash
docker cp webserver.csr caserver-caserver-1:/opt/cadir/work
./easyrsa import-req ./work/webserver.csr webserver
./easyrsa sign-req server webserver
cp /opt/ca/pki/issued/webserver.crt ./
```

### ルート証明書

cp /opt/ca/pki/ca.crt ./

## 参考記事

<https://developers.gmo.jp/14928/>
<https://smile-jsp.hateblo.jp/entry/2021/03/14/115626>
<https://qiita.com/hoto17296/items/bd76b9dd148a3a1e054c>
<https://jp.globalsign.com/support/ssl/manual-csr/nginx.html>
