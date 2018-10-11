#!/bin/sh
# --name, --diskを編集
#qemu-img create -f qcow2 server.qcow2 5G
virt-install \
--name VM1 \
--ram=640 \
--disk path='/media/test/KVM_HDD/VM1.qcow2',size=10,format=qcow2 \
--vcpus 1 \
--os-type linux \
--os-variant rhel7 \
--network network=default \
--graphics none \
--console pty,target_type=serial \
--location '/home/test/KVM_DATA/iso/CentOS-7-x86_64-Minimal-1611.iso' \
--initrd-inject /home/test/KVM_DATA/ks/ks.cfg
--extra-args "ks=file:/home/test/KVM_data/kickstart/ks.cfg console=ttyS0,115200" \
