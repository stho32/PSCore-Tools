function Convert-HelpToMarkdown {
    <#
        .SYNOPSIS
        Converts the help of a CmdLet into a markdown file
        
        .DESCRIPTION
        You have that big bunch of CmdLets written down and it contains all 
        the help one needs, but it is inaccessable because people do not 
        look at the source code and do not really know how to use the 
        powershell help. 
        
        Then you can now generate markdown from the help you already write. 
        That can be used as input files for a docfx-Project and boom you now
        have a website with search capabilities.
        
        .EXAMPLE
        "Get-Service" | Convert-HelpToMarkdown | Out-File "Get-Service.md"
        
        Gets the help of "Get-Service", converts it to markdown 
        and saves it by using the name of the CmdLet as File.
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$CmdletName
    )
    
    Process {
        $Sourcecode = (Get-Command $CmdletName).ScriptBlock
        
        $parsedCode = [System.Management.Automation.Language.Parser]::ParseInput($Sourcecode, [ref]$Null, [ref]$Null)
        $helpContent = $parsedCode.GetHelpContent()
        
        $name = (Get-Help $CmdletName).Name
        $synopsis = ($helpContent.Synopsis).Trim()
        $description = ($helpContent.Description).Trim()
        $examples = $helpContent.Examples
        
        Write-Output "# $name"
        Write-Output ""
        Write-Output "*$synopsis*"
        Write-Output ""
        Write-Output $description
        
        $exampleNr = 1;
        $examples | Foreach-Object {
            Write-Output ""
            Write-Output "## Example Nr. $exampleNr"
            Write-Output $_
            
            $exampleNr += 1
        }
        
        Write-Output ""
        Write-Output ""
        Write-Output "<small>To get the full information type PS> ```Get-Help $CmdletName.```</small>"
    }
}