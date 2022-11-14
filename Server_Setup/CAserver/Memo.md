# プライベート認証局

## easy-rsa

[git-hub](https://github.com/OpenVPN/easy-rsa)

## サーバ証明書作成

### 証明書署名要求生成

```bash
openssl genrsa -out webserver.key
openssl req -new -key server.key -out webserver.req \
  -addext "subjectAltName = IP:192.168.1.10"
openssl req -in webserver.req -noout -text
```

### 署名

cp webserver.req caserver-caserver-1:/tmp
./easyrsa import-req /tmp/webserver.req webserver
./easyrsa sign-req server webserver
cat /opt/ca/pki/issued/webserver.cr

## 参考記事

<https://developers.gmo.jp/14928/>
<https://smile-jsp.hateblo.jp/entry/2021/03/14/115626>
<https://qiita.com/hoto17296/items/bd76b9dd148a3a1e054c>
