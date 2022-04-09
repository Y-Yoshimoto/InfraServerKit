#!/bin/bash
## isoファイル名指定
orgisoname="ubuntu-20.04.3-live-server-amd64.iso"
autoisoname="ubuntu-20.04.3-autoinstall-amd64.iso"
## isoファイルダウンロード
#wget https://releases.ubuntu.com/20.04/$orgisoname
## isoファイル展開
mkdir -p /mnt/iso
xorriso -osirrox on -indev $orgisoname -extract / /mnt/iso
## 権限調整
chmod 755 /mnt/iso/
chmod 755 /mnt/iso/isolinux/
## コンフィグファイル入れ替え
cp ./BaseIsoConfig/grub.cfg /mnt/iso/boot/grub/grub.cfg
cp ./BaseIsoConfig/txt.cfg /isolinux/txt.cfg