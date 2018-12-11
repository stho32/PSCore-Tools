<#
    Run Powershell Tests of this module
    
    You could need an Pester Update : 
    Install-Module -Name Pester -Force -SkipPublisherCheck
#>

Import-Module Pester

Push-Location $PSScriptRoot

. ./PSCore-Tools.ps1

Invoke-Pester -Path "./Tests"

#$filesToCover = Get-ChildItem .\Source -File -Recurse -Include *.ps1
#Invoke-Pester -Path "./Tests" -CodeCoverage $filesToCover

Pop-Location