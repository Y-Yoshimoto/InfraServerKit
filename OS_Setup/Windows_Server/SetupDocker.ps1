# Docker
## https://docs.microsoft.com/ja-jp/virtualization/windowscontainers/deploy-containers/deploy-containers-on-server
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name docker -ProviderName DockerMsftProvider -Force
# Docker-compose
## http://docs.docker.jp/compose/install.html#windows-compose
## https://github.com/docker/compose/releases
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-Windows-x86_64.exe" -UseBasicParsing -OutFile $Env:ProgramFiles\docker\docker-compose.exe
Restart-Computer -Force
