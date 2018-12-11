Describe 'Get-PowershellHelp' {
    It "grabs the help content correctly from Get-CleanRepository" {
        $path = Join-Path $PSScriptRoot "../../Source/VersionControl/Get-CleanRepository.ps1"
        $helpContent = Get-PowershellHelp -FilePath $path

        $helpContent | Should -Not -Be $null
        
        $lineNumber = 1
        $helpContent | ForEach-Object {
            Write-Host "$lineNumber : $_" 
            $lineNumber += 1
        }
    }
}