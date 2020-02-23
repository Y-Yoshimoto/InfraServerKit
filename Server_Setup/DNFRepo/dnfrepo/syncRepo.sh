#!/bin/bash
source ~/.bashrc
## URI: http://ftp.riken.jp/pub/Linux/centos/8/
rsync -rptv --delete rsync://ftp.riken.jp/centos/8/AppStream/x86_64/os/ /usr/share/nginx/html/centos/8/AppStream/x86_64/os/ 2>&1 | tee /root/AppStream.log
rsync -rptv --delete rsync://ftp.riken.jp/centos/8/BaseOS/x86_64/os/ /usr/share/nginx/html/centos/8/BaseOS/x86_64/os/ 2>&1 | tee /root/BaseOS.log
# rsync -rptv --delete rsync://ftp.riken.jp/centos/8/HighAvailability/x86_64/os/ /usr/share/nginx/html/centos/8/HighAvailability/x86_64/os/ 2>&1 | tee /root/HighAvailability.log
# rsync -rptv --delete rsync://ftp.riken.jp/centos/8/extras/x86_64/os/ /usr/share/nginx/html/centos/8/extras/x86_64/os/ 2>&1 | tee /root/extras.log