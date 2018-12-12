function Get-PowershellHelp {
    <#
        .SYNOPSIS
        Extracts the help content from the first comment of a .ps1

        .DESCRIPTION
        To create our own e.g. markdown representation of powershell help content
        we need the information of the first multiline comment and need to extract
        all those neat little sections.

        .EXAMPLE
        Get-PowershellHelp -FilePath "SomeScript.ps1"

        Grabs the help content as a little object, so you can process it further.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )
    
    process {
        $helpComment = Get-PowershellComment -FilePath $FilePath | Select-Object -First 1

        $data = @{
            "synopsis" = "";
            "description" = "";
            "examples" = @();
        }

        $activeState = @{
            "activeTarget" = "";
            "activeContent" = "";
        }

        function StoreInformationForOutput($data, $activeState) {
            if ([System.String]::IsNullOrWhiteSpace($activeState.activeTarget)) {
                return $data
            }

            switch ($activeState.activeTarget) {
                "synopsis"    { 
                    return @{
                        "synopsis"    = $activeState.activeContent.Trim();
                        "description" = $data["description"];
                        "examples"    = $data["examples"];
                    } 
                }
                "description" { 
                    return @{
                        "synopsis" = $data["synopsis"];
                        "description" = $activeState.activeContent.Trim();
                        "examples" = $data["examples"];
                    } 
                }
                "example"     { 
                    return @{
                        "synopsis" = $data["synopsis"];
                        "description" = $data["description"];
                        "examples" = $data["examples"] += $activeState.activeContent.Trim();
                    } 
                }
            }
        }

        function SetNewStorageTarget($activeState, $target) {
            $activeState.activeTarget = $target
            $activeState.activeContent = ""

            return $activeState
        }

        $asRows = $helpComment -Split "`n"
        $asRows | ForEach-Object {
            $activeRow = $_.Trim()

            if ( $activeRow -eq "<#" -or $activeRow -eq "#>") {
                return
            }

            if ( $activeRow -like ".SYNOPSIS" ) {
                $data = StoreInformationForOutput $data $activeState
                $activeState = SetNewStorageTarget $activeState "synopsis" 
                return
            }

            if ( $activeRow -like ".DESCRIPTION" ) {
                $data = StoreInformationForOutput $data $activeState
                $activeState = SetNewStorageTarget $activeState "description" 
                return
            }

            if ( $activeRow -like ".EXAMPLE" ) {
                $data = StoreInformationForOutput $data $activeState
                $activeState = SetNewStorageTarget $activeState "example" 
                return
            }

            $activeState.activeContent += $activeRow + "`n"
        }

        # Store the last element also
        $data = StoreInformationForOutput $data $activeState

        New-Object -TypeName psobject -Property $data
    }
}