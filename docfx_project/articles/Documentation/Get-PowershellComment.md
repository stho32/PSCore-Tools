# Get-PowershellComment

*Grabs all multiline comments from a powershell code file*

We want to generate markdown files containing help. As a first thing
that we need to do, we need to read that help comment at the start
of every file.

Unfortunately this is a rather complex problem. At first I tought you
could simply do a Get-Help on some commandlet and then use the returned object.
Well that doesn't really work for e.g. the examples. The syntax of the Cmdlet
is suddenly a mess. Not to mention, that you can only generate markdowns for
functions that you have loaded into memory...

Then I thought about using that Powershell-Parser that comes with Powershell itself.
Thats way to complicated and I can't really figure out how to simply retrieve me the
stuff I need.

So, last escape: A simple regular expression should help.

## Example Nr. 1
Get-PowershellComment -FilePath ".\SomeScript.ps1"

Grabs a list of all multiline comments from the file.


<small>To get the full information type PS> `Get-Help .`</small>
