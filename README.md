# PSCore-Tools

A collection of tools, not especially sorted out. Just the things I need. 
You can find a full documentation of all cmdlets here GITHUB PAGES LINK.

## Neat things you can do 

### Get information about all locally checked out git repositories in this folder including some state

```powershell
Get-RepositorySummary
```

### Connect to a Scm-Manager instance and clone all available repositories (using git)

```powershell
$repositories = Get-SCMRepository -ApiUrl "http://localhost:8080/scm/api" -Username "User"
$repositories.url | ForEach-Object { git clone $_ }
```

