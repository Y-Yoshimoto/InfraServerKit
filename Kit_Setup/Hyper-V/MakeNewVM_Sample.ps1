# Make new VM
# https://docs.microsoft.com/ja-jp/powershell/module/hyper-v/new-vm?view=win10-ps
$VMName = "VMtest"
$VMPath = "D:\Hyper-V\VMdata\"
$VMSW = "LAN"
$ISOFile = "D:\Hyper-V\ISO\CentOS-8.1.1911-x86_64-dvd1.iso"
$VM = @{
   Name = $VMName
   MemoryStartupBytes = 2GB
   Generation = 2
   NewVHDPath = "$VMName.vhdx"
   NewVHDSizeBytes = 70GB
   BootDevice = "VHD"
   Path = $VMPath
   SwitchName = $VMSW
}
New-VM @VM

Write-Host "NEW VM $VMName"
Start-Sleep -s 10
# Get-VM $VMName

## CPU
Set-VMProcessor -VMName $VMName -Count 2
## Memory
Set-VMMemory -VMName $VMName -DynamicMemoryEnabled $true -MinimumBytes 256MB -MaximumBytes 6GB -Priority 50 -Buffer 20
## Network
Connect-VMNetworkAdapter -VMName $VMName -SwitchName $VMSW
## DVD
Add-VMDvdDrive -VMName $VMName -Path $ISOFile

## SecureBoot
Set-VMFirmware -VMName $VMName -EnableSecureBoot Off -FirstBootDevice (Get-VMDvdDrive -VMName $VMName)
## Checkpoint
Set-VM -VMName $VMName -CheckpointType Disabled

Write-Host "SET VM"
Get-VM $VMName