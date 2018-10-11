#!/bin/bash
yum update -y

# Setup_Standard
systemctl disable firewalld
systemctl stop firewalld
cp -p /etc/selinux/config /etc/selinux/config.org
sed -i -e "s/enforcing/disabled/" /etc/selinux/config

# Setup_tool
## git
yum install git -y

## Zabbix Agent
yum -y install http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-1.el7.centos.noarch.rpm
yum -y install zabbix-agent
systemctl enable zabbix-agent.service
systemctl start zabbix-agent.service

# Setup_Docker
yum install docker -y
groupadd docker
gpasswd -a test docker
curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
systemctl enable docker
systemctl restart docker

# Setup_Samba
yum install -y samba samba-client
cp /etc/samba/smb.conf.example /etc/samba/smb.conf
sed -i -e "63i unix charset = UTF-8" /etc/samba/smb.conf
sed -i -e "64i dos charset = CP932" /etc/samba/smb.conf
sed -i -e "86c workgroup = WORKGROUP" /etc/samba/smb.conf
sed -i -e "92c hosts allow = 127. 192.168.1." /etc/samba/smb.conf
sed -i -e "145c map to guest = Bad User" /etc/samba/smb.conf

systemctl start smb nmb
systemctl enable smb nmb
## smbpasswd -a test

# SetUp_NFS
yum install -y nfs-utils
cp /etc/idmapd.conf /etc/idmapd.conf.org
echo "/home/test 192.168.122.0/24(rw,no_root_squash)" >> /etc/exports
systemctl start rpcbind nfs-server
systemctl enable rpcbind nfs-server

### クライアント






# Setup_DropBox (使用するユーザで実行)

# cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
# .dropbox-dist/dropboxd
# cd .dropbox
# wget -O dropbox.py https://www.dropbox.com/download?dl=packages/dropbox.py

# vim /etc/systemd/system/dropbox.service
#  以下を追記
<< COMMENTOUT
[Unit]
Description=Dropbox Daemon
[Service]
ExecStart=/usr/bin/python /home/test/.dropbox/dropbox.py start
ExecStop=/usr/bin/python /home/test/.dropbox//dropbox.py stop
Restart=always
Type=forking
User=y-yoshimoto
Group=y-yoshimoto
[Install]
WantedBy=multi-user.target
COMMENTOUT
