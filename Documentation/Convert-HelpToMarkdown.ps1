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
        Get-Help Get-Service | Convert-HelpToMarkdown | Out-File "Get-Service.md"
        
        Gets the help of "Get-Service", converts it to markdown 
        and saves it by using the name of the CmdLet as File.
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true, PropertyValueByPipeline=$true)]
        [PSObject]$HelpInfo
    )
    
    Process {
        "# $($HelpInfo.Name)
         
         $($HelpInfo.Synopsis)

         $($HelpInfo.Syntax)
         
         "
         
        if ( $null -ne $Help.Details.Description ) {
            "## Beschreibung
             
             $($Help.Details.Description)
            "
        }
        
        if ( $null -ne $Help.Examples ) {
            "## Beispiele
            "
            
            $Help.Examples
        }
    }
}