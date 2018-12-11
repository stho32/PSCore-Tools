Describe 'Get-PowershellComment' {
    It "grabs all comments from Get-CleanRepository" {
        $path = Join-Path $PSScriptRoot "../../Source/VersionControl/Get-CleanRepository.ps1"
        $comments = Get-PowershellComment -FilePath $path

        $comments | Should -Not -Be $null
        ($comments | Measure-Object).Count | Should -Be 1
        $comments | Should -BeLike "*SYNOPSIS*"
        $comments | Should -BeLike "*`n*"
    }
}