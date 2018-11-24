<#

   Load my powershell core tools

   stho 11/2018

#>

Write-Host "Hi Stefan, welcome back!" -ForegroundColor Yellow

Set-Location $PSScriptRoot

. ./Get-RepositorySummary.ps1

Pop-Location
