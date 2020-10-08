# Linux キックインストール用ツール

## Distributor
    KSファイル, 構築用スクリプト配布用Webサーバ
    セットアップ素材を"web_container/contents/"配下に設置し、コンテナを起動
    
    "smb://127.0.0.1:8445/Distributor" に対して接続する

### セットアップ資材のコピー
cp ../../OS_Setup/CentOS8/* ./Distributor/web_container/contents/

## ISOmaker
    ISOファイルの再生成用

# DHCP利用のKS-Distributor
キックスタート及び初期設定用の素材配布用コンポーネント

## セットアップ
`make init`の実行または、以下の手順でwebコンテナ及び、DHCPサーバをセットアップする。  

## Webコンテナセットアップ
キックスタート用ファイル及び構築資材配布用のwebコンテナを起動する。
1. docker,docker-composeが利用できる環境を準備
2. `docker-compose up -d`でwebコンテナを起動

## DHCPセットアップ 
OSインストール時点で仮のIPアドレスを割り当てるため、DHCPサーバを起動する。
1. `dnf install -y dnsmasq`でdnsmasqをインストール
2. `cp ./dnsmasq.conf /etc/dnsmasq.conf`で設定ファイル設置  
配布するIPアドレスレンジを及びデフォルトゲートウェイ,DNS等は環境に合わせること  
3. `systemctl enable --now dnsmasq` で起動及び有効か


## キックインストールファイルについて
- ホスト名およびIPアドレスのについて修正  
- UEFI,BIOSに合わせてパーティションの設定を修正
- proxyの有無に合わせて 利用するファイルを選ぶこと  
－[RedHatドキュメント](https://access.redhat.com/documentation/ja-jp/red_hat_enterprise_linux/8/html/performing_an_advanced_rhel_installation/index)を確認すること

## キックインストール用の割り込み
### UEFIブートの場合
**Install CentOS 8 .....** という感じの表示にカーソルを合わせて**tab**キーを入力する。  
インストールのコマンドが表示されたら、**qyiet**の後に半角スペースを開けて  
`ks=http://10.1.250.10/ks.cfg`と入力し、**Ctrl + x**でインストールを開始する。  
  USキーボード配列となっているため、記号の入力に注意すること 

### BIOSブートの場合
tabキーの代わりに**eキー**を入力しインストールに介入する

## 初期セットアップスクリプトについて
crontabを利用し、インストール完了後の初回起動時に`setPOST.sh`が実行される。  
スクリプト完了後は、自動的に再起動が行われ続いて`setDocker.sh`が実行され自動再起動が行われる。  

## Windows用 zabbixエージェントの配布について
Powershell上で下記の3コマンドを実行する。  
PSスクリプト実行の有効化及び、セットアップスクリプトのダウンロード及びインストールを行う。
```ps1
Set-ExecutionPolicy RemoteSigned
Invoke-WebRequest -Uri http://10.1.250.10/win/ZabbixAgent_Windows.ps1 -OutFile ./ZabbixAgent_Windows.ps1
./ZabbixAgent_Windows.ps1
```
