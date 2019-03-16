#!/bin/sh
# Mount Gluster volume
# Run All node
yum --enablerepo=centos-gluster5 -y install glusterfs glusterfs-fuse
gluster volume info
gluster volume status

mkdir -p /home/test/GFS_vol
chown test /home/test/GFS_vol
chmod 755 /home/test/GFS_vol
mount -t glusterfs localhost:/vol_replica /home/test/GFS_vol

cp -p /etc/fstab /etc/fstab.bk1
echo "localhost:/vol_replica /home/test/GFS_vol            glusterfs    noauto,x-systemd.automount,x-systemd.device-timeout=30,_netdev        0 0" >> /etc/fstab
