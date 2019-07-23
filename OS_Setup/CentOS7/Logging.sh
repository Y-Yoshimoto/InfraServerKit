#!/bin/bash

## journald
maxLogSize=10G
mkdir -p /var/log/journal
cp -p /etc/systemd/journald.conf /etc/systemd/journald.conf.org
sed -i -e "s/#SystemMaxUse=/SystemMaxUse=$maxLogSize/" /etc/systemd/journald.conf
systemctl restart systemd-journald

## rsyslog
cp -p /etc/rsyslog.conf /etc/rsyslog.conf.org
sed -i -e '47i $template addpriority,"%timegenerated% %hostname% %programname% %syslogpriority-text% %msg%\\n"' /etc/rsyslog.conf
sed -i -e "s/log\/console/log\/console;addpriority/" /etc/rsyslog.conf
sed -i -e "s/log\/messages/log\/messages;addpriority/" /etc/rsyslog.conf
sed -i -e "s/log\/secure/log\/secure;addpriority/" /etc/rsyslog.conf
sed -i -e "s/log\/maillog/log\/maillog;addpriority/" /etc/rsyslog.conf.edi
sed -i -e "s/log\/cron/log\/cron;addpriority/" /etc/rsyslog.conf
sed -i -e "s/log\/spooler/log\/spooler;addpriority/" /etc/rsyslog.conf
sed -i -e "s/log\/boot.log/log\/boot.log;addpriority/" /etc/rsyslog.conf

## logrotate
cp -p /etc/logrotate.conf /etc/logrotate.conf.org
cp -p /etc/logrotate.d/syslog /etc/logrotate.d/syslog.org
sed -i -e '7i\    ifempty\n    compress\n    daily\n    rotate 365' /etc/logrotate.d/syslog
