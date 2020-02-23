#!/bin/bash
## curl -OL http://192.168.1.80/setMinikube.sh 
echo "Start Setup Minikube"
echo "Runing setMinikube.sh and Automatically reboot." > /etc/motd

######################### Crontab #########################
#sed -i -e "s/@reboot/#@reboot/" /etc/Crontab
sleep 10s

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

# Install kompose on Linux
curl -L https://github.com/kubernetes/kompose/releases/download/v1.20.0/kompose-linux-amd64 -o kompose
chmod +x kompose
sudo mv ./kompose /usr/local/bin/kompose

# Start Minikube
minikube start --vm-driver=none
echo "Minikube Status"
minikube status
# minikube stop
# minikube delete

# Start docker registry
docker pull registry:latest
docker run -d -p 5000:5000 --restart always --name registry registry:2
echo "docker registry: localhost:5000"
# push registry
# docker pull alpine
# docker tag alpine localhost:5000/alpine
# docker push localhost:5000/alpine

echo "END"
echo "" > /etc/motd