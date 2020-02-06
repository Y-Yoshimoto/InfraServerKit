# SetUp Docker
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name docker -ProviderName DockerMsftProvider
Set-Service -Name "Docker" -StartupType Automatic
## Restart-Computer -Force
# docker pull mcr.microsoft.com/windows/nanoserver
## https://docs.microsoft.com/ja-jp/virtualization/windowscontainers/quick-start/set-up-environment?tabs=Windows-Server