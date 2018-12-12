<#

    This script rebuilds the docfx help project 
    from the source code files

#>

Push-Location $PSScriptRoot

. .\PSCore-Tools

# Cleanup!
if (Test-Path .\docfx_project\articles) {
    Remove-Item .\docfx_project\articles -Force -Recurse
}
New-Item -Type Directory .\docfx_project\articles | Out-Null

# Build Markdown
Export-HelpAsMarkdown .\Source\ .\docfx_project\articles | Out-File .\docfx_project\articles\toc.yml -Encoding UTF8

Set-Location .\docfx_project

docfx --serve

Pop-Location