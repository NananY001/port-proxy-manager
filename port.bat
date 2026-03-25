@echo off
chcp 437 >nul
title Port Proxy Manager
fltmc >nul 2>&1 || (powershell -Command "Start-Process cmd -ArgumentList '/c %~fnx0' -Verb RunAs" & exit)
cls

:MENU
cls
echo.
echo ==============================================
echo          Port Proxy Manager
echo ==============================================
echo [1] Show Port Mapping List
echo [2] Add Port Mapping
echo [3] Delete Port Mapping
echo [4] Exit
echo ==============================================
echo.
set "CHOICE="
set /p "CHOICE=Please enter your choice [1-4]: "

if "%CHOICE%"=="1" goto SHOW
if "%CHOICE%"=="2" goto ADD
if "%CHOICE%"=="3" goto DEL
if "%CHOICE%"=="4" exit
goto MENU

:SHOW
cls
echo.
echo === Current Port Mapping List ===
echo.
netsh interface portproxy show v4tov4
echo.
pause
goto MENU

:ADD
cls
echo.
echo === Add Port Mapping ===
echo Local Port listen on 0.0.0.0
echo.
set "LP="
set "IP="
set "TP="
set /p "LP=Local Port: "
set /p "IP=Target IP: "
set /p "TP=Target Port: "

netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=%LP% connectaddress=%IP% connectport=%TP%

echo.
echo Success: Mapping added.
echo.
pause
goto MENU

:DEL
cls
echo.
echo === Delete Port Mapping ===
echo DELETE by Local Port (0.0.0.0:xxxx)
echo.
set "DP="
set /p "DP=Enter Local Port to delete: "

netsh interface portproxy delete v4tov4 listenaddress=0.0.0.0 listenport=%DP%

echo.
echo Success: Port %DP% deleted.
echo.
pause
goto MENU