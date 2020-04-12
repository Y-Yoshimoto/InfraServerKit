# Windows Server初期構築
# Invoke-WebRequest 'https://raw.githubusercontent.com/Y-Yoshimoto/InfraServerKit/master/OS_Setup/Windows_Server/InitServer.ps1' -OutFile ./InitServer.ps1
# Set-ExecutionPolicy RemoteSigned

## ホスト名設定
Rename-Computer WinTest-EN
## Administratorユーザー名変更
# Rename-LocalUser -Name "Administrator" -NewName "root"
# net user root
# WMIC USERACCOUNT WHERE Name="root" SET PasswordExpires=False


## タイムゾーン設定
Set-TimeZone -Id "Tokyo Standard Time" -PassThru

## RDP有効化 ##
Get-NetFirewallRule -DisplayGroup "Remote Desktop*" | Set-NetFirewallRule -Enabled True
Get-NetFirewallRule -DisplayName "Remote Desktop*" | Select DisplayName, Enabled
Get-NetFirewallRule -DisplayName "リモート*デスクトップ*" | Set-NetFirewallRule -Enabled True ## JP
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value "0"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Value "0"

## SSH有効化 ##
#Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'
Add-WindowsCapability -Online -Name 'OpenSSH.Server~~~~0.0.1.0'
Add-WindowsCapability -Online -Name 'OpenSSH.Client~~~~0.0.1.0'
New-NetFirewallRule -Protocol TCP -LocalPort 22 -Direction Inbound -Action Allow -DisplayName SSH
Start-Service -Name "sshd"
Set-Service -Name "sshd" -StartupType Automatic
# ssh Administrator@localhost -t powershell
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force


### 公開鍵設置 
$authKeyPath = "$env:ProgramData\ssh\administrators_authorized_keys"
New-Item $authKeyPath
Write-Output "testKey" | Out-File -FilePath $authKeyPath -Encoding ascii
### アクセス権変更
$acl = Get-Acl $authKeyPath
$acl.SetAccessRuleProtection($true,$true)
$removeRule = $acl.Access | Where-Object { $_.IdentityReference -eq 'NT AUTHORITY\Authenticated Users' }
$acl.RemoveAccessRule($removeRule)
$acl | Set-Acl -Path $authKeyPath

### プロンプト変更  $PROFILE (バージョン確認)
New-Item $HOME\Documents\WindowsPowerShell -ItemType Directory
New-Item $HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
Set-Item function:Global:prompt {"PS:[" + $(hostname) +"] "+ (Split-Path (Get-Location) -Leaf) +"/ >"} -force
Write-Output 'function prompt() {"PS:[" + $(hostname) +"] "+ (Split-Path (Get-Location) -Leaf) +"/ >"}' >> $HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

## ファイアウォール無効化
# Get-NetFirewallProfile | Set-NetFirewallProfile -Enabled false

## Windows Update無効化
### レジストリキー変更(グループポリシー:自動更新を構成するを無効化)
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate","HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name NoAutoUpdate -PropertyType DWord -Value 1 -Force

## Windows Update
# $updates = Start-WUScan
# Install-WUUpdates -Updates $updates

# Restart-Computer -Force
