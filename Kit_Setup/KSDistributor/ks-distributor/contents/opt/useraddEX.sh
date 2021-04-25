#!/bin/bash
## curl -OL http://$ksweb/opt/useraddEX.sh
if [ $# -ne 1 ]; then
  echo "ERROR. Set user name." 1>&2
  exit 1
fi
## Adduser
username=$1
useradd $username
## Add sudo
#usermod -G sudo $username
# Add dockre Group
gpasswd -a $username docker
gpasswd -a $username microk8s
cp -r /root/.docker /home/$1/
cp -r /root/.kube /home/$1/

# Set Password
echo -n Input Password:
read password
echo $password | passwd --stdin $username

# Add samba user
echo $password | smbpasswd -s -a $username
echo -e "$password\\n$password" | smbpasswd -s -a $username

#Update NIS database
cd /var/yp
make
