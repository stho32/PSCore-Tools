<#

   Load my powershell core tools

   stho 11/2018

#>

Write-Host "Hi Stefan, welcome back!" -ForegroundColor Yellow

function Update-PSCoreTools {
    <#
        This function reloads the functions within this 
        "module" (which is not a real ps module yet) so 
        that changes can be applied quicker.
    #>
    Push-Location $PSScriptRoot/Source

    Get-ChildItem -Filter "*.ps1" -Recurse | ForEach-Object {
        Write-Host "Loading $($_.Name) ..."
        . $_
    }
    
    Pop-Location
}

. Update-PSCoreTools