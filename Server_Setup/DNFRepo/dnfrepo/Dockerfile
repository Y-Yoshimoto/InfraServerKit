FROM centos:centos8
LABEL maintainer 'y-yoshiomo'

RUN dnf install -y rsync createrepo nginx

RUN mkdir -p /usr/share/nginx/html/centos/8/{AppStream,BaseOS,HighAvailability,extras}/x86_64/os/

## URL http://ftp.riken.jp/pub/Linux/centos/8/
# RUN rsync -rptv --delete rsync://ftp.riken.jp/centos/8/AppStream/ /usr/share/nginx/html/centos/8/AppStream/ && \
#    rsync -rptv --delete rsync://ftp.riken.jp/centos/8/BaseOS/ /usr/share/nginx/html/centos/8/BaseOS/ && \
#    rsync -rptv --delete rsync://ftp.riken.jp/centos/8/HighAvailability/x86_64/os/ /usr/share/nginx/html/centos/8/HighAvailability/x86_64/os/ > /root/HighAvailability.log && \
#    rsync -rptv --delete rsync://ftp.riken.jp/centos/8/extras/x86_64/os/ /usr/share/nginx/html/centos/8/extras/x86_64/os/ > /root/extras.log
RUN echo 'dnf repo' > /usr/share/nginx/html/index.html
COPY ./syncRepo.sh /root/syncRepo.sh 
RUN chmod 755 /root/syncRepo.sh

EXPOSE 80
# ENTRYPOINT ["tail", "-f" ,"/dev/null"]
ENTRYPOINT ["/usr/sbin/nginx", "-g" ,"daemon off;"]
