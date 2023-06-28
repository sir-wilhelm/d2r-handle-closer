#Requires -RunAsAdministrator
#Requires -Version 7.0

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

        $exeIndex = (Get-Process -Id $d2pid).commandLine.IndexOf("exe")
        Get-Process D2R | Sort-Object -Property CommandLine | ForEach-Object { $_.CommandLine.Substring(0, ($_.CommandLine.Length -gt $exeIndex + 13) ? $exeIndex + 16 : $_.CommandLine.Length) }
    }

    Start-Sleep 10

} while (1)
