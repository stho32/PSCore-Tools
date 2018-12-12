# Get-PowershellHelp

*Extracts the help content from the first comment of a .ps1*

To create our own e.g. markdown representation of powershell help content
we need the information of the first multiline comment and need to extract
all those neat little sections.

## Example Nr. 1
Get-PowershellHelp -FilePath "SomeScript.ps1"

Grabs the help content as a little object, so you can process it further.


<small>To get the full information type PS> `Get-Help .`</small>
