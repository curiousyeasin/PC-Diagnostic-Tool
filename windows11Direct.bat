@echo off
title Windows 11 App Installer
color 0A
setlocal EnableDelayedExpansion

echo ============================================
echo      Windows 11 Software Installer
echo ============================================
echo.

:: Check Winget
where winget >nul 2>&1
if %errorlevel% neq 0 (
    echo Winget is not installed!
    echo Please install App Installer from Microsoft Store.
    pause
    exit /b
)

echo Updating Winget sources...
winget source update
echo.

:: ------------------------------
:: Install Applications
:: ------------------------------
call :InstallApp "Google Chrome" "Google.Chrome"
call :InstallApp "Brave Browser" "Brave.Brave"
call :InstallApp "7-Zip" "7zip.7zip"
call :InstallApp "WinRAR" "RARLab.WinRAR"
call :InstallApp "VLC Media Player" "VideoLAN.VLC"
call :InstallApp "Notepad++" "Notepad++.Notepad++"
call :InstallApp "Git" "Git.Git"
call :InstallApp "Visual Studio Code" "Microsoft.VisualStudioCode"
call :InstallApp "Android Studio" "Google.AndroidStudio"
call :InstallApp "MEGASync" "Mega.MEGASync"
call :InstallApp "AnyDesk" "AnyDeskSoftwareGmbH.AnyDesk"
call :InstallApp "Notion" "Notion.Notion"
call :InstallApp "Todoist" "Doist.Todoist"

echo.
echo ============================================
echo All installations have finished.
echo ============================================
pause
exit /b

:: =================================================
:InstallApp
echo.
choice /C YN /M "Do you want to install %~1?"

if errorlevel 2 (
    echo Skipped %~1
    exit /b
)

echo.
echo Installing %~1...
echo.

winget install --id %~2 ^
-e ^
--accept-package-agreements ^
--accept-source-agreements ^
--silent

if %errorlevel%==0 (
    echo [SUCCESS] %~1 installed.
) else (
    echo [FAILED] %~1 installation failed or is already installed.
)

echo.
pause
exit /b