#!/bin/bash
## curl -OL http://192.168.1.80/setMinikube.sh 
echo "Start Setup Minikube"
echo "Runing setMinikube.sh and Automatically reboot." > /etc/motd

######################### Crontab #########################
sed -i -e "s/@reboot/#@reboot/" /etc/Crontab

######################### Minikube #########################

# Minikube download
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube

# Install 
mkdir -p /usr/local/bin/
install minikube /usr/local/bin/
rm -f minikube

# Install kubectl on Linux
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
kubectl version

# Start Minikube
minikube start --vm-driver=none
echo "Minikube Status"
minikube status
# minikube stop
# minikube delete

echo "END"
echo "" > /etc/motd