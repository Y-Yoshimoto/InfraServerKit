#!/bin/bash

## Zabbix Agent
## "Choose from https://www.zabbix.com/jp/download"
Hostname=hostname
rpm -Uvh https://repo.zabbix.com/zabbix/4.4/rhel/8/x86_64/zabbix-release-4.4-1.el8.noarch.rpm
dnf clean all
dnf -y install zabbix-agent2
cp -bp /etc/zabbix/zabbix_agent2.conf /etc/zabbix/zabbix_agent2.conf.org
sed -i -e "s/Server=127.0.0.1/Server=127.0.0.1,192.168.1.0\/24/" /etc/zabbix/zabbix_agent2.conf
######### ServerActive=xxx.xxx.xxx.xxx ######### Set Your ZabbixServer "/32"
sed -i -e "s/ServerActive=127.0.0.1/Server=192.168.1.50/" /etc/zabbix/zabbix_agent2.conf
sed -i -e "s/Hostname=Zabbix server/Hostname=$Hostname/" /etc/zabbix/zabbix_agent2.conf
systemctl enable --now zabbix-agent2.service
systemctl status zabbix-agent2.service
dnf clean all