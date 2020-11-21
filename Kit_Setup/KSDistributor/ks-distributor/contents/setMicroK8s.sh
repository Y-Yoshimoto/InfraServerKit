#!/bin/bash
## https://microk8s.io/docs
## curl -OL http://$ksweb/setMicroK8s.sh
echo "Start Setup MicroK8s"
echo "Runing setMicroK8s.sh and Automatically reboot." > /etc/motd
source ~/.bashrc
source /root/ks-env.sh

######################### Crontab #########################
sed -i -e "s/@reboot/#@reboot/" /etc/crontab


## Install snapd
dnf -y install epel-release
dnf --enablerepo=epel -y install snapd
ln -s /var/lib/snapd/snap /snap
echo 'export PATH=$PATH:/var/lib/snapd/snap/bin' > /etc/profile.d/snap.sh
source /etc/profile.d/snap.sh
#### ProxySetup
#mkdir -p /etc/systemd/system/snapd.service.d
#echo '[Service]' > /etc/systemd/system/snapd.service.d/http-proxy.conf
#echo "Environment=http_proxy=http://$proxy" >> /etc/systemd/system/snapd.service.d/http-proxy.conf
#echo "Environment=https_proxy=http://$proxy" >> /etc/systemd/system/snapd.service.d/http-proxy.conf
#echo "Environment=NO_PROXY=localhost,127.0.0.1,$ksweb" >> /etc/systemd/system/snapd.service.d/http-proxy.conf
systemctl enable --now snapd.service snapd.socket
sleep 20
. ./.bash_profile

## Install MicroK8s #################################
snap install microk8s --classic
### Enable microk8s
snap enable microk8s
microk8s status
microk8s config
microk8s kubectl get all
microk8s kubectl get nodes
echo -e "alias kubectl='microk8s kubectl'" >> /etc/profile

#### ProxySetup
#echo "HTTPS_PROXY=https://$proxy" >> /var/snap/microk8s/current/args/containerd-env
#echo "NO_PROXY=10.1.0.0/16,10.152.183.0/24,192.168.1.0/24" >> /var/snap/microk8s/current/args/containerd-env
## kubelet

## Edit config k8s
cp -p /var/snap/microk8s/current/args/kube-apiserver /var/snap/microk8s/current/args/kube-apiserver.org
echo "--service-node-port-range 1-32767" >> /var/snap/microk8s/current/args/kube-apiserver
#microk8s reset
microk8s stop
microk8s start

### Disble microk8s
# microk8s stop
# snap disable microk8s
# microk8s status

# MicroK8s Storage PVC
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/lib64"
microk8s enable storage
microk8s kubectl -n kube-system get pods

# Install Kube Tools #################################
## Install kubectl on Linux
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
kubectl version

## kubelet auto-completion
dnf install -y bash-completion
echo 'source /usr/share/bash-completion/bash_completion' >> /etc/bashrc
kubectl completion bash >/etc/bash_completion.d/kubectl

## Install kompose on Linux
#curl -L https://github.com/kubernetes/kompose/releases/download/v1.21.0/kompose-linux-amd64 -o kompose
#chmod +x kompose
#sudo mv ./kompose /usr/local/bin/kompose
curl -LO https://github.com/kubernetes/kompose/releases/download/v1.21.0/kompose-1.21.0-1.x86_64.rpm
rpm -ivh  kompose-1.21.0-1.x86_64.rpm 

# Connection locahost k8s
microk8s.kubectl config view --raw > ~/.kube/config-localhost
mv ~/.kube/config-localhost ~/.kube/config

echo "END"
echo "" > /etc/motdl
