function Write-LogMessage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$LogFile,
        [Parameter(Mandatory=$true)]
        [string]$LogMessage
    )
    $DateTime = Get-Date -Format "yyyy-MM-dd-HH:mm:ss"
    if (! (Test-Path $LogFile) ) {
        New-Item -Path $LogFile -ItemType File -Force
    }
    $LogMessage = "$DateTime | $LogMessage"
    Add-Content -Path $LogFile -Value $LogMessage
    Write-Output $LogMessage
}
