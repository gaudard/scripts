# By @jgaudard
# Version 1.5
# To run this script:
# From a Administrators Command prompt type "powershell"
# Navigate to the directory where this script is stored.
# Type ".\driveSearch.ps1"
# Follow the script prompts, if you receive an error for ExecutionPolicy:
	# type "Set-ExecutionPolicy unrestricted"

import-module activedirectory


"This powershell script will create a folder for artifacts on this system at c:\temp\username\artifacts. You will then be prompted for the case number, host or IP of the system you wish to search for the file. An output will be displayed with the user's directory, this will allow you to get the last logged on user's id if necessary. You will then receive two outputs for the user's home and profile path, you will need to copy and paste these into the associated prompts. A search is then preformed on the remote system and the home and profile path for the file specified. Wildcards are used in the search, so it is unnecessary to include. AV Logs and a directory structure for the two program files directories are copied to the artifacts folder"

[string]$username = Read-Host "Enter your name. (this will be the name of the folder where your artifacts are stored)"
[string]$case = Read-Host "Enter the case number."
[string]$hostOrIP = Read-Host "Enter the host name or IP address."

Remove-PSDrive -Name "L:\" -erroraction silentlycontinue
New-PSDrive -Name "L" -PSProvider Filesystem -Root "\\$hostOrIP\c$"




get-childitem L:\Users\ | sort-object -property @{Expression={$_.LastWriteTime}; Ascending=$true} | out-default | ft LastWriteTime, Name




[string]$dodiisID = Read-Host "Enter the user's username"
[string]$file = Read-Host "Enter the file to search for."

$userHomeDrive = Get-ADUser -filter {samAccountName -eq $dodiisID} -properties homeDirectory | out-default | ft HomeDirectory
$userProfilePath = Get-ADUser -filter {samAccountName -eq $dodiisID} -properties ProfilePath | out-default | ft ProfilePath

$logDir = "c:\temp\$username\artifacts\$case\"
$avLogDir = "L:\ProgramData\McAfee\DesktopProtection"

$userHomeDrive
$userProfilePath

"Use the above home directory and profile path"

[string]$userHomeDrive1 = Read-Host "Enter the Home Directory Path."
[string]$userProfilePath1 = Read-Host "Enter the ProfilePath."


Remove-PSDrive -Name "M:\" -erroraction silentlycontinue
Remove-PSDrive -Name "N:\" -erroraction silentlycontinue


New-PSDrive -Name "M" -PSProvider Filesystem -Root $userHomeDrive1
New-PSDrive -Name "N" -PSProvider Filesystem -Root $userProfilePath1

if(!(Test-Path -Path $logDir\avlogs )){
    New-Item -ItemType directory -Path $logDir\avlogs
}

$searchHomeTxt = "Searching the User's Home Directory ($userHomeDrive1) for ($file)"
$searchHomeTxt
$searchHomeTxt | Out-File "$logDir\analysisLog.txt" -Append
get-childitem M:\* -include *$file* -recurse -force -erroraction silentlycontinue  | out-file $logDir\homeDriveSearch.txt

$searchProfileTxt = "Searching the User's Profile Directory ($userProfilePath1) for ($file)"
$searchProfileTxt
$searchProfileTxt | Out-File "$logDir\analysisLog.txt" -Append
get-childitem N:\* -include *$file* -recurse -force -erroraction silentlycontinue | out-file $logDir\profileDriveSearch.txt

$copyAvLogsTxt = "Copying AV Logs from ($hostOrIP) ($avLogDir)"
$copyAvLogsTxt
$copyAvLogsTxt | Out-File "$logDir\analysisLog.txt" -Append
get-childitem $avLogDir *.txt | copy-item -destination $logDir\avlogs\

$searchProgramFiles = "Output of Program Files directory structure for ($hostOrIP)"
$searchProgramFiles
$searchProgramFiles | Out-File "$logDir\analysisLog.txt" -Append
get-childitem "L:\Program Files" | sort-object -property @{Expression={$_.LastWriteTime}; Ascending=$true} | out-file $logDir\ProgramFiles.txt
get-childitem "L:\Program Files (x86)" | sort-object -property @{Expression={$_.LastWriteTime}; Ascending=$true} | out-file "$logDir\ProgramFiles(x86).txt"


$searchHostTxt = "Searching the host ($hostOrIP) for ($file)"
$searchHostTxt
"This may take several minutes"
$searchHostTxt| Out-File "$logDir\analysisLog.txt" -Append
get-childitem L:\* -include *$file* -recurse -force -erroraction silentlycontinue | out-file $logDir\hostDriveSearch.txt
