#!/bin/bash

# Setting Environment Variable in this Script
newHostname=CentOS7KS
localNetWork=192.168.1.0
GeneralUser=test
# Set Hostname
echo $newHostname
nmcli general hostname $newHostname

# Yum update
yum update -y

# Setup_Standard
systemctl disable firewalld
systemctl stop firewalld
cp -bp /etc/selinux/config /etc/selinux/config.org
sed -i -e "s/enforcing/disabled/" /etc/selinux/config

source /etc/profile

# Setup_tool
## vim
yum install vim -y
cp -bp /etc/vimrc /etc/vimrc.org
echo -e "set number\ncolorscheme desert\nset ts=4" >>/etc/vimrc
cp -bp /etc/profile /etc/profile.org
echo -e "alias vi='vim'" >>/etc/profile
## Choose your favorite colorscheme.

## git
yum install git -y

# Setup_Docker
yum install docker -y
groupadd docker
gpasswd -a $GeneralUser docker
curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
systemctl enable docker
systemctl restart docker
systemctl status docker
