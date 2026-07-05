@echo off
title Git Auto Update Tool
color 0B
echo ===================================================
echo             GIT AUTO UPDATE TOOL
echo ===================================================
echo.
echo Current directory: %CD%
echo.

:: Check if git is installed
where git >nul 2>nul
if %errorlevel% neq 0 (
    color 0C
    echo ERROR: Git is not installed or not in your PATH.
    echo Please install Git and try again.
    goto end
)

:: Check if we are in a git repository
if not exist .git (
    color 0C
    echo ERROR: No git repository found in this directory.
    goto end
)

:: Get current branch
for /f "tokens=*" %%i in ('git rev-parse --abbrev-ref HEAD') do set "branch=%%i"
echo Current Branch: %branch%
echo.

echo [+] Showing current git status...
git status
echo.

echo ===================================================
set /p "commit_msg=Enter commit message (or press Enter for 'update'): "
if "%commit_msg%"=="" set "commit_msg=update"

echo.
echo [+] Staging all changes (git add .)...
git add .

echo [+] Committing changes with message: "%commit_msg%"...
git commit -m "%commit_msg%"

echo [+] Pushing changes to remote (git push origin %branch%)...
git push origin %branch%

if %errorlevel% equ 0 (
    color 0A
    echo.
    echo ===================================================
    echo           SUCCESS: Git updated successfully!
    echo ===================================================
) else (
    color 0C
    echo.
    echo ===================================================
    echo           ERROR: Failed to push changes.
    echo ===================================================
)

:end
echo.
echo Press any key to exit...
pause >nul
