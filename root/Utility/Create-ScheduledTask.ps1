param (
    [Parameter()]
    [string]
    $ScriptPath
    ,
    # Principal to RunAs
    [Parameter(Mandatory = $true)]
    [string]
    $PrincipalName,
    # Task Name
    [Parameter(Mandatory = $true)]
    [string]
    $TaskName,
    # Time To Run
    [Parameter()]
    [ValidateRange(0,24)]
    [int]
    $TimeToRun
)

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-File `"$ScriptPath`""
$trigger = New-ScheduledTaskTrigger -Daily -At ($TimeToRun.ToString() + "am")
$settings = New-ScheduledTaskSettingsSet
$principal = New-ScheduledTaskPrincipal -UserID $PrincipalName -LogonType ServiceAccount -RunLevel Highest
$task = New-ScheduledTask -Action $action -Principal $principal -Settings $settings -Trigger $trigger
Register-ScheduledTask -TaskName $TaskName -InputObject $task