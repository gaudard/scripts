#################################################
# Created by @jgaudard  :: I don't twitter much 
# Loop echos text to a file, archives it, then waits 3 minutes
# Created: 13 July 2016    Edited: 
# Version 1.0
#################################################

@ECHO OFF
setlocal enabledelayedexpansion

:start
for /F "tokens=1-2 delims=:" %%x in ("%time%") do (
	set /a starttime=%%x%%y
)

echo testing > file1.txt                  REM doing things
echo still testing > file2.txt            REM and more things
echo still more testing > file3.txt       REM lots of work ya'no

ping 127.0.0.1 -n 5 > nul                 REM wait 5 just to be safe 

"c:\program files\7-zip\7z.exe" a archive_%starttime%.zip file*.txt REM archive

ping 127.0.0.1 -n 5 > nul                 REM wait 5 just to be safe

del file*.txt /F                          REM delete your trash

:wait
for /F "tokens=1-2 delims=:" %%x in ("%time%") do (
	set /a endtime=%%x%%y
)

set /a difference=( !endtime! - !starttime! )    REM maths

IF !difference! LSS 3 (                   REM check ~3 minutes have passed
	ping 127.0.0.1 -n 30 >nul
	GOTO :wait
) ELSE GOTO :start
