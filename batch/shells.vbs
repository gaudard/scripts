set objShell = CreateObject("wscript.Shell")
objShell.run "powershell.exe"
objShell.run "cmd.exe"
objShell.run "python"

REM usage: wscript shells.vbs
REM opens interactive shell, if installed (in the case of python).
