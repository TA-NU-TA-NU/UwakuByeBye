BeforeAll {
    . $PSCommandPath.Replace('test\uwakuByeByeController\uwakuByeByeController.Tests.ps1', 'uwakuByeByeController.ps1') 
    $DIR = Get-Location 
    $script:JSONFILE = Join-Path -Path $DIR -ChildPath ".\dammy.json"
    $script:hosts = Join-Path -Path $DIR -ChildPath ".\dammyhosts.txt"
}

Describe "uwakuByeByeController Make Instance Test" {
    Context "constractor test" {
        BeforeEach{
            $script:obj = [uwakuByeByeController]::new($JSONFILE,$hosts)
        }
        It "hostsTest" {
            (Get-Content $obj.hosts) | Should -Be "#test"
        }
        It "denyListTest" {
            $obj.denyList.deny[0] | Should -Be "www.dammy.com"
        }
    }

    Context "addLine Test" {
        BeforeEach{
            $obj = [uwakuByeByeController]::new($JSONFILE,$hosts)
            $obj.addLine()
        }
        It "addition to hosts test1" {
            (Select-String -Pattern "www.dammy.com" -Path $hosts).ToString().Split(":")[3] | Should -Be "0.0.0.0 www.dammy.com"
        }
        It "addition to hosts test2" {
            (Select-String -Pattern "www.nothing.co.jp" -Path $hosts).ToString().Split(":")[3] | Should -Be "0.0.0.0 www.nothing.co.jp"
        }
        AfterEach{
            $obj.deleteLine()
        }
    }

    Context "delete Test" {
        BeforeEach{
            $obj = [uwakuByeByeController]::new($JSONFILE,$hosts)
            $obj.addLine()
            $obj.deleteLine()
        }
        It "deleted hosts test1" {
            Select-String -Pattern "www.dammy.com" -Path $hosts | Should -BeNullOrEmpty
        }
        It "deleted hosts test2" {
            Select-String -Pattern "www.nothing.co.jp" -Path $hosts | Should -BeNullOrEmpty
        }
    }
}