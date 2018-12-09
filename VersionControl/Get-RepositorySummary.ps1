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

        We have a concrete path given, so we only show information for one repository.

        .EXAMPLE
        Get-ChildItem | Get-RepositorySummary

        List all items within the current folder and then get repository information
        about it.

        .EXAMPLE
        (when the current working directory contains a .git folder)
        Get-RepositorySummary

        If the current working directory contains a repository only the information
        for this repository is shown. 

        .EXAMPLE
        (when the current working directory does not contain a .git folder)
        Get-RepositorySummary

        Lists repository summaries for all 

    #>
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline=$true)]
        [string]$Path
    )
    Begin {}
    Process {
        if ( $Path -ne "" ) {
            <# In case we have a concrete path given #>
            $Output = New-Object PSCustomObject

            Add-Member -InputObject $Output -MemberType NoteProperty -Name Name -Value (Split-Path $Path -leaf) 
            Add-Member -InputObject $Output -MemberType NoteProperty -Name Path -Value $Path
        
            if ( Test-Path "$Path/.git" ) {
                Push-Location $Path
    
                if ( (git remote) -like '*origin*' ) {
                    $remoteOrigin = (git remote get-url origin)
                } else {
                    $remoteOrigin = "origin not found"
                }
    
                $status = (git status)
                $statusIsClean = $status -like "*working tree clean*"
                $usePush = [bool]($status -like "*git push*")
    
                Add-Member -InputObject $Output -MemberType NoteProperty -Name VCS -Value "git"
                Add-Member -InputObject $Output -MemberType NoteProperty -Name RemoteOrigin -Value $remoteOrigin
                Add-Member -InputObject $Output -MemberType NoteProperty -Name HasUncommittedChanges -Value (-not $statusIsClean)
                Add-Member -InputObject $Output -MemberType NoteProperty -Name UsePush -Value $usePush
    
                Pop-Location
            }

            if (Test-Path "$Path/.hg") {
                Push-Location $Path
               
                if ( (hg paths) -like '*default =*' ) {
                    $remoteOrigin = (hg paths default)
                } else {
                    $remoteOrigin = "origin not found"
                }

                $status = (hg status)
                $statusIsClean = $status -eq ""
                $usePush = [bool]((hg summary) -like "*draft*")

                Add-Member -InputObject $Output -MemberType NoteProperty -Name VCS -Value "hg"
                Add-Member -InputObject $Output -MemberType NoteProperty -Name RemoteOrigin -Value $remoteOrigin
                Add-Member -InputObject $Output -MemberType NoteProperty -Name HasUncommittedChanges -Value (-not $statusIsClean)
                Add-Member -InputObject $Output -MemberType NoteProperty -Name UsePush -Value $usePush
            }
            
            $Output 
        } else {
            $Path = (Get-Location).Path
            $VcsPathGit = Join-Path $Path .git
            $VcsPathHg = Join-Path $Path .hg


            if ((Test-Path -Path $VcsPathGit) -or 
                (Test-Path -Path $VcsPathHg) ) {
                Get-RepositorySummary $Path
            } else {
                Get-ChildItem -Directory | Get-RepositorySummary
            }
        }
    }
    End {}
}
