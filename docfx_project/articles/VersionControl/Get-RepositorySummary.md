# Get-RepositorySummary

*Gets some information about the folder you are currently
in showing some information.*

- Is it a git repository?
- Which remotes does it contain?
- What status is it in?

## Example Nr. 1
Get-RepositorySummary .

We have a concrete path given, so we only show information for one repository.

## Example Nr. 2
Get-ChildItem | Get-RepositorySummary

List all items within the current folder and then get repository information
about it.

## Example Nr. 3
(when the current working directory contains a .git folder)
Get-RepositorySummary

If the current working directory contains a repository only the information
for this repository is shown.

## Example Nr. 4
(when the current working directory does not contain a .git folder)
Get-RepositorySummary

Lists repository summaries for all


<small>To get the full information type PS> `Get-Help .`</small>
