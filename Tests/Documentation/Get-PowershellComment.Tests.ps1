Describe 'Get-PowershellComment' {
    It "grabs all comments from Get-CleanRepository" {
        $comments = Get-PowershellComment -FilePath "../../Source/VersionControl/Get-CleanRepository.ps1"

        $comments | Should -Not -Be $null
    }
}