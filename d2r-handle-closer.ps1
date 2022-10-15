#Requires -RunAsAdministrator

if (!(Test-Path handle.exe)) {
    Write-Host "handle.exe not found, make sure it's in script folder."
    exit 1
}

do {

    $handle = .\handle.exe -a -p d2 "Check For Other Instances" -nobanner | Out-String
    if ($handle -match "pid:\s+(?<d2pid>\d+)\s+type:\s+Event\s+(?<eventHandle>\w+):") {
        $d2pid = $matches["d2pid"]
        $eventHandle = $matches["eventHandle"]
        handle -c $eventHandle -p $d2pid -y -nobanner

        Get-Process D2R | Select-Object Path | Write-Host
    }
    
    Start-Sleep 10

} while (1)
