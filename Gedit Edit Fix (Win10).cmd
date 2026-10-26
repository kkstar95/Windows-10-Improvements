@echo off
setlocal EnableExtensions

set "BASE_BAT=HKCR\batfile\shell"
set "BASE_CMD=HKCR\cmdfile\shell"
set "KEY_DEFAULT=edit"
set "KEY_EDIT=Edit"
set "KEY_GEDIT=EditWithGedit"
set "GEDIT=C:\Program Files\gedit\bin\gedit.exe"

:menu
cls
echo.
echo Configure Edit Menu
echo [1] Add "Edit ^> Edit With Gedit"
echo [2] Remove custom Edit submenu
echo [3] Exit
echo ==============================
set "choice="
set /p "choice=Enter choice (1, 2, or 3): "

if "%choice%"=="1" goto add
if "%choice%"=="2" goto remove
if "%choice%"=="3" goto eof

echo Invalid choice. Please try again.
goto menu

:add
echo.
echo Removing default Edit for .bat...
reg delete "%BASE_BAT%\%KEY_DEFAULT%" /f >nul 2>&1

echo Creating Edit submenu for .bat and .cmd...

for %%F in ("%BASE_BAT%" "%BASE_CMD%") do (
    rem Create the parent Edit submenu
    reg add "%%~F\%KEY_EDIT%" /v "MUIVerb" /d "Edit" /f
    reg add "%%~F\%KEY_EDIT%" /v "SubCommands" /d "" /f
    reg add "%%~F\%KEY_EDIT%" /v "Icon" /d "%GEDIT%" /f

    rem Create the Gedit item inside Edit
    reg add "%%~F\%KEY_EDIT%\shell\%KEY_GEDIT%" /v "MUIVerb" /d "Edit With Gedit" /f
    reg add "%%~F\%KEY_EDIT%\shell\%KEY_GEDIT%" /v "Icon" /d "%GEDIT%" /f
    reg add "%%~F\%KEY_EDIT%\shell\%KEY_GEDIT%\command" /ve /d "\"%GEDIT%\" \"%%1\"" /f
)

echo.
echo Done. Restart Explorer to see changes.
pause
goto menu

:remove
echo.
echo Removing custom Edit submenu for .bat and .cmd...

for %%F in ("%BASE_BAT%" "%BASE_CMD%") do (
    reg delete "%%~F\%KEY_EDIT%" /f >nul 2>&1
    echo Removed custom Edit submenu from %%~F
)

echo.
echo Done. Restart Explorer to see changes.
pause
goto menu

:eof
endlocal
exit /b
