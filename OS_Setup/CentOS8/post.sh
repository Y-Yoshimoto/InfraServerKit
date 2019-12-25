#!/bin/bash
## curl -OL http://192.168.1.80/post.sh 
echo "Start setup Server."
source ~/.bashrc 
mkdir ./setupLogs

defaultGateway=192.168.1.1
ntpServer=$defaultGateway
######################### Network #########################



######################### DNF #########################
# DNF update 
dnf update -y

######################### firewalld selinux #########################
# Stop firewalld
systemctl disable firewalld
systemctl stop firewalld
systemctl is-enabled firewalld > ./setupLogs/firewalldSystemd.log
systemctl status firewalld >> ./setupLogs/firewalldSystemd.log

# Disable selinux
cp -bp /etc/selinux/config /etc/selinux/config.org
sed -i -e "s/enforcing/disabled/" /etc/selinux/config
diff /etc/selinux/config /etc/selinux/config.org > ./setupLogs/selinuxDiff.log

######################### tool #########################
# Setup_tools
## vim
dnf install vim -y
cp -bp /etc/vimrc /etc/vimrc.org
echo -e "set number\ncolorscheme desert\nset ts=4" >>/etc/vimrc
cp -bp /etc/profile /etc/profile.org
echo -e "alias vi='vim'" >>/etc/profile
diff /etc/profile /etc/profile.org > ./setupLogs/vimDiff.log
diff /etc/vimrc /etc/vimrc.org > ./setupLogs/vimDiff.log

## git
dnf install git -y
######################### Basic Demon #########################
# Setup sshd
cp -p /etc/ssh/sshd_config /etc/ssh/sshd_config.org
# sed -i -e "s/PermitRootLogin yes/PermitRootLogin no/" /etc/ssh/sshd_config
# sed -i -e "s/PermitRootLogin yes/PermitRootLogin prohibit-password/" /etc/ssh/sshd_config
diff /etc/ssh/sshd_config /etc/ssh/sshd_config.org > ./setupLogs/sshd_configDiff.log

# Setup Chrony
cp -p /etc/chrony.conf /etc/chrony.conf.org
sed -i -e "s/server/#server/" /etc/chrony.conf
sed -i -e "3i server $ntpServer" /etc/chrony.conf
diff /etc/chrony.conf /etc/chrony.conf.org > ./setupLogs/chronyDiff.log

ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
######################### LOG #########################
# Setup LogConfig
## journald
maxLogSize=1G
mkdir -p /var/log/journal
cp -p /etc/systemd/journald.conf /etc/systemd/journald.conf.org
sed -i -e "s/#SystemMaxUse=/SystemMaxUse=$maxLogSize/" /etc/systemd/journald.conf
systemctl restart systemd-journald
diff /etc/systemd/journald.conf /etc/systemd/journald.conf.org > ./setupLogs/journaldDiff.log

## rsyslog
cp -p /etc/rsyslog.conf /etc/rsyslog.conf.org
sed -i -e '39i $template addpriority,"%timegenerated% %hostname% %programname% %syslogpriority-text% %msg%\\n"' /etc/rsyslog.conf
sed -i -e "s/log\/console/log\/console;addpriority/" /etc/rsyslog.conf
sed -i -e "s/log\/messages/log\/messages;addpriority/" /etc/rsyslog.conf
sed -i -e "s/log\/secure/log\/secure;addpriority/" /etc/rsyslog.conf
sed -i -e "s/log\/maillog/log\/maillog;addpriority/" /etc/rsyslog.conf
sed -i -e "s/log\/cron/log\/cron;addpriority/" /etc/rsyslog.conf
sed -i -e "s/log\/spooler/log\/spooler;addpriority/" /etc/rsyslog.conf
sed -i -e "s/log\/boot.log/log\/boot.log;addpriority/" /etc/rsyslog.conf
diff /etc/rsyslog.conf /etc/rsyslog.conf.org > ./setupLogs/rsyslogDiff.log

## logrotate
cp -p /etc/logrotate.conf /etc/logrotate.conf.org
mkdir -p /etc/logrotate.d
cp -bp /etc/logrotate.d/syslog /etc/logrotate.d/syslog.org
sed -i -e '7i\    ifempty\n    compress\n    daily\n    rotate 365' /etc/logrotate.d/syslog
diff /etc/logrotate.d/syslog /etc/logrotate.d/syslog.org > ./setupLogs/logrotateDiff.log

echo "END"