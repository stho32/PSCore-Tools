# Get-NoRepository

*Gets the list of paths to subdirectories within the current path that do not contain a repository.*

The Cmdlet checks every subdirectory within the current directory and lists all
subdirectories with their full path which do not contain a git or mercurial repository.

The aim is to find any of your experiments that you did not create a repository for yet.
Either get them a repo or remove em.

## Example Nr. 1
Get-NoRepository


<small>To get the full information type PS> `Get-Help .`</small>
