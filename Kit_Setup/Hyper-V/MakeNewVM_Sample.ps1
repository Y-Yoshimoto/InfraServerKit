# Make new VM
# https://docs.microsoft.com/ja-jp/powershell/module/hyper-v/new-vm?view=win10-ps
$VMName = "VMPS1"
$VMPath = "D:\Hyper-V\VMdata\"
$VMSW = "CanisLAN"
$ISOFile = "D:\Hyper-V\ISO\CentOS-8-x86_64-1905-dvd1.iso"
$VM = @{
   Name = $VMName
   MemoryStartupBytes = 1GB
   Generation = 2
   NewVHDPath = "$VMName.vhdx"
   NewVHDSizeBytes = 50GB
   BootDevice = "VHD"
   Path = $VMPath
   SwitchName = $VMSW
}

New-VM @VM

Write-Host "NEW VM $VMName"
# Get-VM $VMName | select *

## CPU設定
Set-VMProcessor -VMName $VMName -Count 2
## メモリ設定
Set-VMMemory -VMName $VMName -DynamicMemoryEnabled $true -MinimumBytes 256MB -MaximumBytes 2GB -Priority 50 -Buffer 20
## ネットワーク設定
Connect-VMNetworkAdapter -VMName VMPS3 -SwitchName $VMSW 
## DVD指定
Add-VMDvdDrive -VMName $VMName -Path $ISOFile
#Set-VMDvdDrive $VMName -Path $ISOFile
## セキュアブート
Set-VMFirmware -VMName WinTest-EN -EnableSecureBoot Off -FirstBootDevice (Get-VMDvdDrive -VMName WinTest-EN)
## チェックポイント
Set-VM-VMName  $VMName -CheckpointType Disabled

Write-Host "SET VM"
# Get-VM $VMName | select *