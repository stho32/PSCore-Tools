Describe 'Get-RelativePath' {
    It "correctly removes the absolute part of the relative path" {
        $result = Get-RelativePath -Root "C:\Projekte" -InputPath "C:\Projekte\Gumnibear"

        $result | Should -Be ".\Gumnibear"
    }
}