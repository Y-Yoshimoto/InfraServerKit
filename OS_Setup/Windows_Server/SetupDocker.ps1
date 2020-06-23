## https://docs.microsoft.com/ja-jp/virtualization/windowscontainers/deploy-containers/deploy-containers-on-server
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name docker -ProviderName DockerMsftProvider -Force
Restart-Computer -Force
