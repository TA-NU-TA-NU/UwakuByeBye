class uwakuByeByeController{
   # 静的プロパティ
   $denyList
   [String]$hosts

   # コンストラクター
   uwakuByeByeController ([String] $json,[String] $hosts){
       $this.denyList = Get-Content $json -Encoding UTF8 -raw | ConvertFrom-Json
       $this.hosts = $hosts       
   }

   # add
   [void]addLine(){
       [String]$strBuilder = "#Added by uwakuByeByeController`r`n"
       for ($i = 0; $i -lt $this.denyList.deny.Count; $i++){ 
           $strBuilder += "0.0.0.0 " + $this.denyList.deny[$i] + "`r`n"
       }
        
       $strBuilder += "#End of Section by uwakuByeByeController`r`n" 
       $strBuilder | Out-File $this.hosts -Encoding UTF8 -Append
   }

   # delete
   [void]deleteLine(){
       $start =  (Select-String -Pattern "#Added by uwakuByeByeController" -Path $this.hosts).ToString().Split(":")[2]
       $end = (Select-String -Pattern "#End of Section by uwakuByeByeController" -Path $this.hosts).ToString().Split(":")[2]
       $strBuilder = Get-Content -Path $this.hosts -Encoding UTF8 | Select-Object -First ($start-1)
       $leftStrBuilder = Get-Content -Path $this.hosts -Encoding UTF8 | Select-Object -Skip $end
       for ($i = 0; $i -lt $leftStrBuilder.Length; $i++){ 
           $strBuilder += $leftStrBuilder[$i] + "`r`n"
       }

       $strBuilder | Out-File $this.hosts -Encoding UTF8

   }

}