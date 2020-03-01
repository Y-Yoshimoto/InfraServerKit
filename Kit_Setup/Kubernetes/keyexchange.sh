#!/bin/bash
## Add hostname 
echo '192.168.1.150 kube0' >> /etc/hosts
echo '192.168.1.151 kube1' >> /etc/hosts
echo '192.168.1.152 kube2' >> /etc/hosts
echo '192.168.1.153 kube3' >> /etc/hosts

## Serverlist
Serverlist=("kube0" "kube1" "kube2" "kube3")
test -f /etc/Serverlist.conf && mv /etc/Serverlist.conf /etc/Serverlist.conf.old
## ssh-keygen
ssh-keygen -t ed25519 -P "" -f /root/.ssh/id_kube
cat /root/.ssh/id_kube.pub >> /root/.ssh/authorized_keys

## Make ssh conif and list
for node in "${Serverlist[@]}"
do
    echo $node >> /etc/Serverlist.conf
    echo "Host $node" >> /root/.ssh/config
    echo "  HostName $node" >> /root/.ssh/config
    echo "  IdentityFile ~/.ssh/id_kube" >> /root/.ssh/config
done

## Exchange id_kube Key
for node in "${Serverlist[@]}"
do
    echo "####### $node Exchange Key #######"
    scp -oStrictHostKeyChecking=no /root/.ssh/authorized_keys root@$node:/root/.ssh/authorized_keys
    scp /root/.ssh/id_kube root@$node:/root/.ssh/id_kube
done

## Exchange files
for node in "${Serverlist[@]}"
do
    echo "####### $node Exchange Files #######"
    scp /root/.ssh/known_hosts root@$node:/root/.ssh/known_hosts
    scp /etc/hosts root@$node:/etc/hosts
    scp /root/.ssh/config root@$node:/root/.ssh/config
    scp /etc/Serverlist.conf root@$node:/etc/Serverlist.conf
done