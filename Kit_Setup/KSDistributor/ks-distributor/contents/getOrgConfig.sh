#!/bin/bash
## curl -OL http://192.168.137.47/getConfig.sh 
echo "Get Configs" 
mkdir orgConfig
mkdir orgConfig/yum.repos.d/

# インストール情報
cp -p anaconda-ks.cfg ./orgConfig/

# ネットワーク
cp -p /etc/sysconfig/network-scripts/ifcfg-eth0 ./orgConfig/

# DNS設定
cp -p /etc/resolv.conf ./orgConfig/

# ルーティング設定
ip r > ./orgConfig/route.cfg

# ホストファイル
cp -p /etc/hosts ./orgConfig/

# ネームサービススイッチ
cp -p /etc/nsswitch.conf ./orgConfig/

# NTP(Chrony)
cp -p /etc/chrony.conf ./orgConfig/

# SELINUX
cp -p /etc/sysconfig/selinux ./orgConfig/

# kdump
cp -p /etc/kdump.conf ./orgConfig/

# dnfレポジトリ
cp -rp /etc/yum.repos.d/* ./orgConfig/yum.repos.d/

# ログローテーション
cp -rp /etc/logrotate.conf ./orgConfig/

# Crontab
cp -p /etc/crontab ./orgConfig/

# SSH
cp -p /etc/ssh/sshd_config ./orgConfig/

# Aliases
cp -p /etc/aliases ./orgConfig/

# fstab
cp -p /etc/fstab ./orgConfig/
