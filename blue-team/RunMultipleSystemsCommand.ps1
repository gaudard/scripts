#############################
#
# Run a command on all of the things
# Requires powershell remoting
# You can also run powershell commands 
# like: "Stop-Process -Name Malware -Force"
#
#############################
$cred = Get-Credential
Invoke-Command -Credential $cred -ScriptBlock { cmd.exe /c c:\programdata\sysmon64.exe -u } -ComputerName host01.domain.local
Invoke-Command -Credential $cred -ScriptBlock { cmd.exe /c c:\programdata\sysmon64.exe -u } -ComputerName host02.domain.local
Invoke-Command -Credential $cred -ScriptBlock { cmd.exe /c c:\programdata\sysmon64.exe -u } -ComputerName host03.domain.local
Invoke-Command -Credential $cred -ScriptBlock { cmd.exe /c c:\programdata\sysmon64.exe -u } -ComputerName host04.domain.local
Invoke-Command -Credential $cred -ScriptBlock { cmd.exe /c c:\programdata\sysmon64.exe -u } -ComputerName host05.domain.local
Invoke-Command -Credential $cred -ScriptBlock { cmd.exe /c c:\programdata\sysmon64.exe -u } -ComputerName host06.domain.local
Invoke-Command -Credential $cred -ScriptBlock { cmd.exe /c c:\programdata\sysmon64.exe -u } -ComputerName host07.domain.local
Invoke-Command -Credential $cred -ScriptBlock { cmd.exe /c c:\programdata\sysmon64.exe -u } -ComputerName host08.domain.local
Invoke-Command -Credential $cred -ScriptBlock { cmd.exe /c c:\programdata\sysmon64.exe -u } -ComputerName host09.domain.local
