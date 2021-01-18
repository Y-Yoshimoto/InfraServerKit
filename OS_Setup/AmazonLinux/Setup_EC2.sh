#!/bin/bash
yum update -y
yum install docker git -y
groupadd docker
gpasswd -a ec2-user docker
curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
systemctl enable docker
systemctl restart docker
