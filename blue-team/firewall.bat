@ECHO off
REM #################################################
REM # Created by @jgaudard  :: I don't twitter much 
REM # Modified by noone
REM # SECURE mgmt systems
REM # Created: 14 June 2016    Edited: never
REM # Version 0.1
REM #################################################


REM initial setup
REM To Disable Group Policy:
REG add "HKCU\Software\Policies\Microsoft\MMC\{8FC0B734-A0E1-11D1-A7D3-0000F87571E3}" /v Restrict_Run /t REG_DWORD /d 1 /f

netsh advfirewall export c:\windows\temp\firewallbak.wfw
ping 127.0.0.1 -n 3 > nul
netsh advfirewall reset
netsh advfirewall set allprofiles state on
netsh advfirewall firewall delete rule name=all

REM deny all
netsh advfirewall set domainprofile firewallpolicy blockinbound,blockoutbound
netsh advfirewall set privateprofile firewallpolicy blockinbound,blockoutbound
netsh advfirewall set publicprofile firewallpolicy blockinbound,blockoutbound
netsh advfirewall set currentprofile firewallpolicy blockinbound,blockoutbound

REM ### Allows active directory and exchange communication, directly from host to ip of server. ###
netsh advfirewall firewall add rule name="DC Comms TCP Ports" dir=out action=allow protocol=TCP remoteport=389,636,3268,3269,88,53,445,25,135,5722,464,9389,139 remoteip=1.2.3.4
netsh advfirewall firewall add rule name="DC Comms TCP Ports" dir=in action=allow protocol=TCP remoteport=389,636,3268,3269,88,53,445,25,135,5722,464,9389,139 remoteip=1.2.3.4

netsh advfirewall firewall add rule name="DC Comms UDP Ports" dir=out action=allow protocol=UDP remoteport=389,88,53,445,123,464,138,67,2535,137 remoteip=1.2.3.4
netsh advfirewall firewall add rule name="DC Comms UDP Ports" dir=in action=allow protocol=UDP remoteport=389,88,53,445,123,464,138,67,2535,137 remoteip=1.2.3.4

netsh advfirewall firewall add rule name="Exchange COMS" dir=out action=allow protocol=TCP remoteport=443,80,143,993,110,995,587 remoteip=1.2.3.4
netsh advfirewall firewall add rule name="Exchange COMS" dir=in action=allow protocol=TCP remoteport=443,80,143,993,110,995,587 remoteip=1.2.3.4

REM ### No Strike List ###     Best to include multiple comma seperated ips to decrese number of rules: 1.2.3.4,10.11.12.13,100.10.100.10
FOR /F %%G in (nostrike.txt) DO (
    netsh advfirewall firewall add rule name="Allow NO STRIKE IPs" dir=out action=allow remoteip=%%G
    netsh advfirewall firewall add rule name="Allow NO STRIKE IPs" dir=in action=allow remoteip=%%G
)

REM ## allow rules, must remove "REM" to enable rule."
REM netsh advfirewall firewall add rule name="RDP" dir=out action=allow protocol=TCP remoteport=3389
REM netsh advfirewall firewall add rule name="SSH" dir=out action=allow protocol=TCP remoteport=22
REM netsh advfirewall firewall add rule name="SMB" dir=out action=allow protocol=TCP remoteport=445
REM netsh advfirewall firewall add rule name="website dir=out action=allow protocol=tcp remoteport=443 remoteip=1.2.3.4

REM enable logging
netsh advfirewall set domainprofile logging droppedconnections enable
netsh advfirewall set publicprofile logging droppedconnections enable
netsh advfirewall set privateprofile logging droppedconnections enable



REM NOTES  This will allow you to "mask" your password when prompted.

@echo off
powershell -Command $pword = read-host "Enter password" -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword) ; ^
        [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR) > .tmp.txt 
set /p password=<.tmp.txt & del .tmp.txt
echo %password%


