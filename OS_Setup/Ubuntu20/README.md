# Ubuntu20

## デスクトップ向け
### GUIインストール
 - Google Crome  
    [Google公式ページ](https://www.google.com/chrome/)からインストーラをダウンロード。.debファイルをダウンロードし、インストール
 - VSCode  
    [VSCode公式ページ](https://code.visualstudio.com/)からインストーラをダウンロード。.debファイルをダウンロードし、インストール
 - Openssh  
    ```bash
    sudo -s
    apt -y install openssh-server
    systemctl restart ssh
    systemctl enable ssh
    ```


### ベーシック設定
```bash
sudo -s
apt install -y vim git firewalld
cp -bp /etc/vim/vimrc /etc/vim/vimrc.org
echo -e "set number\ncolorscheme desert\nset ts=4" >> /etc/vim/vimrc
cp -bp /etc/profile /etc/profile.org
echo -e "alias vi='vim'" >> /etc/profile
systemctl stop firewalld
systemctl disable firewalld
```

プロンプト変更
```bash
echo $USER
echo -e "export PS1='\u@\h \W\$ '" >> /home/$USER/.bashrc
```

### Dokcer関連
Dokcer, Docker-compose, Kubernetesをインストール
```bash
sudo -s
cd /
apt -y install docker.io docker-compose
docker pull alpine
docker run alpine /bin/echo "Run Alpine Linux"
systemctl start snapd.socket
snap install microk8s --classic
microk8s status
microk8s config
microk8s start
snap enable microk8s

echo -e "alias kubectl='microk8s kubectl'" >> /etc/profile
source /etc/profile
kubectl create deployment nginx --image=nginx
kubectl get pods
kubectl delete deployment nginx

echo 'source /usr/share/bash-completion/bash_completion' >> /etc/bashrc
source /etc/bashrc
kubectl completion bash > /etc/bash_completion.d/kubectl
```

ユーザーに実行権限を追加/再ログイン必要
```bash
sudo -s
gpasswd -a $username docker
gpasswd -a $username microk8s
```

### Samba
使用するサブネットに合わせて設定
```bash
sudo -s
apt -y install samba
cp -p /etc/samba/smb.conf /etc/samba/smb.conf.org

#sed -i -e "s/SAMBA/$domain/" /etc/samba/smb.conf
sed -i -e '9i\        unix charset = UTF-8' /etc/samba/smb.conf
sed -i -e '10i\        dos charset = CP932' /etc/samba/smb.conf
sed -i -e '11i\        hosts allow = 127. 10.0.0. 192.168. ' /etc/samba/smb.conf
sed -i -e "s/;\[homes\]/\[homes\]/" /etc/samba/smb.conf
sed -i -e "s/;   comment = Home Directories/   comment = Home Directories/" /etc/samba/smb.conf
sed -i -e "s/;   browseable = no/   browseable = no\/n   writable = yes/" /etc/samba/smb.conf


## Share 777 Dir
echo '[Data]' >> /etc/samba/smb.conf
echo '  path = /data' >> /etc/samba/smb.conf
echo '  writable = yes' >> /etc/samba/smb.conf
echo '  guest ok = yes' >> /etc/samba/smb.conf
echo '  guest only = yes' >> /etc/samba/smb.conf
echo '  force create mode = 777' >> /etc/samba/smb.conf
echo '  force directory mode = 777 ' >> /etc/samba/smb.conf


systemctl enable --now smbd
systemctl restart smbd

apt install -y firewalld
firewall-cmd --add-service=samba --permanent
firewall-cmd --reload

```
ユーザー追加
```bash
smbpasswd -a $username
```
