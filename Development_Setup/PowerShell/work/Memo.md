# PowerShell

## 概要

マイクロソフトが開発した拡張可能なコマンドラインインターフェイス (CLI) シェルおよびスクリプト言語  
オブジェクト指向シェルであり、テキスト思考シェルのsh,bash等々とは考え方が大きく異なる。

## コマンドの特徴

コマンド体系として、"動詞-目的語"の構造を持っているため、自作の関数についてもそれに習うのが良い。

## 変数

変数は"$"マークで始める

```powershell
$number = 1
$text = "文字列"
```

### リスト

他のプログラミング言語と同等

```powershell
$list = @("value1", "value2", "value3")
```

### ハッシュテーブル

他のプログラミング言語の辞書と同等

```powershell
    $hash_table = @{
    key1 = "value1"
    key2 = "value2"
    key3 = "value3"
    }
```

## 基本構文

### for文

```powershell
foreach ($i in $list) {
        Write-Host $i
    }
```

### if文

```powershell
if(a==1){
    Write-Host "a==1"
}else{
    Write-Host "a!=1"
}
```

### 関数宣言

```powershell

function Write-Text {
    param (
        $text
    )
    Write-Host $text
    }
## 省略形
function Write-Text($text){
    Write-Host $text
}

```

## パイプの利用

## httpリクエスト

### Invoke-WebRequest

httpリクエスト行い、データを取得するコマンド。ファイルの取得等での利用で使いやすい。

### Invoke-Restmethod

RESTapiのコールで使いやすい。  
取得したjsonやxmlのデータを自動的にパースしてPowershellのオブジェクトに変換する。
