#!/bin/bash
## curl -OL http://$ksweb/opt/setNISClient.sh
echo "Start Setup setNISClient"

sleep 3s
source ~/.bashrc
source /root/ks-env.sh
nisMaster="cs8v4"

## NIS Client
dnf -y install ypbind rpcbind oddjob-mkhomedir
ypdomainname $domain
echo "NISDOMAIN=$domain" >> /etc/sysconfig/network

## ADd MasterNode
echo  "domain $domain server $nisMaster.$domain" >> /etc/yp.conf

## NIS Join
authselect select nis --force
#authselect enable-feature with-mkhomedir

systemctl enable --now rpcbind ypbind nis-domainname oddjobd


## NFS Client
dnf -y install nfs-utils
sed -i -e "s/#Domain/Domain=/$domain" /etc/idmapd.conf

## Mount
mount -t nfs $nisMaster.$domain:/home /home
df -hT

## AutoFS
dnf -y install autofs

echo -e  "/-    /etc/autohome.mount" >> /etc/auto.master
echo -e  "/home   -fstype=nfs,rw  $nisMaster.$domain:/home" >> /etc/autohome.mount
systemctl enable --now autofs
ls /home
df -h

# samba-client
dnf -y install samba-client cifs-utils

echo "END"