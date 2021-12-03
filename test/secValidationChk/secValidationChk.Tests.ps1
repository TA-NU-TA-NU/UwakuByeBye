BeforeAll {
    . $PSCommandPath.Replace('test\secValidationChk\secValidationChk.Tests.ps1', 'secValidationChk.ps1') 
}

Describe "secValidationChk Make Instance Test" {
    Context "簡単なテスト" {
        It "sec = 1 except 1" {
            $waitTime = 1
            $obj = [secValidationChk]::new($waitTime)
            $obj.getSecNum() | Should -Be 1
        }
        It "sec = 0 except 0" {
            $waitTime = 0
            $obj = [secValidationChk]::new($waitTime)
            $obj.getSecNum() | Should -Be 0
        }
        It "sec = -1 except 0" {
            $waitTime = -1
            $obj = [secValidationChk]::new($waitTime)
            $obj.getSecNum() | Should -Be 0
        }
    }
}