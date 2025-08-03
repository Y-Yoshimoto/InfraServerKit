#!/bin/bash

## Serverlist
Serverlist=(`cat /etc/Serverlist.conf|xargs`)


for node in "${Serverlist[@]}"
do
    kubectl drain $node --delete-local-data --force --ignore-daemonsets
    kubectl delete node $node
    ssh $node 'kubeadm reset'
    ssh $node 'iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X'
    ssh $node 'ipvsadm -C'
    ssh $node 'yes | docker system prune'
done
