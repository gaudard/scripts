@ECHO off

REM
REM Get user's SID and username.




set _reg_query=reg query "hklm\software\microsoft\windows nt\currentversion\profilelist"
set _find_sid=findstr -i "HKEY_LOCAL_MACHINE\software\microsoft\windows nt\currentversion\profilelist\"

FOR /f "tokens=7 delims=\" %%G IN ('%_reg_query% ^| %_find_sid%' ) DO (
	reg query "hklm\software\microsoft\windows nt\currentversion\profilelist\%%G" | FOR /f "tokens=3 delims=\" %%X IN ('findstr -i ProfileImagePath') DO echo %%X	%%G >> userAndSID.txt
)


