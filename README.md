# D2r handle closer

[d2r-handle-closer.ps1][d2r-handle-closer.ps1] closes "Check For Other Instance" handles from d2r.exe processes.
After starting the script it says running checking/closing handles every 10 seconds.

[Handle.exe][handle] is required for the script to run and must be downloaded from Microsoft/extracted to the same
folder as `d2r-handle-closer.ps1`.

## How it works

The script runs in a loop (every 10 seconds) and scans for d2r instances with open "Check For Other Instances" handles.

The command to find the open handles using handle.exe is:
```
> .\handle.exe -a -p d2r "Check For Other Instances" -nobanner
D2R.exe            pid: 110040 type: Event          7E8: \Sessions\1\BaseNamedObjects\DiabloII Check For Other Instances
```
You can then use handle.exe along with the pid and event from the prior call to close the handle:
```
> .\handle.exe -c 7E8 -p 110040 -y -nobanner
  7E8: Event         \Sessions\1\BaseNamedObjects\DiabloII Check For Other Instances

Handle closed.
```

When an open handle is found the script uses RegEx to pull the pid/event out of the serach result and
then passes them into the close handle call.

## How to run

Download [d2r-handle-closer.ps1][d2r-handle-closer.ps1]/[Handle.exe][handle] and put them in the same folder.
Run an administrative PowerShell prompt and navigate to the folder where the files are
(ex: `cd D:\src\d2r-handle-closer`).

You might have to run `Unblock-File .\d2r-handle-closer.ps1` before your PC will allow you to run it
(only needs to be done once). You will also have to run `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`
if this is the first time you are running PowerShell Scritps. You can read more about Executionpolicy from Microsoft
[here](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies).

Then just run the script Ex:
```
PS D:\src\d2r-handle-closer> .\d2r-handle-closer.ps1
  794: Event         \Sessions\1\BaseNamedObjects\DiabloII Check For Other Instances

Handle closed.
@{Path=D:\Games\Battle.net\Diablo II Resurrected - 1\D2R.exe}
  79C: Event         \Sessions\1\BaseNamedObjects\DiabloII Check For Other Instances

Handle closed.
@{Path=D:\Games\Battle.net\Diablo II Resurrected - 1\D2R.exe}
@{Path=D:\Games\Battle.net\Diablo II Resurrected - 2\D2R.exe}
  7A0: Event         \Sessions\1\BaseNamedObjects\DiabloII Check For Other Instances

Handle closed.
@{Path=D:\Games\Battle.net\Diablo II Resurrected - 1\D2R.exe}
@{Path=D:\Games\Battle.net\Diablo II Resurrected - 2\D2R.exe}
@{Path=D:\Games\Battle.net\Diablo II Resurrected - 3\D2R.exe}
```

To stop press `Ctrl + c` or close PowerShell.

## Core isolation popup

If you get a security warning pops that says to:
> A driver cannot load on this device
> Driver: procexp152.sys

Make sure you have the latest version of handle.exe

# License

[MIT License](/LICENSE)

[handle]: https://learn.microsoft.com/en-us/sysinternals/downloads/handle
[d2r-handle-closer.ps1]: /d2r-handle-closer.ps1?raw=1
