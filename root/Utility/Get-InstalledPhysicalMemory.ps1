function Get-InstalledPhysicalMemory {
    param ()
    $installedRam = Get-WmiObject win32_physicalmemory | Select-Object -Property Manufacturer,Banklabel,Configuredclockspeed,Devicelocator,
        @{ Name="Voltage"; 
            Expression={
                [math]::round(($_.MaxVoltage/1000),2)
            }
        }, 
        @{ Name="CapacityGB";
            Expression= {
                [math]::round(($_.Capacity/1gb),1)
            }
        }, PartNumber

    return ,$installedRam
}

