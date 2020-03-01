#!/bin/sh

## Serverlist
Serverlist=(`cat /etc/Serverlist.conf|xargs`)

### Install 
for node in "${Serverlist[@]}"
do
    echo "####### $node Inatall GlusterFS #######"
    scp ./installSoftware.sh  root@$node:/root/installSoftware.sh
    ssh $node ./installSoftware.sh
done

# mkdir -p /gfs/KubeVolume