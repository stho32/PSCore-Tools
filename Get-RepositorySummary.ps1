<#

    This tool gets a summary of information about the repository/folder
    it looks at.

    stho, 11/2018

#>

function Get-RepositorySummary{
    <#
        .SYNOPSIS
        Gets some information about the folder you are currently
        in showing some information. 

        .DESCRIPTION
        
          - Is it a git repository?
          - Which remotes does it contain?
          - What status is it in?

        .EXAMPLE

        Get-RepositorySummary .
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    Begin {}
    Process {
        $Output = New-Object PSCustomObject
    
        if ( Test-Path "$Path/.git" ) {
            Add-Member -InputObject $Output -MemberType NoteProperty -Name VCS -Value "git"
            $remoteOrigin = (git remote get-url origin)
            Add-Member -InputObject $Output -MemberType NoteProperty -Name RemoteOrigin -Value $remoteOrigin
        }
        
        $Output 
    }
    End {}
}
