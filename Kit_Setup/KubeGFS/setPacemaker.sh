#!/bin/bash

## Serverlist
Serverlist=(`cat /etc/Serverlist.conf|xargs`)

## Setup KubeCluster
result="$(IFS=" "; echo "${Serverlist[*]}")"
echo $result
echo 'Input Username and Password'
echo 'hacluster'
pcs host auth $result
pcs cluster setup KubeCluster $result --force
## show status
pcs cluster start --all
pcs cluster enable --all
pcs cluster status
pcs status corosync

## VIP resource
pcs resource create Virtual_IP ocf:heartbeat:IPaddr2 ip=192.168.1.50 cidr_netmask=24 op monitor interval=10s
pcs property list
pcs status resources

## kubelet glusterFS resource
systemctl disable glusterd
systemctl disable kubelet
pcs resource create GlusterFS systemd:glusterd
pcs resource create Kubelet systemd:kubelet
pcs resource clone GlusterFS
pcs resource clone Kubelet
pcs status resources

pcs constraint colocation add Virtual_IP with GlusterFS-clone 
pcs constraint colocation add Virtual_IP with Kubelet-clone
pcs constraint
pcs status resources