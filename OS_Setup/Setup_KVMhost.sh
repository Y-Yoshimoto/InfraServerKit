#!/bin/bash
yum update -y

# Setup_kvm
yum install -y qemu-kvm libvirt virt-install bridge-utils　
yum install -y virt-manager
lsmod | grep kvm
systemctl enable libvirtd
systemctl start libvirtd
virsh net-autostart default

# mkdir
mkdir KVMdata
mkdir KVMISO

# Setup_mkisofs
yum install -y cdw
