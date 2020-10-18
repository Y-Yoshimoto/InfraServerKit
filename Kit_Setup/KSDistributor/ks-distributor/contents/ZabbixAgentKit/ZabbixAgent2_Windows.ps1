 # SetupZabbixAgent
# Invoke-WebRequest -Uri http://192.168.1.80/Zabbix/ZabbixAgent_Windows.ps1 -OutFile ./ZabbixAgent_Windows.ps1
Invoke-WebRequest -Uri https://www.zabbix.com/downloads/5.0.4/zabbix_agent2-5.0.4-windows-amd64-openssl-static.zip -OutFile ./zabbix_agents2.zip
Expand-Archive -Path ./zabbix_agents2.zip ./zabbix_agents

# Set some Files.
New-Item .\zabbix_agents\log -ItemType Directory
copy .\zabbix_agents\conf\zabbix_agent2.conf .\zabbix_agents\conf\zabbix_agent2.conf.bak
Copy-Item "zabbix_agents" "C:\Program Files\" -Recurse -Force


## Edit conf file.
$hostName = hostname
$ZabbixServerIP = "192.168.1.77"
$ZabbixServerSegment = "192.168.1.0/24"

$config= Get-Content .\zabbix_agents\conf\zabbix_agent2.conf -Encoding UTF8
# $config= $config.Replace("LogFile=c:\\zabbix_agentd.log","LogFile=C:\Program Files\zabbix_agents\log\zabbix_agent2.log")
$config= $config.Replace("# LogType=file","LogType=file")
$config= $config.Replace("LogFile=c:\zabbix_agentd.log","LogFile=C:\Program Files\zabbix_agents\log\zabbix_agentd.log")
$config= $config.Replace("# # LogFileSize=1","# LogFileSize=100")
$config= $config.Replace("Server=127.0.0.1","Server=$ZabbixServerSegment")
######### ServerActive=xxx.xxx.xxx.xxx ######### Set Your ZabbixServer "/32"
$config= $config.Replace("ServerActive=127.0.0.1","ServerActive=$ZabbixServerIP")
$config= $config.Replace("Hostname=Windows host","Hostname=$hostName")
# $config | Out-file .\zabbix_agents\conf\zabbix_agentd.conf -Encoding UTF8
[IO.File]::WriteAllLines("C:\Program Files\zabbix_agents\conf\zabbix_agent2.conf", $config)

##Fiewall
Start-Process powershell -Verb runas
if (-not(Get-NetFirewallRule | where Name -eq "Zabbix_agent"))
{
    New-NetFirewallRule `
        -Name "Zabbix_agent" `
        -DisplayName "Zabbix_agent" `
        -Description "Zabbix_agent_Allow 10050" -Enabled True `
        -Group "Zabbix" `
        -Action Allow `
        -RemoteAddress Any`
        -LocalPort 10050`
        -LocalUser Any `
        -Protocol TCP
}
else
{
    Get-NetFirewallPortFilter -Protocol TCP | where Localport -eq 10050
}

## Install
cd "C:\Program Files\zabbix_agents\bin\"
pwd
.\zabbix_agent2.exe --config "C:\Program Files\zabbix_agents\conf\zabbix_agent2.conf" --install
Start-Service -Name "Zabbix Agent 2"

# Unistall
## Stop-Service -Name "Zabbix Agent 2"
## .\zabbix_agent2.exe --config "C:\Program Files\zabbix_agents\conf\zabbix_agent2.conf" --uninstall
## cmd sc delete "Zabbix Agent 2"
## rm 'C:\Program Files\zabbix_agents' -Force
 
