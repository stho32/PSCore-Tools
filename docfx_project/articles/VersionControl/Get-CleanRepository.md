# Get-CleanRepository

*Gets a list of paths of all clean repositories in the current path.*

The CmdLet checks all repositories for needed commits and pushs.
If there aren't any, it will return the path.
This can be passed to another cmdlet like Remove-Item to e.g. clean up
the workspace.

## Example Nr. 1
Get-CleanRepository | Remove-Item -Force -Recurse


<small>To get the full information type PS> `Get-Help .`</small>
