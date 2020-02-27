#!/bin/sh
# Run Allnodes
## swap off
swapoff -a
cp -p /etc/fstab /etc/fstab.bk2
sed -i 's/.*swap/#&/g' /etc/fstab

## NetWork Setting
cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

## Add Kubernetes repo
cat <<'EOF' > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

yum -y install kubeadm kubelet kubectl
systemctl enable kubelet
