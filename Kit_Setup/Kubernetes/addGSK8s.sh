#!/bin/sh
# Inatall GlusterFS
# Run Allnode
# wget https://download.gluster.org/pub/gluster/glusterfs/6/LATEST/CentOS/glusterfs-rhel8.repo -P /etc/yum.repos.d/
curl -kL https://download.gluster.org/pub/gluster/glusterfs/6/LATEST/CentOS/glusterfs-rhel8.repo -o /etc/yum.repos.d/glusterfs-rhel8.repo
dnf --enablerepo=PowerTools -y install glusterfs-server
systemctl enable --now glusterd
systemctl status glusterd
gluster --version