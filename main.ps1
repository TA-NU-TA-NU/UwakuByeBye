$DIR = Get-Location 
$JSONFILE = Join-Path -Path $DIR -ChildPath ".\denyList.json"
$hosts = "C:\Windows\System32\drivers\etc\hosts"

#importClass
$ControllerCls = Join-Path -Path $DIR -ChildPath ".\uwakuByeByeController.ps1"
$ValidationChkCls = Join-Path -Path $DIR -ChildPath ".\secValidationChk.ps1"
. $ControllerCls
. $ValidationChkCls

$controllerObj = [uwakuByeByecontroller]::new($JSONFILE,$hosts)

while ($true){
    $waitTime = Read-Host -Prompt "集中したい時間を1以上の数値で入力してください(単位:分)"
    $validationObj = [secValidationChk]::new($waitTime)
    if( $validationObj.getSecNum() -ne 0 ){
        $waitTime = $validationObj.getSecNum() * 60
        break
    }else{
        Write-Output "数値以外の値が入力されたか、0以下の値を入力しています。`r`n1以上の数値を入力してください"
    }
}

Write-Output "さよならゆーわく…"
Start-Sleep -Seconds 3
Write-Output "よろしくげんじつ"

$controllerObj.addLine()

Start-Sleep -Seconds $waitTime

$controllerObj.deleteLine()
