#!/bin/bash
## curl -OL http://$ksweb/opt/setNISMaster.sh
echo "Start Setup setNISMaster"

sleep 3s
source ~/.bashrc
source /root/ks-env.sh

## NIS Master ##############################
dnf -y install ypserv rpcbind
ypdomainname $domain
echo "NISDOMAIN=$domain" >> /etc/sysconfig/network

## Access Subnet
echo -e "255.0.0.0       127.0.0.0" >> /var/yp/securenets
echo -e "255.255.255.0       192.168.1.0" >> /var/yp/securenets
echo -e "255.0.0.0       10.0.0.0" >> /var/yp/securenets

### /etc/hosts
#hostN=`hostname`

## Start NIS
systemctl enable --now rpcbind ypserv ypxfrd yppasswdd nis-domainname
/usr/lib64/yp/ypinit -m

cd /var/yp
make

# NFS Master ##############################
dnf -y install nfs-utils
cp -p /etc/idmapd.conf /etc/idmapd.conf.org
sed -i -e "s/#Domain/Domain/" /etc/idmapd.conf
sed -i -e "s/local.domain.edu/$domain/" /etc/idmapd.conf

## Edit Export
cp -p /etc/exports /etc/exports.org
echo -e "/home/ 192.168.1.0/24(rw,no_root_squash)" >> /etc/exports
echo -e "/home/ 10.0.0.0/8(rw,no_root_squash)" >> /etc/exports

## Start NFS
systemctl enable --now rpcbind nfs-server


# Samba ##############################
dnf install -y samba
cp -p /etc/samba/smb.conf /etc/samba/smb.conf.org

sed -i -e "s/SAMBA/$domain/" /etc/samba/smb.conf
sed -i -e '9i\        unix charset = UTF-8' /etc/samba/smb.conf
sed -i -e '10i\        dos charset = CP932' /etc/samba/smb.conf
sed -i -e '11i\        hosts allow = 127. 10.0.0. 192.168.1.' /etc/samba/smb.conf

systemctl enable --now smb

echo "END"