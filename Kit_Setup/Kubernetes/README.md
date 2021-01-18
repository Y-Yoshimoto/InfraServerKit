# Kubentesクラスター構築
 CentOS8向けのKubentesクラスター構築資材
 3台構成（マスター1, ワーカー2)で構築
 - 共有ストレージ: GlusterFS /data:/gfs/KubeVolume
 - 

 ### hostname:ip
 + kube0: 192.168.1.150
 + kube1: 192.168.1.151
 + kube2: 192.168.1.152

## OSインストール
OS_Setup/CentOS8配下のキックスタートファイル及び初期構築スクリプトを利用しOSの初期セットアップを実施  
キックスタート時にGlusterFS用のパーティションを追加作成及びswapの無効化 以下の行参考にKS.cfgのパーティション設定箇所を編集
```bash
#logvol swap  --fstype="swap" --recommended --name=swap --vgname=vl_cs8 --label="swap"
logvol /  --fstype="xfs" --size=20480 --name=root --vgname=vl_cs8 --label="root"
logvol /gfs  --fstype="xfs" --size=4096 --grow --name=gfs --vgname=vl_cs8 --label="gfs"
```

## クラスター間のssh認証鍵登録
`keyexchange.sh`内のサーバーリストを編集する。  
マスターノードで`keyexchange.sh`を実行し、生成した公開鍵と秘密鍵をクラスター内で交換し共有する。  
合わせていくつかのファイルを共有する。  
**スクリプ実行時に各サーバのパスワードを入力すること**

## GlusterFSセットアップ
Glustarfsで共有ディレクトリを作成する。
各ノードで'addGSK8s.sh'実行後に作業を行うこと  
`setupGlusterFS.sh`をマスターノードで実行する。  
fstab動作確認のため再起動を推奨 
