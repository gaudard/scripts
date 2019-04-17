####################################
#
#  Should loop through mutiple systems and run a command
#  Still in development.
#
#
####################################

$cred = Get-Credential
$hosts = Get-Content hosts.txt

#find scheduled jobs
$command99 = "Get-ChildItem -Path c:\windows\system32\tasks"

#find evil.exe
$command98 = "Get-ChildItem -Path 'c:\program files\vmware\vmware tools' -Filter vmtoold.exe"

$command = "cmd.exe /c c:\programdata\sysmon64.exe -u"
$command1 = "cmd.exe /c c:\programdata\sysmon64.exe -i -n -r -accepteula"

foreach($h in $hosts) {
	write-output "Running command $command"
	invoke-command -computername $h -scriptblock { $command } -credential $cred
	}

################################################################################

$hosts = Get-Content hosts.txt
$script-path = "cmd.exe /c c:\programdata\sysmon64.exe -u"

foreach($h in $hosts) {
	write-output "Running command $command"
	invoke-command -computername $h -FilePath $script-path -credential $cred
	}
