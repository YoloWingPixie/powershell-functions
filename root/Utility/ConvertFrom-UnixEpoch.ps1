function ConvertFrom-UnixEpoch {
    [CmdletBinding()]
    param (
        # Time in Epoch Unix Time
        [Parameter(Mandatory)]
        [int]
        $EpochTime
    )
    
    begin {
        
    }
    
    process {
        return ([System.DateTimeOffset]::FromUnixTimeSeconds($EpochTime)).DateTime
    }
    
    end {
        
    }
}