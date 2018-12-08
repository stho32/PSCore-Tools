function Get-SCMRepository {
    <#
        .SYNOPSIS
        Call to the SCM Manager API and grab a list of all repositories

        .EXAMPLE
        $password = (ConvertTo-SecureString "geronimo3d!" -AsPlainText -Force)
        Get-SCMRepository -ApiUrl "http://localhost:8080/scm/api/" -Username "Stefan.Hoffmann" -Password $password
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiUrl,
        [Parameter(Mandatory=$true)]
        [string]$Username,
        [Parameter(Mandatory=$false)]
        [securestring]$Password
    )
    
    begin {
    }
    
    process {
        if ( !$ApiUrl.EndsWith("/") ) {
            $ApiUrl += "/"
        }

        if ( -not $Password ) {
            $Password = Read-Host "Enter password" -AsSecureString
        } 
        $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username, $Password
    
        Invoke-RestMethod -Uri ($ApiUrl + "rest/repositories") -Authentication Basic -Credential $Credential -AllowUnencryptedAuthentication -Headers @{"accept"="application/json"}
    }
    
    end {
    }
}
