# SetupZabbixAgent

Invoke-WebRequest -Uri https://www.zabbix.com/downloads/4.4.5/zabbix_agent-4.4.5-windows-amd64-openssl.zip -OutFile ./zabbix_agents.zip
Expand-Archive -Path ./zabbix_agents.zip ./zabbix_agents

# Set some Files.
copy .\zabbix_agents\conf\zabbix_agentd.conf .\zabbix_agents\conf\zabbix_agentd.conf.bak
Copy-Item "zabbix_agents" "C:\Program Files\" -Recurse -Force

## Edit conf file.
$hostName = hostname
$ZabbixServerIP = "192.168.1.50"
$ZabbixServerSegment = "192.168.1.0/24"

$config= Get-Content .\zabbix_agents\conf\zabbix_agentd.conf -Encoding UTF8
# $config= $config.Replace("LogFile=c:\\zabbix_agentd.log","LogFile=C:\Program Files\zabbix_agents\log\zabbix_agentd.log")
$config= $config.Replace("# LogType=file","LogType=system")
$config= $config.Replace("Server=127.0.0.1","Server=$ZabbixServerSegment")
######### ServerActive=xxx.xxx.xxx.xxx ######### Set Your ZabbixServer "/32"
$config= $config.Replace("ServerActive=127.0.0.1","ServerActive=$ZabbixServerIP")
$config= $config.Replace("Hostname=Windows host","Hostname=$hostName")
# $config | Out-file .\zabbix_agents\conf\zabbix_agentd.conf -Encoding UTF8
[IO.File]::WriteAllLines("C:\Program Files\zabbix_agents\conf\zabbix_agentd.conf", $config)

##Fiewall
Start-Process powershell -Verb runas
if (-not(Get-NetFirewallRule | where Name -eq "Zabbix_agent"))
{
    New-NetFirewallRule `
        -Name "Zabbix_agent" `
        -DisplayName "Zabbix_agent" `
        -Description "Zabbix_agent_Allow 10050"
        -Enabled True `
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
.\zabbix_agentd.exe --config "C:\Program Files\zabbix_agents\conf\zabbix_agentd.conf" --install
Start-Service -Name "Zabbix Agent"

# Unistall
## Stop-Service -Name "Zabbix Agent"
## cmd sc delete "Zabbix Agent"
## rm “C:\Program Files\zabbix_agents” -Force
