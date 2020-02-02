# Windows Server構築サンプル
## ps1ファイルの実行許可
    1. 管理者権限でPowerShellを起動し、"Set-ExecutionPolicy RemoteSigned"コマンドで実行ポリシーを変更する。
    2. "Get-ExecutionPolicy"コマンドで実行ポリシーが"RemoteSigned"となっていることを確認する。
    3. "Hello.ps1"が実行できることを確認する。

## SSHサーバの起動
    1.1 インストール(Windows10)
    設定> アプリと機能> オプション機能の管理
    上記のリストから"OpenSSHサーバ"をインストールする
    1.2インストール(Windows Server 2019)
        Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'
        Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
        Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
    2. ファイアウォールのルールを追加する
    New-NetFirewallRule -Protocol TCP -LocalPort 22 -Direction Inbound -Action Allow -DisplayName SSH
    3. サービスを起動する
        Start-Service -Name "sshd"
        Set-Service -Name "sshd" -StartupType Automatic
    4. SSHアクセス
        ssh Administrator@[hostname] -t powershell

## その他初期構築
    - ホスト名の設定
        Rename-Computer -NewName ホスト名 -Force
    - RDP有効化(ネットワーク認証OFF)
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value "0"
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name UserAuthentication" -Value "0"
        New-NetFirewallRule -Protocol TCP -LocalPort 22 -Direction Inbound -Action Allow -DisplayName SSH
        Get-NetFirewallRule -DisplayName "リモート*デスクトップ*" | Select DisplayName, Enabled
        Get-NetFirewallRule -DisplayName "Remote Desktop*" | Select DisplayName, Enabled

## 再起動, シャットダウン
Restart-Computer -Force
Stop-Computer -Force