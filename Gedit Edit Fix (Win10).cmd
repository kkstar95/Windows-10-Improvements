@echo off
setlocal
set BASE_BAT=HKCR\batfile\shell
set BASE_CMD=HKCR\cmdfile\shell
set KEY_DEFAULT=edit
set KEY_GEDIT=EditWithGedit

:menu
echo Configure Edit Menu
echo [1] Add "Edit With Gedit" (removes default Edit for .bat)
echo [2] Remove "Edit With Gedit" (for .bat and .cmd)
echo [3] Exit
echo ==============================
set /p choice=Enter choice (1, 2, or 3): 
if "%choice%"=="1" goto add
if "%choice%"=="2" goto remove
if "%choice%"=="3" goto eof
echo Invalid choice. Please try again.
goto menu

:add
echo Removing default Edit for .bat...
reg query "%BASE_BAT%\%KEY_DEFAULT%" >nul 2>&1
if %errorlevel%==0 (
    reg delete "%BASE_BAT%\%KEY_DEFAULT%" /f
    echo Default Edit removed.
) else (
    echo Default Edit key not found, skipping deletion.
)
echo Adding "Edit With Gedit" menu for .bat and .cmd files...
for %%F in ("%BASE_BAT%" "%BASE_CMD%") do (
    reg add "%%F\%KEY_GEDIT%" /v "MUIVerb" /d "Edit With Gedit" /f
    reg add "%%F\%KEY_GEDIT%" /v "Icon" /d "\"C:\Program Files\gedit\bin\gedit.exe\"" /f
    reg add "%%F\%KEY_GEDIT%\command" /ve /d "\"C:\Program Files\gedit\bin\gedit.exe\" \"%%1\"" /f
)
echo Done adding Gedit menu items. Restart Explorer to see changes.
pause
goto menu

:remove
echo Removing "Edit With Gedit" menu items for .bat and .cmd...
for %%F in ("%BASE_BAT%" "%BASE_CMD%") do (
    reg query "%%F\%KEY_GEDIT%" >nul 2>&1
    if %errorlevel%==0 (
        reg delete "%%F\%KEY_GEDIT%" /f
        echo Deleted Gedit menu for %%F
    ) else (
        echo Gedit menu not found for %%F, skipping.
    )
)
echo Done removing menu items. Restart Explorer to see changes.
pause
goto menu
