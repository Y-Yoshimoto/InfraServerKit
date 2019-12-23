#!/bin/sh
# Setup Volume
# Run Master Node
gluster peer probe kube2
gluster peer probe kube3
gluster peer status
gluster volume create vol_replica replica 3 transport tcp \
kube1:/glusterfs/replica \
kube2:/glusterfs/replica \
kube3:/glusterfs/replica \
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
