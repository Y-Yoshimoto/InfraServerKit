#!/bin/sh
# Inatall GlusterFS
# Run Allnode
yum -y install centos-release-gluster5
echo "yum install"
sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/CentOS-Gluster-5.repo
yum --enablerepo=centos-gluster5 -y install glusterfs-server
systemctl start glusterd
systemctl enable glusterd
systemctl status glusterd
gluster --version

# Making GlusterFS Directory
# Run allnode
mkdir -p /glusterfs/replica
