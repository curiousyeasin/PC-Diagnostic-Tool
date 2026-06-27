@echo off
setlocal EnableExtensions EnableDelayedExpansion

title Windows Cleanup Utility v1.0
color 0A
mode con: cols=80 lines=35

:: ===== Status Variables =====
set TEMP_DONE=No
set WTEMP_DONE=No
set RECENT_DONE=No
set BIN_DONE=No
set DNS_DONE=No
set UPDATE_DONE=No
set STORE_DONE=No
set DISM_DONE=Skipped
set EXPLORER_DONE=No

cls
echo.
echo ================================================================================
echo                      WINDOWS CLEANUP UTILITY v1.0
echo ================================================================================
echo.

:: --- Single-line PowerShell header (NO carets needed) ---
powershell -NoProfile -Command "Write-Host 'Developer : ' -NoNewline -ForegroundColor DarkGray; Write-Host 'Md Yeasin' -ForegroundColor White; Write-Host 'GitHub    : ' -NoNewline -ForegroundColor DarkGray; Write-Host 'https://github.com/curiousyeasin' -ForegroundColor Cyan"

echo.
echo  This utility safely removes temporary files and refreshes Windows caches.
echo.
echo ================================================================================

:: ===============================
:: Check Administrator (NO AUTO-LAUNCH)
:: ===============================
net session >nul 2>&1
if %errorlevel% neq 0 (
    color 0C
    echo.
    echo [ERROR] This utility must be run as Administrator.
    echo.
    echo Please right-click the EXE file and select
    echo "Run as administrator", or enable this option
    echo in your EXE converter's settings.
    echo.
    pause
    exit /b
)

where powershell >nul 2>&1
if errorlevel 1 (
    color 0C
    echo.
    echo PowerShell is not installed.
    pause
    exit /b
)




:: ================================================================================
echo ================================================================================
echo                         [1/9] CLEAN USER TEMP FILES
echo ================================================================================
echo.
echo  Cleaning temporary files...
del /f /s /q "%temp%\*" >nul 2>&1
for /d %%i in ("%temp%\*") do rd /s /q "%%i" >nul 2>&1
set TEMP_DONE=Yes
echo.
echo  [SUCCESS] User temporary files cleaned.
echo.
timeout /t 1 >nul

:: ================================================================================
echo ================================================================================
echo                      [2/9] CLEAN WINDOWS TEMP FILES
echo ================================================================================
echo.
echo  Cleaning Windows temporary files...
del /f /s /q "%SystemRoot%\Temp\*" >nul 2>&1
for /d %%i in ("%SystemRoot%\Temp\*") do rd /s /q "%%i" >nul 2>&1
set WTEMP_DONE=Yes
echo.
echo  [SUCCESS] Windows temporary files cleaned.
echo.
timeout /t 1 >nul

:: ================================================================================
echo ================================================================================
echo                        [3/9] CLEAR RECENT FILE HISTORY
echo ================================================================================
echo.
echo  Removing Recent Items history...
del /f /q "%APPDATA%\Microsoft\Windows\Recent\*" >nul 2>&1
set RECENT_DONE=Yes
echo.
echo  [SUCCESS] Recent file history cleared.
echo.
timeout /t 1 >nul

:: ================================================================================
echo ================================================================================
echo                         [4/9] EMPTY RECYCLE BIN
echo ================================================================================
echo.
echo  Emptying Recycle Bin...
PowerShell -NoProfile -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"
set BIN_DONE=Yes
echo.
echo  [SUCCESS] Recycle Bin emptied.
echo.
timeout /t 1 >nul

:: ================================================================================
echo ================================================================================
echo                          [5/9] FLUSH DNS CACHE
echo ================================================================================
echo.
echo  Refreshing DNS cache...
ipconfig /flushdns >nul
set DNS_DONE=Yes
echo.
echo  [SUCCESS] DNS cache flushed.
echo.
timeout /t 1 >nul

:: ================================================================================
echo ================================================================================
echo                    [6/9] CLEAR WINDOWS UPDATE CACHE
echo ================================================================================
echo.
echo  Stopping update services...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1

echo  Cleaning cache...
del /f /s /q "%windir%\SoftwareDistribution\Download\*" >nul 2>&1
for /d %%i in ("%windir%\SoftwareDistribution\Download\*") do rd /s /q "%%i" >nul 2>&1

echo  Restarting services...
net start bits >nul 2>&1
net start wuauserv >nul 2>&1

set UPDATE_DONE=Yes
echo.
echo  [SUCCESS] Windows Update cache cleaned.
echo.
timeout /t 1 >nul

:: ================================================================================
echo ================================================================================
echo                    [7/9] RESET MICROSOFT STORE CACHE
echo ================================================================================
echo.
echo  Resetting Microsoft Store cache...
start /wait wsreset.exe
set STORE_DONE=Yes
echo.
echo  [SUCCESS] Microsoft Store cache reset.
echo.
timeout /t 1 >nul

:: ================================================================================
echo ================================================================================
echo                   [8/9] COMPONENT STORE CLEANUP
echo ================================================================================
echo.
echo  This step removes obsolete Windows update components.
echo  It may take several minutes.
echo.

choice /C YN /M "Run Component Store Cleanup"

if errorlevel 2 goto SkipDISM

echo.
echo  Running cleanup...
DISM /Online /Cleanup-Image /StartComponentCleanup
set DISM_DONE=Yes
echo.
echo  [SUCCESS] Component Store cleaned.
goto Explorer

:SkipDISM
echo.
echo  [SKIPPED] Component Store cleanup skipped.

:Explorer

echo.
echo ================================================================================
echo                     [9/9] RESTART WINDOWS EXPLORER
echo ================================================================================
echo.
echo  Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
set EXPLORER_DONE=Yes
echo.
echo  [SUCCESS] Windows Explorer restarted.

cls
echo.
echo ================================================================================
echo                           CLEANUP SUMMARY
echo ================================================================================
echo.
echo  [ %TEMP_DONE% ] User Temp Files
echo      Removes temporary files created by applications.
echo.
echo  [ %WTEMP_DONE% ] Windows Temp Files
echo      Removes temporary Windows installation files.
echo.
echo  [ %RECENT_DONE% ] Recent Files
echo      Clears the history of recently opened files.
echo.
echo  [ %BIN_DONE% ] Recycle Bin
echo      Permanently deletes files already in the Recycle Bin.
echo.
echo  [ %DNS_DONE% ] DNS Cache
echo      Refreshes cached network address information.
echo.
echo  [ %UPDATE_DONE% ] Windows Update Cache
echo      Removes old or corrupted Windows Update downloads.
echo.
echo  [ %STORE_DONE% ] Microsoft Store Cache
echo      Resets the Microsoft Store cache to fix Store issues.
echo.
echo  [ %DISM_DONE% ] Component Store Cleanup
echo      Removes outdated Windows update components.
echo.
echo  [ %EXPLORER_DONE% ] Restart Windows Explorer
echo      Refreshes the desktop, taskbar and File Explorer.
echo.
echo ================================================================================
echo                    ALL CLEANUP TASKS HAVE FINISHED
echo ================================================================================
echo.
echo  Thank you for using Windows Cleanup Utility.
echo.
pause