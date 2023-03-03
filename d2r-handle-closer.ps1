#Requires -RunAsAdministrator

if (!(Test-Path handle.exe)) {
    "handle.exe not found, make sure it is in the same folder as the script."
    exit 1
}

do {

    $handle = .\handle.exe -a -p d2r "Check For Other Instances" -nobanner | Out-String
    if ($handle -match "pid:\s+(?<d2pid>\d+)\s+type:\s+Event\s+(?<eventHandle>\w+):") {
        $d2pid = $matches["d2pid"]
        $eventHandle = $matches["eventHandle"]
        .\handle.exe -c $eventHandle -p $d2pid -y -nobanner

        Get-Process D2R | Select-Object Path | Sort-Object -Property Path | Out-Host
    }

    Start-Sleep 10

} while (1)
