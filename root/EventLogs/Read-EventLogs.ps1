function Read-EventLogs {
    [CmdletBinding()]
    param (
        # The Event Log To Read From
        [Parameter(Mandatory)]
        [string]
        $EventLogName,
        # (Optional) Limit the amount of event logs returned. Zero = No Limit
        [Parameter()]
        [int]
        $LimitReturnAmountTo = 0
    )
    begin {
        
        $eventLogReader = New-Object -TypeName "System.Diagnostics.EventLog"($EventLogName)

        $eventCount = $eventLogReader.Entries.Count
        $returnedEventLogs = New-Object System.Collections.Generic.List[string]

    }
    process {
        switch ($LimitReturnAmountTo) {
            0 {  
                for ($i = $eventCount; $i -ge 0; $i--) {
                    $returnedEventLogs.Add($eventLogReader.Entries[$i])
                }
            }
            Default {
                for ($i = ($eventCount - $LimitReturnAmountTo); $i -lt $eventCount; $i++) {
                    $returnedEventLogs.Add($eventLogReader.Entries[$i])
                }
            }
        }

    }
    end {
        return $returnedEventLogs
    }
}
# SIG # Begin signature block
# MIIFtQYJKoZIhvcNAQcCoIIFpjCCBaICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUR8LtuOJuxrXLlxRxRSM+d2BO
# XpSgggM4MIIDNDCCAhygAwIBAgIQNd9rbG4t475DVTZyHDp8SDANBgkqhkiG9w0B
# AQsFADAyMTAwLgYDVQQDDCdaYWNoYXJ5IE1heW5hcmQgLSBEcmVhbWluZyBBYm91
# dCBDbG91ZHMwHhcNMjIwMjE5MTkzODE3WhcNMjMwMjE5MTk1ODE3WjAyMTAwLgYD
# VQQDDCdaYWNoYXJ5IE1heW5hcmQgLSBEcmVhbWluZyBBYm91dCBDbG91ZHMwggEi
# MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC/zOJEkVr5tV9UBLDHPth+gDg3
# tFVYinNiUCUogbZ2OnjdEmKTbVD+yBb5gAtm9jRPlSboiv9A5lC3RJxZWuCp5z2u
# zJGLcIVIIwRIXF1B+bLyfCGl8oOE6anHmKghaRhKnSlJ2t8gOZimC3Y8Hd4Kt41W
# YQCClQkdGyKGlKqGQpnbcVJVtZaPUdfOtqkX1EhOJW9rHF6xW1HwGJOTLsuGlOeI
# cATDP56m1HhjXqjgIx816Lu34kNYjijdY+ictd0lm2gdP09rZ6qHQsU1BHGfxOGO
# M6eF1SnuGNQNdM3i7a/q/3J+G8QpYOr1j7I4g8MJybHb/vnWh9H7cX5/nvmdAgMB
# AAGjRjBEMA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAzAdBgNV
# HQ4EFgQUNHPekNuX2EyMkQ1B+2F2WFDn9WswDQYJKoZIhvcNAQELBQADggEBADYi
# n7H1IWVytW6Z14TqO76GQSeJV30Kbo6PpZT/YNEiMXfZ9Ig1+Vi2N5zF4pIKFhau
# 8qtauGMWnMXyQ5lfGxExQZctMztvG0QGChe/u9nhLxcemfhPG+WZiLp+EwocU3jY
# OzlofT3Lk9KOA1tYIX9wVohG9wD4Xz6138UtFcr7Hk/q9nFhkRVS8KV21OIbkmNG
# Mm9tWX0pPn4q8OW8egY2TjQk8z3UTdidj/LTyqTbfZsZ1TXjvCeUByx3qjiPupaS
# aS2+fJINp1f7SlCwdGCYw7ck2PrppKeNyLLIxrEVubYnt/rd5SnF/gXtxo94auN9
# 5OqUQPsKImN1fbe+c78xggHnMIIB4wIBATBGMDIxMDAuBgNVBAMMJ1phY2hhcnkg
# TWF5bmFyZCAtIERyZWFtaW5nIEFib3V0IENsb3VkcwIQNd9rbG4t475DVTZyHDp8
# SDAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG
# 9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIB
# FTAjBgkqhkiG9w0BCQQxFgQUHq9/tBJtabmVPJZy3rybcvQvaBMwDQYJKoZIhvcN
# AQEBBQAEggEAu10bZ7xwxTNBZr4SSWWB5/N+aocIqY5Y776kw2uqNzhz5L8D5RXE
# xkpFaQyb3x4C2EVX8WGWbqKImVhbzYXpOtZjvpquo6Q2zNdiaKjHN9Jo8URf+Bvd
# 6FN7PRO6HCf8pDS2Q46umzAq+dJ3lFoWRv+HgUKSiepcuoB1wZwsumMi1RjEHKCu
# XqFOyXcVIydbe0AFGroOU+mcCJl5wukYL6bFRf6eGrUDWEnqqLEL8iWq1+wWfWA9
# eaa+r1lHW/mZ1WV39FyyYpppSdI9cs57hks+/gdFaDZgwpSOxYKuPAN3YoQ+iA
# lB7EuafWpXxWM6dxdlHcnZIfDiIANPd3sQ==
# SIG # End signature block
