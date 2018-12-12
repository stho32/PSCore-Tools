# Convert-HelpToMarkdown

*Converts the help within a powershell code file into a markdown file*

You have that big bunch of CmdLets written down and it contains all
the help one needs, but it is inaccessable because people do not
look at the source code and do not really know how to use the
powershell help.

Then you can now generate markdown from the help you already write.
That can be used as input files for a docfx-Project and boom you now
have a website with search capabilities.

One thing that is not so well is that at the moment the CmdLets have
to be loaded, so I have access to the Help-Content.

## Example Nr. 1
"C:\Projects\Ps\PsFile.ps1" | Convert-HelpToMarkdown | Out-File "PsFile.md"

Gets the help of "PsFile.ps1", converts it to markdown
and saves it by using the name of the CmdLet as File.


<small>To get the full information type PS> `Get-Help .`</small>
