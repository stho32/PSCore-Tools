Describe 'Get-PowershellHelp' {
    It "grabs the help content correctly from Get-CleanRepository" {
        $path = Join-Path $PSScriptRoot "../../Source/VersionControl/Get-CleanRepository.ps1"
        $helpContent = Get-PowershellHelp -FilePath $path

        $helpContent | Should -Not -Be $null

        $helpContent.Synopsis | Should -Be "Gets a list of paths of all clean repositories in the current path."
        $helpContent.Description | Should -Be "The CmdLet checks all repositories for needed commits and pushs.`nIf there aren't any, it will return the path.`nThis can be passed to another cmdlet like Remove-Item to e.g. clean up`nthe workspace."
        $helpContent.Examples.Length | Should -Be 1
        $helpContent.Examples[0] | Should -Be "Get-CleanRepository | Remove-Item -Force -Recurse"
    }
}