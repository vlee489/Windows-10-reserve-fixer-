@echo off
title Windows 10 Missing Icon Fixes
goto foreward
:foreward
color 0b
cls
echo The methods inside this batch modify files and registry settings.
echo While they are tested and tend to work, I take no responsibility for the use of this file.
echo This batch is provided without warranty. Any damage caused is your own responsibility.
echo.
echo As well, batch files are almost always flagged by anti-virus, feel free to review the code if you're unsure.
echo.
echo If you understand the above, and accept - press any key to continue...
pause > NUL
goto elevatecheck
:elevatecheck
color 0c
cls
echo Checking for Administrator elevation...
echo.
echo.
openfiles > NUL 2>&1
if %errorlevel%==0 (
	echo Elevation found! Proceeding...
	goto vercheck
) else (
	echo You are not running as Administrator...
	echo This batch cannot do it's job without elevation!
	echo.
	echo Right-click and select ^'Run as Administrator^' and try again...
	echo.
	echo Press any key to exit...
	pause > NUL
	exit
)
:vercheck
color 0c
cls
echo Performing Pre-Checks...
for /f "tokens=4-5 delims=. " %%i in ('ver') do set version=%%i.%%j
if "%version%"=="6.3" set allow=1
if "%version%"=="6.1" set allow=1
if %allow%==1 goto warning
set allow=0
echo.
echo You did not pass the pre-requisites.
echo If you're running Windows 8, go install Windows 8.1 from the Store.
echo.
echo Press any key to exit.
pause > NUL
exit
:warning
color 0b
cls
echo Warning about qualifications...
echo.
echo.
echo Just because your version checks out, doesn't mean you're eligible for the free upgrade!
echo Notably, the following are not elibile for Windows 10 via Windows Update...
echo.
echo Windows 7 RTM
echo Windows 8
echo Windows 8.1 RTM
echo Windows RT
echo Windows Phone 8.0
echo.
echo Press any key to continue...
pause > NUL
goto menu
:menu
color 0b
cls
echo Main Menu
echo.
echo.
echo 1^) Check Update Status
echo 2^) Quick-Method #1 ^[JC from answers.microsoft.com^]
echo 3^) Quick-Method #2 ^[KevinStevens_845 from answers.microsoft.com^]
echo 4^) Long-Method #1 ^[Yaqub K from answers.microsoft.com^]
echo 5^) EXIT
echo.
set /p mmchoice=Selection: 
if %mmchoice%==1 goto upstatus
if %mmchoice%==2 goto qm1
if %mmchoice%==3 goto qm2
if %mmchoice%==4 goto lm1
if %mmchoice%==5 exit
goto error
:error
color 0C
cls
echo Main Menu - Error!
echo.
echo.
echo You did not enter a valid entry.
echo.
echo Press any key to return to the main menu and try again.
pause > NUL
goto menu
:upstatus
cls
echo Checking for appropriate update installation status...
echo.
echo.
if "%version%"=="6.3" goto upstatus8
if "%version%"=="6.1" goto upstatus7
goto menu
:upstatus8
echo Windows 8^+ detected...
echo.
set upcheck=3035583
echo Checking for update KB%upcheck%...
dism /online /get-packages | findstr %upcheck% > NUL
if %errorlevel%==0 (
	echo Update KB%upcheck% is installed!
	set missupdate=0
) else (
	echo Update KB%upcheck% is missing!
	set missupdate=1
)
echo.
set upcheck=3035583
echo Checking for update KB%upcheck%...
dism /online /get-packages | findstr %upcheck% > NUL
if %errorlevel%==0 (
	echo Update KB%upcheck% is installed!
) else (
	echo Update KB%upcheck% is missing!
	set /a missupdate=%missupdate%+1>NUL
)
echo.
echo.
if %missupdate%==0 (
	echo You are not missing any updates, congratulations!
) else (
	echo You are missing %missupdate% update^(s^).
)
echo Press any key to return to the main menu...
pause > NUL
goto menu
:upstatus7
echo Windows 7 detected...
echo.
set upcheck=3035583
echo Checking for update KB%upcheck%...
dism /online /get-packages | findstr %upcheck% > NUL
if %errorlevel%==0 (
	echo Update KB%upcheck% is installed!
	set missupdate=0
) else (
	echo Update KB%upcheck% is missing!
	set missupdate=1
)
echo.
set upcheck=2952664
echo Checking for update KB%upcheck%...
dism /online /get-packages | findstr %upcheck% > NUL
if %errorlevel%==0 (
	echo Update KB%upcheck% is installed!
) else (
	echo Update KB%upcheck% is missing!
	set /a missupdate=%missupdate%+1>NUL
)
echo.
echo.
if %missupdate%==0 (
	echo You are not missing any updates, congratulations!
) else (
	echo You are missing %missupdate% update^(s^).
)
echo Press any key to return to the main menu...
pause > NUL
goto menu
:qm1
cls
echo Quick-Method #1 ^[JC from answers.microsoft.com^]
echo.
echo.
echo Updating registry...
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\UpgradeExperienceIndicators" /v UpgEx /t REG_SZ /d Green /f
echo Trying to launch notification tray application...
%SystemRoot%\System32\GWX\GWX.exe /taskLaunch
echo.
echo This method is now complete - and is also instant!
echo You should see the Windows 10 icon in your notification tray.
echo If you do not, return to the menu and try another method.
echo.
echo Press any key to return to the main menu...
pause > NUL
goto menu
:qm2
echo Quick-Method #2 ^[KevinStevens_845 from answers.microsoft.com^]
echo.
echo.
echo Trying to launch GWX task...
%SystemRoot%\System32\GWX\GWX.exe /taskLaunch
echo Trying to refresh GWX config...
%SystemRoot%\System32\GWX\GWXConfigManager.exe /RefreshConfig
echo.
echo This method is now complete - but it could take a few minutes.
echo In approximately 10 minutes you should see the Windows 10 icon in your notification tray.
echo If you do not, return to the menu and try another method.
echo.
echo Press any key to return to the main menu...
pause > NUL
goto menu
:lm1
cls
echo Long-Method #1 ^[Yaqub K from answers.microsoft.com^]
echo.
echo.
echo This method can take anywhere from 10 minutes on. 
echo I've had this run up to 40 minutes during my tests...
echo.
echo This will loop for a while but please note...
echo If you see the ^"STATUS^" as anything but ^"RUNNING^", there is something wrong.
echo If that happens, close the batch file and start over. It may take a few times.
echo.
echo Further, due to the way this script was originally written, you may have to re-launch this batch to continue.
echo.
echo If you understand the above, press any key to continue.
pause > NUL
color 0c
cls
echo Work has begun...
REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\UpgradeExperienceIndicators" /v UpgEx | findstr UpgEx
if "%errorlevel%"=="0" goto RunGWX
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Appraiser" /v UtcOnetimeSend /t REG_DWORD /d 1 /f
schtasks /run /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
echo THIS MAY CAUSE A LOOP - CHECK FOR RUNNING STATUS!!! &echo THIS MAY CAUSE A LOOP - CHECK FOR RUNNING STATUS!!! &echo THIS MAY CAUSE A LOOP - CHECK FOR RUNNING STATUS!!!
:CompatCheckRunning
schtasks /query /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
schtasks /query /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | findstr Ready
if not "%errorlevel%"=="0" ping localhost > NUL &goto :CompatCheckRunning
:RunGWX
schtasks /run /TN "\Microsoft\Windows\Setup\gwx\refreshgwxconfig"
color 0b
cls
echo.
echo This method is now complete.
echo Reports show that this could take up to an hour to show the icon.
echo It is also recommended that you reboot your PC if it has not shown up after that hour wait.
echo.
echo If you do not see the notification tray icon, try another method.
echo If you are using this method last, please wait in the Microsoft Answers forums for a new answer.
echo.
echo Press any key to return to the main menu...
pause > NUL
goto menu