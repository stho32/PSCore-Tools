function Get-NoRepository {
    <#
        .SYNOPSIS
        Gets the list of paths to subdirectories within the current path that do not contain a repository.

        .DESCRIPTION
        The Cmdlet checks every subdirectory within the current directory and lists all
        subdirectories with their full path which do not contain a git or mercurial repository.

        The aim is to find any of your experiments that you did not create a repository for yet.
        Either get them a repo or remove em.

        .EXAMPLE
        Get-NoRepository
    #>
    [CmdletBinding()]
    param ()
    
    process {
        Get-RepositorySummary | 
            Where-Object { $null -eq $_.VCS } | 
            Select-Object -ExpandProperty Path
    }
}