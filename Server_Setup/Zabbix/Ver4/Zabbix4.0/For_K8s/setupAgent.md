# 接続先編集
cp -p /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf.bk
sed -i -e 's/Server=127.0.0.1/Server=kube1/g' /etc/zabbix/zabbix_agentd.conf
sed -i -e "s/ServerActive=127.0.0.1/ServerActive=kube1:30251/g" /etc/zabbix/zabbix_agentd.conf
sed -i -e "s/Hostname=Zabbix server/Hostname=`hostname`/g" /etc/zabbix/zabbix_agentd.conf
cat /etc/zabbix/zabbix_agentd.conf | grep kube
systemctl restart zabbix-agent

cat /etc/zabbix/zabbix_agentd.conf | grep ServerActive
cp -p /etc/zabbix/zabbix_agentd.conf.bk /etc/zabbix/zabbix_agentd.conf
