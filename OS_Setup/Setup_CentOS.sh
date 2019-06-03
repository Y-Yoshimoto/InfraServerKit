#!/bin/bash

# Setting Environment Variable in this Script
newHostname=CentOS7KS
localNetWork=192.168.1.0
# Set Hostname
echo $newHostname
nmcli general hostname $newHostname

# Yum update
yum update -y

# Setup_Standard
systemctl disable firewalld
systemctl stop firewalld
cp -p /etc/selinux/config /etc/selinux/config.org
sed -i -e "s/enforcing/disabled/" /etc/selinux/config

# Setup_tool
## vim
yum install vim -y
cp -p /etc/vimrc /etc/vimrc.bak
echo -e "set number\ncolorscheme desert" >>/etc/vimrc
## Choose your favorite colorscheme.

## git
yum install git -y

## Zabbix Agent
## "Choose from https://www.zabbix.com/jp/download"
rpm -Uvh https://repo.zabbix.com/zabbix/4.2/rhel/7/x86_64/zabbix-release-4.2-1.el7.noarch.rpm
yum clean all
yum -y install zabbix-agent
cp -p /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.csrsonf.bak
sed -i -e "s/Server=127.0.0.1/Server=127.0.0.1,192.168.1.0\/24/" /etc/zabbix/zabbix_agentd.conf
sed -i -e "s/ServerActive=127.0.0.1/Server=127.0.0.1,192.168.1.0\/24/" /etc/zabbix/zabbix_agentd.conf
sed -i -e "s/Hostname=Zabbix server/Hostname=$newHostname/" /etc/zabbix/zabbix_agentd.conf
systemctl enable zabbix-agent.service
systemctl restart zabbix-agent.service
systemctl status zabbix-agent.service | grep Active

# Setup_Docker
yum install docker -y
groupadd docker
gpasswd -a test docker
curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
systemctl enable docker
systemctl restart docker
systemctl status docker | grep Active

# Setup_Sambad
#yum install -y samba samba-client
#cp /etc/samba/smb.conf.example /etc/samba/smb.conf
#sed -i -e "63i unix charset = UTF-8" /etc/samba/smb.conf
#sed -i -e "64i dos charset = CP932" /etc/samba/smb.conf
#sed -i -e "86c workgroup = WORKGROUP" /etc/samba/smb.conf
#sed -i -e "92c hosts allow = 127. 192.168.1." /etc/samba/smb.conf
#sed -i -e "145c map to guest = Bad User" /etc/samba/smb.conf

#systemctl start smb nmb
#systemctl enable smb nmb
#systemctl status smb nmb | grep Active
## smbpasswd -a test

# SetUp_NFS
# yum install -y nfs-utils
# cp /etc/idmapd.conf /etc/idmapd.conf.org
# echo "/home/test 192.168.1.0/24(rw,no_root_squash)" >> /etc/exports
# systemctl start rpcbind nfs-server
# systemctl enable rpcbind nfs-server
