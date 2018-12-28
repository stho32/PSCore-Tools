function Add-PSCoreToolsToProfile {
    <#
        .SYNOPSIS
        Adds this library to the current users profile, so all commandlets are loaded at startup.

        .EXAMPLE
        Add-PSCToProfile

        Adds this library to your profile. Creates the profile file if it does not exist.
    #>
    [CmdletBinding()]
    param ()
    
    process {
        if ( -not (Test-Path $profile) ) {
            New-Item $profile -ItemType File -Force
        }

        if ($IsWindows) {
            "`nPush-Location `"$PSScriptRoot`"" | Out-File $profile -Append
            "`nSet-Location .." | Out-File $profile -Append
            "`ngit pull" | Out-File $profile -Append
            "`n. .\PSCore-Tools.ps1" | Out-File $profile -Append
            "`nPop-Location"| Out-File $profile -Append
        } else {
            "`nPush-Location `"$PSScriptRoot`"" | Out-File $profile -Append
            "`nSet-Location .." | Out-File $profile -Append
            "`ngit pull" | Out-File $profile -Append
            "`n. ./PSCore-Tools.ps1" | Out-File $profile -Append
            "`nPop-Location"| Out-File $profile -Append
        }
    }    
}