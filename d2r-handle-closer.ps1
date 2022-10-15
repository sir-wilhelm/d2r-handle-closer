#Requires -RunAsAdministrator

$handleInPath = get-command handle -ErrorAction Ignore
$handleApp = get-item handle.exe -ErrorAction Ignore
if (!$handleInPath -and !$handleApp) {
    Write-Host "handle.exe not found, make sure it's in the PATH or script folder."
    exit 1
}

if ($handleApp) {
    $env:Path += ";$($handleApp.Directory)"
}

do {

$handle = handle -a -p d2 "Check For Other Instances" -nobanner | Out-String
if ($handle -match "pid:\s+(?<d2pid>\d+)\s+type:\s+Event\s+(?<eventHandle>\w+):") {
    $d2pid = $matches["d2pid"]
    $eventHandle = $matches["eventHandle"]
    handle -c $eventHandle -p $d2pid -y -nobanner
}

Start-Sleep 10
} while (1)
