## KVM on Hyper-V
仮想マシンに対して、ネストの仮想化の状態を確認するスクリプトをダウンロードする、
対象とする仮想マシンに対してネストの仮想化を有効かし、スクリプトで設定を確認する。
適応後に仮想マシンを起動する。
``ps1
Invoke-WebRequest https://raw.githubusercontent.com/Microsoft/Virtualization-Documentation/master/hyperv-tools/Nested/Get-NestedVirtStatus.ps1 -OutFile Get-NestedVirtStatus.ps1
Set-VMProcessor -VMName 仮想マシン名 -ExposeVirtualizationExtensions $true
.¥Get-NestedVirtStatus.ps1 -VmName "仮想マシン名"
``
