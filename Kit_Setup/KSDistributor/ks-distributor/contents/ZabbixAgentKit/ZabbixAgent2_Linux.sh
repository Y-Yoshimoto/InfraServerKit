#!/bin/bash

## Zabbix Agent
## "Choose from https://www.zabbix.com/jp/download"
source ~/.bashrc
source /root/ks-env.sh

hostN=`hostname`


rpm -Uvh https://repo.zabbix.com/zabbix/5.0/rhel/8/x86_64/zabbix-release-5.0-1.el8.noarch.rpm
dnf clean all
dnf -y install zabbix-agent2
cp -bp /etc/zabbix/zabbix_agent2.conf /etc/zabbix/zabbix_agent2.conf.org
sed -i -e "s/Server=127.0.0.1/Server=127.0.0.1,$Zabbix\/24/" /etc/zabbix/zabbix_agent2.conf
######### ServerActive=xxx.xxx.xxx.xxx ######### Set Your ZabbixServer "/32"
sed -i -e "s/ServerActive=127.0.0.1/Server=$Zabbix" /etc/zabbix/zabbix_agent2.conf
sed -i -e "s/Hostname=Zabbix server/Hostname=$hostN/" /etc/zabbix/zabbix_agent2.conf
systemctl enable --now zabbix-agent2.service
systemctl status zabbix-agent2.service
dnf clean all