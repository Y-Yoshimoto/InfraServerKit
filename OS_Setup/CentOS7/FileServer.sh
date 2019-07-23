#!/bin/bash

# Setup_Sambad
yum install -y samba samba-client
cp -bp /etc/samba/smb.conf.example /etc/samba/smb.conf
sed -i -e "63i unix charset = UTF-8" /etc/samba/smb.conf
sed -i -e "64i dos charset = CP932" /etc/samba/smb.conf
sed -i -e "86c workgroup = WORKGROUP" /etc/samba/smb.conf
#### Insert Your IP Segment
sed -i -e "92c hosts allow = 127. 192.168.1." /etc/samba/smb.conf
sed -i -e "145c map to guest = Bad User" /etc/samba/smb.conf

systemctl start smb nmb
systemctl enable smb nmb
systemctl status smb nmb
# smbpasswd -a test

# SetUp_NFS
yum install -y nfs-utils
cp /etc/idmapd.conf /etc/idmapd.conf.org
#### Edit Your exports
# echo "/home/test 192.168.1.0/24(rw,no_root_squash)" >> /etc/exports
systemctl start rpcbind nfs-server
systemctl enable rpcbind nfs-server

echo 'If you use samba, please execute "smbpasswd -a hoge(Username)".'
echo 'If you use NFS, please edit /etc/exports.'
