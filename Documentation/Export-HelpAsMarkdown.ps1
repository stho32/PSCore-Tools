function Export-HelpAsMarkdown {
    <#
        .SYNOPSIS
        Crawls a directory recursivly grabbing the help from every Cmdlet-File it finds 
        and creates a markdown file for it.
        
        .DESCRIPTION
        Export-HelpAsMarkdown grabs all .ps1 files in the specified source directory recursivly. 
        
        For each one it will create a .md file with the same name in the target directory. 
        
        It will extract the powershell help content from the files and convert them into valid markdown.
        
        It will keep the subdirectory structure.
        
        It will create a toc.yml file in the target directory. That file can be used in a documentation
        created by docfx to add all newly created files.
        
        .EXAMPLE
        Export-HelpAsMarkdown -Path . -TargetPath .\docfx_project\api
        
        Scans the current path and creates a markdown representation of the help of each Cmdlet-File it finds
        within the api folder of the docfx_project.
    #>
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Path,
        
        [Parameter(Mandatory=$true)]
        [string]$TargetPath
    )
    
    Process {
        # Convert target path to full path
        Push-Location $TargetPath
        $TargetPath = (Get-Location).Path
        Pop-Location
    
        Push-Location $Path
        # Convert relative paths to full paths
        $Path = (Get-Location).Path
        
        Get-ChildItem -Filter *.ps1 -Recurse | ForEach-Object {
            $fileNameWithoutExtension = $_.Name | Split-Path -LeafBase
            $markdown = Convert-HelpToMarkdown -CmdletName $fileNameWithoutExtension
            
            $relativePathOfSourceFile = ($_.Fullname | Split-Path -Parent).Remove(0, $Path.Length)
            $absolutePathOfTargetFile = Join-Path $TargetPath $relativePathOfSourceFile "$fileNameWithoutExtension.md"

            Write-Host $absolutePathOfTargetFile
            
        }
        
        Pop-Location
    }
}