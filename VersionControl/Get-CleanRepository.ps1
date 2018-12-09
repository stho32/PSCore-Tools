function Get-CleanRepository {
    <#
        .SYNOPSIS
        Gets a list of paths of all clean repositories in the current path.

        .DESCRIPTION
        The CmdLet checks all repositories for needed commits and pushs.
        If there aren't any, it will return the path. 
        This can be passed to another cmdlet like Remove-Item to e.g. clean up
        the workspace.

        .EXAMPLE
        Get-CleanRepository | Remove-Item -Force -Recurse
    #>
    [CmdletBinding()]
    param (
    )
    
    process {
        Get-RepositorySummary | 
            Where-Object { ($_.HasUncommittedChanges -eq $false) -and
                           ($_.UsePush -eq $false) } | 
            Select-Object -ExpandProperty Path
    }
}