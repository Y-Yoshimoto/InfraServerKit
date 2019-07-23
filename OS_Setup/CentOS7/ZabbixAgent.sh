#!/bin/bash

## Zabbix Agent
## "Choose from https://www.zabbix.com/jp/download"
Hostname=hostname
rpm -Uvh https://repo.zabbix.com/zabbix/4.2/rhel/7/x86_64/zabbix-release-4.2-1.el7.noarch.rpm
yum clean all
yum -y install zabbix-agent
cp -bp /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf.org
sed -i -e "s/Server=127.0.0.1/Server=127.0.0.1,192.168.1.0\/24/" /etc/zabbix/zabbix_agentd.conf
######### ServerActive=xxx.xxx.xxx.xxx ######### Set Your ZabbixServer "/32"
sed -i -e "s/ServerActive=127.0.0.1/Server=192.168.1.116/" /etc/zabbix/zabbix_agentd.conf
sed -i -e "s/Hostname=Zabbix server/Hostname=$Hostname/" /etc/zabbix/zabbix_agentd.conf
systemctl enable zabbix-agent.service
systemctl restart zabbix-agent.service
systemctl status zabbix-agent.service
