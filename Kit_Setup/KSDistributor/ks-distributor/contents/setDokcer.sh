#!/bin/bash
## curl -OL http://192.168.1.80/setDokcer.sh 
echo "Start setup Docker."
echo "Runing setDocker.sh and Automatically reboot." > /etc/motd

source ~/.bashrc
source /root/ks-env.sh

######################### Crontab #########################
sed -i -e "s/@reboot/#@reboot/" /etc/crontab
## Setup Docker
#echo "@reboot root /root/setMicroK8s.sh 2>&1 | tee /root/setMicroK8s.log" >> /etc/crontab

######################### Docker #########################
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf repolist
dnf update -y
dnf install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.10-3.2.el7.x86_64.rpm
dnf install -y --nobest docker-ce
dnf config-manager --disable docker-ce.repo
docker --version
systemctl enable docker
systemctl restart docker
systemctl status docker | grep Active:

# groupadd docker
# gpasswd -a $GeneralUser docker
######################### docker-compose #########################
curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

############################### Dokcer ProxySetup ###############################
# mkdir ~/.docker/
# curl -L http://$ksweb/docker-config.json > ~/.docker/config.json
# sed -i -e "s/PROXY/$proxy/" ~/.docker/config.json
# mkdir -p /etc/systemd/system/docker.service.d
# echo '[Service]' > /etc/systemd/system/docker.service.d/http-proxy.conf
# echo 'Environment="HTTP_PROXY="http://$proxy/"HTTPS_PROXY=http://$proxy/" "NO_PROXY=localhost,127.0.0.1,$ksweb"' >> /etc/systemd/system/docker.service.d/http-proxy.conf
# systemctl daemon-reload
# systemctl restart docker
# systemctl status docker | grep Active:

######################### Clean #########################
mv setDokcer.sh /root/used
dnf clean all
echo "END"
echo "" > /etc/motd
reboot
