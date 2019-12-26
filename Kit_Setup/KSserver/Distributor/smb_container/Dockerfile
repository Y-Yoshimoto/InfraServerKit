FROM alpine
MAINTAINER y.yoshimoto

# コンテツファイルの設置
RUN apk --update add samba && rm -rf /var/cache/apk/*

# smb設定ファイルの設置
COPY smb.conf /etc/samba/smb.conf
RUN mkdir -p /distributor && chmod 777 /distributor

# コンテナ実行時の動作設定
EXPOSE 139 445

# ENTRYPOINT [ "/bin/ash" ]
CMD ["/usr/sbin/smbd", "-i"]

# docker build -t alpine-smb .
# docker run -d -p 8139:139 -p 8445:445 --name smb-test alpine-smb
# docker logs smb-test
# docker exec -it smb-test /bin/ash
# docker stop smb-test && docker rm smb-test


## mkdir -p /usr/local/samba/var/