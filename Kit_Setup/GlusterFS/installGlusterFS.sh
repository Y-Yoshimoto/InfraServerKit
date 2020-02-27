#!/bin/sh
# Inatall GlusterFS
# Run Allnode
wget https://download.gluster.org/pub/gluster/glusterfs/6/LATEST/CentOS/glusterfs-rhel8.repo -P /etc/yum.repos.d/
dnf --enablerepo=PowerTools -y install glusterfs-server
systemctl enable --now glusterd
systemctl status glusterd
gluster --version

mkdir -p /gfs/KubeVolume