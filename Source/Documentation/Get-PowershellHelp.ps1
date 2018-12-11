function Get-PowershellHelp {
    <#
        .SYNOPSIS
        Extracts the help content from the first comment of a .ps1

        .DESCRIPTION
        To create our own e.g. markdown representation of powershell help content
        we need the information of the first multiline comment and need to extract
        all those neat little sections.

        .EXAMPLE
        Get-PowershellHelp -FilePath "SomeScript.ps1"

        Grabs the help content as a little object, so you can process it further.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )
    
    process {
        $helpComment = Get-PowershellComment -FilePath $FilePath | Select -First 1

        $synopsis = ""
        $description = ""
        $examples = @()

        $asRows = $helpComment -Split "`n"
        $asRows
    }
}