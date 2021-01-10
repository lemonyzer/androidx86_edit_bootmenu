@echo off

echo run as admin...
echo.
pause

mountvol X: /s
cd /d X:
BOOT\grub\grub.cfg
BOOT\grub\themes\androidx86\theme.txt

echo %~dp0
copy "%~dp0\icons\*.*" "X:\BOOT\grub\themes\androidx86\icons"

mkdir "%~dp0\version"

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
echo datestamp: "%datestamp%"
echo timestamp: "%timestamp%"
echo fullstamp: "%fullstamp%"
echo.

set versionFolder="%~dp0\version\%fullstamp%"
mkdir %versionFolder%
copy "X:\BOOT\grub\grub.cfg" %versionFolder%
copy "X:\BOOT\grub\themes\androidx86\theme.txt" %versionFolder%

echo.
echo.
echo press twice to unmount EFI Partition
pause
pause
mountvol X: /d
echo.
echo DONE

pause