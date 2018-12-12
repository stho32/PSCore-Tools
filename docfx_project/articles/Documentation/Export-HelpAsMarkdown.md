# Export-HelpAsMarkdown

*Crawls a directory recursivly grabbing the help from every Cmdlet-File it finds
and creates a markdown file for it.*

Export-HelpAsMarkdown grabs all .ps1 files in the specified source directory recursivly.

For each one it will create a .md file with the same name in the target directory.

It will extract the powershell help content from the files and convert them into valid markdown.

It will keep the subdirectory structure.

It will create a toc.yml file in the target directory. That file can be used in a documentation
created by docfx to add all newly created files.

## Example Nr. 1
Export-HelpAsMarkdown -Path . -TargetPath .\docfx_project\api

Scans the current path and creates a markdown representation of the help of each Cmdlet-File it finds
within the api folder of the docfx_project.


<small>To get the full information type PS> `Get-Help .`</small>
