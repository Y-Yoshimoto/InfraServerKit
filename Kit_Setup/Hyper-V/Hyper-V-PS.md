# 基本コマンド
- 仮想マシンの一覧取得
```ps1
    Get-VM  #一覧
    Get-VM | where {$_.State -eq 'Running'} #起動中一覧
    Get-VM | where {$_.State -eq 'Off'}     #停止中一覧
```

-仮想マシンの詳細
```ps1
    Get-VM "仮想マシン名" | select *
```

- 仮想マシンの起動
```ps1
    Start-VM -Name "仮想マシン名"
```
- 仮想マシンの停止
```ps1
    Stop-VM -Name "仮想マシン名"
```
- 仮想マシンの新規作成
```ps1
    $NewVMName = "仮想マシン名"
    $NewVM = @{
        Name = $NewVMName
        ### 各オプションを指定
    }
    New-VM @NewVM
```
[参考1](https://docs.microsoft.com/en-us/powershell/module/hyper-v/new-vm?view=win10-ps)
[参考2](https://kogelog.com/2018/07/08/20180708-01/)
[参考](https://docs.microsoft.com/ja-jp/powershell/module/hyper-v/set-vmdvddrive?view=win10-ps)


- Hyper-V用のコマンド一覧を表示
```ps1
    Get-Command -Module hyper-v
```
