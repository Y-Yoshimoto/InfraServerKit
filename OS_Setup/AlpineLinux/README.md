# Alpine Linux Setup
## インストール

## ssh設定変更
vi /etc/ssh/sshd_conifg
    #PermitRootLogin prohibit-password
    →PermitRootLogin yes
rootのパスワードログインを有効化

rc-service sshd restart
rc-service sshd status
