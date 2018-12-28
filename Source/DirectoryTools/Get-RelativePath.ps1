function Get-RelativePath {
    <#
        .SYNOPSIS
        Gets a relative path from the absolute path and the root path passed in.

        .DESCRIPTION
        For some purposes you sometimes need to create an equivalent folder or file structure to 
        an existing one. 
        
        E.g. for documentation: 
        There is a folder structure in articles/* and you want to create the same structure beneath 
        images/* so you can place the images in structured way.

        E.g. for unit tests: 
        You want a folder structure that is the same as the folder structure in the base project. 

        .EXAMPLE
        Get-ChildItem -Type Directory | Get-RelativePath -Root "C:\Projects\"

        Creates a list of relative paths related to the root directory you gave it.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Root,
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$InputPath
    )

    process {
        # In Windows we want to be sure to add "\" so we remove it from 
        # relative paths
        if ( $IsWindows ) {
            if ( -not $Root.EndsWith("\") ) {
                Write-Verbose "Adding \ to root..."
                $Root = $Root + "\"
            }
        } else {
            # In Linux and Mac Environments we do the same with "/".
            if ( -not $Root.EndsWith("/") ) {
                $Root = $Root + "/"
            }
        }

        if ( $InputPath.StartsWith( $Root ) ) {
            ".\" + $InputPath.Remove(0, $Root.Length)
        } else {
            throw "The path $InputPath does not belong to root directory $Root. Operation cannot be performed."
        }
    }
}