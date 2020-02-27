#!/bin/sh
# Setup Volume
# Run Master Node
## https://sites.google.com/site/glusterfstech/volumes/create
## https://reboot.makeall.net/2013/06/14/glusterfs-usable-volume-option/
gluster peer probe kube2
gluster peer probe kube3
gluster peer status
gluster volume create KubeVolume replica 3 \
kube1:/gfs/KubeVolume \
kube2:/gfs/KubeVolume \
kube3:/gfs/KubeVolume \
force

gluster volume start vol_replica
gluster volume info
gluster volume status

mkdir -p /home/test/GFS_vol
mount -t glusterfs localhost:/vol_replica /home/test/GFS_vol

# delete
# gluster volume delete vol_replica
# detach
# gluster peer detach "node
