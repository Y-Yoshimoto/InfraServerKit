#!/bin/sh
# Run Master Node
## SetUP kubeadm
systemctl stop kubelet
cp -p /etc/systemd/system/kubelet.service.d/10-kubeadm.conf /etc/systemd/system/kubelet.service.d/10-kubeadm.conf.bk
echo 'Environment="KUBELET_CGROUP_ARGS=--cgroup-driver=systemd"' >>/etc/systemd/system/kubelet.service.d/10-kubeadm.conf
cat /etc/systemd/system/kubelet.service.d/10-kubeadm.conf | grep KUBELET_CGROUP_ARGS
kubeadm reset
mkdir -p /root/kubeSetup
## kubeadm init. PodNetwork is 10.244.0.0 only. --apiserver(MasterNode IPadress)
kubeadm init --apiserver-advertise-address=192.168.1.151 --pod-network-cidr=10.244.0.0/16 > /root/kubeSetup/kubeadmSetupinfo

# make wokerSetupinfo
cat /root/kubeSetup/kubeadmSetupinfo | grep "mkdir -p" >/root/kubeSetup/wokerSetupinfo
cat /root/kubeSetup/kubeadmSetupinfo | grep "sudo cp" >>/root/kubeSetup/wokerSetupinfo
cat /root/kubeSetup/kubeadmSetupinfo | grep "sudo chown" >>/root/kubeSetup/wokerSetupinfo
cat /root/kubeSetup/kubeadmSetupinfo | grep "kubeadm join" >>/root/kubeSetup/wokerSetupinfo
cat /root/kubeSetup/wokerSetupinfo

# setup PodNetwork
export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Check
kubectl get nodes
kubectl get pods --all-namespaces
