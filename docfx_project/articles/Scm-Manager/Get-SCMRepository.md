# Get-SCMRepository

*Call to the SCM Manager API and grab a list of all repositories*



## Example Nr. 1
$password = (ConvertTo-SecureString "Password!" -AsPlainText -Force)
Get-SCMRepository -ApiUrl "http://localhost:8080/scm/api/" -Username "Some.User" -Password $password


<small>To get the full information type PS> `Get-Help .`</small>
