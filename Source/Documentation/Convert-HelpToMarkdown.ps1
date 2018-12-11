function Convert-HelpToMarkdown {
    <#
        .SYNOPSIS
        Converts the help within a powershell code file into a markdown file
        
        .DESCRIPTION
        You have that big bunch of CmdLets written down and it contains all 
        the help one needs, but it is inaccessable because people do not 
        look at the source code and do not really know how to use the 
        powershell help. 
        
        Then you can now generate markdown from the help you already write. 
        That can be used as input files for a docfx-Project and boom you now
        have a website with search capabilities.
        
        One thing that is not so well is that at the moment the CmdLets have 
        to be loaded, so I have access to the Help-Content.
        
        .EXAMPLE
        "C:\Projects\Ps\PsFile.ps1" | Convert-HelpToMarkdown | Out-File "PsFile.md"
        
        Gets the help of "PsFile.ps1", converts it to markdown 
        and saves it by using the name of the CmdLet as File.
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$FilePath
    )
    
    Process {
        $Sourcecode = Get-Content $FilePath
        $Sourcecode
        
        $parsedCode = [System.Management.Automation.Language.Parser]::ParseInput($Sourcecode, [ref]$Null, [ref]$Null)
        $helpContent = $parsedCode.GetHelpContent()
        
        $name = Split-Path $FilePath -LeafBase
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