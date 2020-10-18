#!/bin/sh
# Inatall GlusterFS
wget https://download.gluster.org/pub/gluster/glusterfs/LATEST/CentOS/glusterfs-rhel8.repo -P /etc/yum.repos.d/
dnf --enablerepo=PowerTools -y install glusterfs-server glusterfs glusterfs-fuse
systemctl enable --now glusterd
systemctl status glusterd
gluster --version

Install kompose on Linux
curl -L https://github.com/kubernetes/kompose/releases/download/v1.20.0/kompose-linux-amd64 -o kompose
chmod +x kompose
sudo mv ./kompose /usr/local/bin/kompose

### Install kubernetes (kubelet kubeadm kubelet)
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
setenforce 0
systemctl enable --now kubelet

### traffic routed
cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

# CNI
export KUBECONFIG=/etc/kubernetes/admin.conf
curl -L https://docs.projectcalico.org/manifests/calico.yaml | \
sed  '/            - name: CALICO_DISABLE_FILE_LOGGING/i\            # ADD' | \
sed  '/            - name: CALICO_DISABLE_FILE_LOGGING/i\            - name: FELIX_IPTABLESBACKEND' | \
sed  '/            - name: CALICO_DISABLE_FILE_LOGGING/i\              value: Auto'  | \
sed  '/            - name: CALICO_DISABLE_FILE_LOGGING/i\            # ADD' | \
sed  '/            - name: CALICO_DISABLE_FILE_LOGGING/i\            - name: CALICO_IPV4POOL_CIDR' | \
sed  '/            - name: CALICO_DISABLE_FILE_LOGGING/i\              value: \"10.244.0.0\/16\"' | \
kubectl apply -f -

### kubelet auto-completion
dnf install -y bash-completion
echo 'source /usr/share/bash-completion/bash_completion' >> /etc/bashrc
kubectl completion bash >/etc/bash_completion.d/kubectl

### HighAvailability
dnf --enablerepo=HighAvailability -y install pacemaker pcs
systemctl enable --now pcsd
echo 'hacluster' | passwd --stdin hacluster