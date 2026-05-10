@echo off
setlocal

:menu
cls
echo Rename Edit Menu
echo.
echo [1] Rename Edit to "Edit with Notepad"
echo [2] Restore default Edit name
echo [3] Exit
echo.
set /p choice=Enter choice:
if "%choice%"=="1" goto rename
if "%choice%"=="2" goto restore
if "%choice%"=="3" goto exit
goto menu

:rename
echo Renaming default Edit to "Edit with Notepad"...
reg add "HKCR\txtfile\shell\edit" /v "MUIVerb" /d "Edit with Notepad" /f
reg add "HKCR\txtfile\shell\edit" /v "Icon" /d "write.exe" /f
reg add "HKCR\batfile\shell\edit\command" /ve /d "notepad.exe \"%%1\"" /f
reg add "HKCR\batfile\shell\edit" /v "MUIVerb" /d "Edit with Notepad" /f
reg add "HKCR\batfile\shell\edit" /v "Icon" /d "write.exe" /f
reg add "HKCR\cmdfile\shell\edit\command" /ve /d "notepad.exe \"%%1\"" /f
reg add "HKCR\cmdfile\shell\edit" /v "MUIVerb" /d "Edit with Notepad" /f
reg add "HKCR\cmdfile\shell\edit" /v "Icon" /d "write.exe" /f
echo Done! Right-click Edit menu renamed with Write icon.
pause
goto menu

:restore
echo Restoring default Edit name...
reg add "HKCR\txtfile\shell\edit" /v "MUIVerb" /d "Edit" /f
reg delete "HKCR\txtfile\shell\edit" /v "Icon" /f
reg add "HKCR\batfile\shell\edit" /v "MUIVerb" /d "Edit" /f
reg delete "HKCR\batfile\shell\edit" /v "Icon" /f
reg add "HKCR\cmdfile\shell\edit" /v "MUIVerb" /d "Edit" /f
reg delete "HKCR\cmdfile\shell\edit" /v "Icon" /f
echo Done! Right-click Edit menu restored.
pause
goto menu

:exit
exit