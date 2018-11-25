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
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [string]$Path
    )
    Begin {}
    Process {
        $Output = New-Object PSCustomObject

        Add-Member -InputObject $Output -MemberType NoteProperty -Name Name -Value (Split-Path $Path -leaf) 
        Add-Member -InputObject $Output -MemberType NoteProperty -Name Path -Value $Path
    
        if ( Test-Path "$Path/.git" ) {
            Push-Location $Path

            $remoteOrigin = (git remote get-url origin)
            $statusIsClean = (git status) -like "*working tree clean*"

            Add-Member -InputObject $Output -MemberType NoteProperty -Name VCS -Value "git"
            Add-Member -InputObject $Output -MemberType NoteProperty -Name RemoteOrigin -Value $remoteOrigin
            Add-Member -InputObject $Output -MemberType NoteProperty -Name HasUncommittedChanges -Value (-not $statusIsClean)

            Pop-Location
        }
        
        $Output 
    }
    End {}
}
