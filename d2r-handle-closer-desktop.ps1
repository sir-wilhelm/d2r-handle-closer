#Requires -RunAsAdministrator

param(
    [switch]$NoLoop
)

if (!($env:Path -like "*$PSScriptRoot*")) {
    $env:Path += ";$PSScriptRoot"
}

if (!(Get-Command handle -ErrorAction SilentlyContinue)) {
    "handle.exe not found, make sure it is in path or the same folder as the script."
    exit 1
}

do {

    $handle = handle.exe -a -p d2r "Check For Other Instances" -nobanner | Out-String
    if ($handle -match "pid:\s+(?<d2pid>\d+)\s+type:\s+Event\s+(?<eventHandle>\w+):") {
        $d2pid = $matches["d2pid"]
        $eventHandle = $matches["eventHandle"]
        handle.exe -c $eventHandle -p $d2pid -y -nobanner
    }

    if ($NoLoop) {
        Pause
        break
    }

    Start-Sleep 10

} while (1)
