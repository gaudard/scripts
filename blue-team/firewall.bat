@ECHO off
REM #################################################
REM # Created by @jgaudard  :: I don't twitter much 
REM # SECURE mgmt systems
REM # Created: 14 June 2016    Edited: 1 May 2017
REM # Version 0.9
REM #################################################
REM ### features to add/update
REM 1. check for workgroup/domain
REM 2. check local admin creds
REM 3. options for what to allow
REM 4. block powershell

echo ------------------------------------------------------
echo This will setup a very hardened firewall.
echo You should have removed the system from the domain, 
echo and reset the admin password. If not, ctl + c to exit.
echo ------------------------------------------------------
pause

echo Disabling Group Policy, just in case you didn't remove
echo the system from the domain.
REG add "HKCU\Software\Policies\Microsoft\MMC\{8FC0B734-A0E1-11D1-A7D3-0000F87571E3}" /v Restrict_Run /t REG_DWORD /d 1 /f

echo Backing up current rules to c:\windows\temp\firewallbak.wfw
netsh advfirewall export c:\windows\temp\firewallbak.wfw
ping 127.0.0.1 -n 3 > nul
netsh advfirewall reset
netsh advfirewall set allprofiles state on
netsh advfirewall firewall delete rule name=all

echo Blocking all inbound and outbound traffic.
netsh advfirewall set allprofiles firewallpolicy blockinbound,blockoutbound

echo Enabling logging
netsh advfirewall set allprofiles logging droppedconnections enable


:: ################
:: No Strike List, save to nostrike.txt and run from same dir as firewall.bat (or use absolute path). These will probably include any management websites.
:: ################
echo ------------------------------------------------------
echo Setting up nostrike list, you must have run this from the same directory
echo where nostrike.txt exists with the list of ip addresses.
echo ------------------------------------------------------
pause
FOR /F %%G in (nostrike.txt) DO (
    netsh advfirewall firewall add rule name="No Strike List - outbound" dir=out action=allow remoteip=%%G
    netsh advfirewall firewall add rule name="No Strike List - inbound" dir=in action=allow remoteip=%%G
)



REM ## allow rules, must remove "REM" to enable rule."
REM netsh advfirewall firewall add rule name="RDP" dir=out action=allow protocol=TCP remoteport=3389
REM netsh advfirewall firewall add rule name="SSH" dir=out action=allow protocol=TCP remoteport=22
REM netsh advfirewall firewall add rule name="SMB" dir=out action=allow protocol=TCP remoteport=445
REM netsh advfirewall firewall add rule name="website dir=out action=allow protocol=tcp remoteport=443 remoteip=1.2.3.4

REM ### Allows active directory and exchange communication, directly from host to ip of server. ###
REM netsh advfirewall firewall add rule name="Domain Comms - TCP - outbound" dir=out action=allow protocol=TCP remoteport=389,636,3268,3269,88,53,445,25,135,5722,464,9389,139 remoteip=1.2.3.4
REM netsh advfirewall firewall add rule name="Domain Comms - TCP - inbound " dir=in action=allow protocol=TCP remoteport=389,636,3268,3269,88,53,445,25,135,5722,464,9389,139 remoteip=1.2.3.4
REM netsh advfirewall firewall add rule name="Domain Comms - UDP - outbound" dir=out action=allow protocol=UDP remoteport=389,88,53,445,123,464,138,67,2535,137 remoteip=1.2.3.4
REM netsh advfirewall firewall add rule name="Domain Comms - UDP - inbound" dir=in action=allow protocol=UDP remoteport=389,88,53,445,123,464,138,67,2535,137 remoteip=1.2.3.4
REM netsh advfirewall firewall add rule name="Exchange Comms - TCP - outbound" dir=out action=allow protocol=TCP remoteport=443,80,143,993,110,995,587 remoteip=1.2.3.4
REM netsh advfirewall firewall add rule name="Excange Comms - TCP - inbound" dir=in action=allow protocol=TCP remoteport=443,80,143,993,110,995,587 remoteip=1.2.3.4


REM This will allow you to "mask" your password when prompted.
:: @echo off
:: powershell -Command $pword = read-host "Enter password" -AsSecureString ; ^
::    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword) ; ^
::        [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR) > .tmp.txt 
:: set /p password=<.tmp.txt & del .tmp.txt
:: echo %password%


