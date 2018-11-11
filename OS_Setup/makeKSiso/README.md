## isoファイルを展開する
CentOSのisoファイルをダウンロードし、
以下のコマンドで展開及びコピーを行う。
```bash
mkdir CentOS7_yymm
mount CentOS-7-x86_64-Minimal-yymm.iso ./CentOS7_yymm/
mkdir CentOS7_yyxx_edit
cp -rp CentOS7_yyxx/* CentOS7_yymm_edit/
```
## 起動の設定を変更する
``cd CentOS7_yymm_edit/``とコピーしたディレクトリへ移動して作業を続ける
インストール設定用のファイルを編集する
``vi isolinux/isolinux.cfg``
以下のラベルを追加し、
```bash
label centos7ks
  menu label ^Install CentOS7 use KS
  menu default
  kernel vmlinuz
  # append initrd=initrd.img nst.ks=cdrom:/ks/ks.cfg
  append initrd=initrd.img inst.stage2=hd:LABEL=CentOS\x207\x20x86_64 inst.ks=cdrom:/ks/ks.cfg
```

"label check"のラベルから"menu default"を削除する

## ksファイル, postファイルを設置する
``mkdir ks``でファイルを作りその中に``ks.cfg``, ``post.sh``を設置する
``ksvalidator ks.cfg``で構文をチェックする

以下のコマンドでisoファイルを作成する。
```bash
mkisofs \
    -o ../CentOS-7-x86_64-Minimal-1804_KS.iso \
    -b isolinux/isolinux.bin -c isolinux/boot.cat \
    -no-emul-boot -boot-load-size 4 -boot-info-table -R -J -v -T \
    -V "CentOS 7 x86_64" ./
```
mkisofs
-v -r -J -o ../CentOS-7-x86_64-Kickstart-1503-01.iso
-b isolinux/isolinux.bin -c isolinux/boot.cat
-no-emul-boot -boot-load-size 4 -boot-info-table .
