# クラスを定義します
class secValidationChk{
   [int] $secNum

   secValidationChk([int]$sec){
       if($this.setSecNum($sec) -eq $false){
           $this.secNum = 0
       }else{
           $this.secNum = $sec
       }       
   }

   [int] getSecNum(){
       return $this.secNum
   }

   [boolean] setSecNum([int]$sec){
       if ($sec -isnot [int32]){return $false}
       if ($sec -lt 1){return $false}
       return $true
   }

}