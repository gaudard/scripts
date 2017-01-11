function Invoke-ParentalKilling {
  $a = [System.Diagnostics.Process]::GetCurrentProcess()  ## process id of spawned powershell process
  $b = gwmi win32_process | select Name,ProcessID,ParentProcessID | Where-Object {$_.ProcessID -contains $a.ID}
  $c = $b.ParentProcessID  ## process id of current shell
  $d = gwmi win32_process | select Name,ProcessID,ParentProcessID | Where-Object {$_.ProcessID -contains $c}
  $e = $d.ParentProcessID  ## parent pid of current shell (how I got on)
  $f = gwmi win32_process | select Name,ProcessID,ParentProcessID | Where-Object {$_.ProcessID -contains $e}
  If ($f.Name -like "cmd.exe") {
      Stop-Process -id $f.ProcessID
      Write-Host "Killed: $f"
  }ElseIf ($f.Name -like "winexesvc.exe") {
      Stop-Process -id $f.ProcessID
      Write-Host "Killed: $f"
  }ElseIf ($f.Name -like "powershell.exe") {
      Stop-Process -id $f.ProcessID
      Write-Host "Killed: $f"
}}
