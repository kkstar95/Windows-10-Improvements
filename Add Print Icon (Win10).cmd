@echo off
setlocal

:menu
cls
echo Add Print Icon to Print Option
echo.
echo [1] Add print icon to Print option
echo [2] Remove print icon from Print option
echo [3] Exit
echo.
set /p choice=Enter choice:
if "%choice%"=="1" goto add
if "%choice%"=="2" goto remove
if "%choice%"=="3" goto exit
goto menu

:add
echo Adding print icon to Print option...
reg add "HKCR\txtfile\shell\print" /v "Icon" /d "shell32.dll,16" /f
reg add "HKCR\batfile\shell\print" /v "Icon" /d "shell32.dll,16" /f
reg add "HKCR\cmdfile\shell\print" /v "Icon" /d "shell32.dll,16" /f
echo Done! Print icon added to Print option.
pause
goto menu

:remove
echo Removing print icon from Print option...
reg delete "HKCR\txtfile\shell\print" /v "Icon" /f
reg delete "HKCR\batfile\shell\print" /v "Icon" /f
reg delete "HKCR\cmdfile\shell\print" /v "Icon" /f
echo Done! Print icon removed from Print option.
pause
goto menu

:exit
exit