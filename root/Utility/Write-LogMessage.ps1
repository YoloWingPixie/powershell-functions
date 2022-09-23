function Write-LogMessage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$LogPath,
        [Parameter(Mandatory=$true)]
        [string]$LogMessage
    )
    $DateTime = Get-Date -Format "yyyy-MM-dd-HH:mm:ss"
    if (! (Test-Path $LogPath) ) {
        New-Item -Path $LogPath -ItemType File -Force
    }
    $LogMessage = "$DateTime | $LogMessage"
    Add-Content -Path $LogPath -Value $LogMessage
}