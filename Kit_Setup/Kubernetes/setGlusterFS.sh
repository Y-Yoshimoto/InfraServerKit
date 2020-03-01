#!/bin/bash
## https://kubernetes.io/docs/concepts/storage/storage-classes/

## Serverlist
Serverlist=(`cat /etc/Serverlist.conf|xargs`)

## Setup
for node in "${Serverlist[@]}"
do
          echo "####### $node Setup GlusterFS #######"
          gluster peer probe $node
         ssh $node 'mkdir -p /gfs/KubeVolume'
done
  gluster peer status

### makeVolume
echo 'gluster volume create KubeVolume replica 2 \' > makeGSVolume.sh
for node in "${Serverlist[@]}"
do
         echo $node':/gfs/KubeVolume \' >> makeGSVolume.sh
done
echo "force" >> makeGSVolume.sh
cat makeGSVolume.sh && chmod 755 makeGSVolume.sh && ./makeGSVolume.sh

gluster volume start KubeVolume
gluster volume info
gluster volume status

for node in "${Serverlist[@]}"
do
        echo "####### $node Mount GlusterFS #######"
        ssh $node 'mkdir -p /data'
        ssh $node 'cp -p /etc/fstab /etc/fstab.org'
        ssh $node 'mount -t glusterfs localhost:/KubeVolume /data'
        ssh $node 'echo "localhost:/KubeVolume /data  glusterfs    noauto,x-systemd.automount,x-systemd.device-timeout=30,_netdev,exec 0 0" >> /etc/fstab'
        ssh $node 'mount -a'
        ssh $node 'hostname >> /data/hostname.txt'
done