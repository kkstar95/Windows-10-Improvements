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
reg add "HKCR\batfile\shell\Edit" /v "MUIVerb" /d "Edit" /f
reg add "HKCR\batfile\shell\Edit" /v "SubCommands" /d "" /f
reg add "HKCR\batfile\shell\Edit\shell\EditWithNotepad" /v "MUIVerb" /d "Edit with Notepad" /f
reg add "HKCR\batfile\shell\Edit\shell\EditWithNotepad" /v "Icon" /d "write.exe" /f
reg add "HKCR\batfile\shell\Edit\shell\EditWithNotepad\command" /ve /d "notepad.exe \"%%1\"" /f
reg add "HKCR\cmdfile\shell\Edit" /v "MUIVerb" /d "Edit" /f
reg add "HKCR\cmdfile\shell\Edit" /v "SubCommands" /d "" /f
reg add "HKCR\cmdfile\shell\Edit\shell\EditWithNotepad" /v "MUIVerb" /d "Edit with Notepad" /f
reg add "HKCR\cmdfile\shell\Edit\shell\EditWithNotepad" /v "Icon" /d "write.exe" /f
reg add "HKCR\cmdfile\shell\Edit\shell\EditWithNotepad\command" /ve /d "notepad.exe \"%%1\"" /f
echo Done! Right-click Edit > Edit with Notepad.
pause
goto menu

:restore
echo Restoring default Edit name...
reg add "HKCR\txtfile\shell\edit" /v "MUIVerb" /d "Edit" /f
reg delete "HKCR\txtfile\shell\edit" /v "Icon" /f
reg delete "HKCR\batfile\shell\Edit" /f
reg delete "HKCR\cmdfile\shell\Edit" /f
echo Done! Custom Edit submenu removed for .bat and .cmd files.
pause
goto menu

:exit
exit
