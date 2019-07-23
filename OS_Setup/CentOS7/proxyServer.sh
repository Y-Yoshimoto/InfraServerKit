#!/bin/bash
touch /etc/profile.d/proxy.sh
echo -e "PROXY='192.168.1.1\8080'" >>/etc/profile.d/proxy.sh
echo -e "export http_proxy=\$PROXY" >>/etc/profile.d/proxy.sh
echo -e "export HTTP_PROXY=\$PROXY" >>/etc/profile.d/proxy.sh
echo -e "export https_proxy=\$PROXY" >>/etc/profile.d/proxy.sh
echo -e "export HTTPS_PROXY=\$PROXY" >>/etc/profile.d/proxy.sh
echo -e "export no_proxy='localhost,127.0.0.1'" >>/etc/profile.d/proxy.sh
