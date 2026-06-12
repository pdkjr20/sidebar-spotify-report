@echo off
setlocal enabledelayedexpansion
cd /d "C:\Users\pdkjr\OneDrive\01 PROJECT\Side Bar Spotify"
echo Shipping preview to production...

:: Remove ALL git lock files
if exist ".git\index.lock"          del /f /q ".git\index.lock"
if exist ".git\HEAD.lock"           del /f /q ".git\HEAD.lock"
if exist ".git\COMMIT_EDITMSG.lock" del /f /q ".git\COMMIT_EDITMSG.lock"
if exist ".git\config.lock"         del /f /q ".git\config.lock"
echo Lock files cleared.

:: Commit any pending changes on preview first (uncommitted changes
:: would block "git checkout main" and silently abort the merge)
git checkout preview
git add -A
git diff --cached --quiet
if errorlevel 1 (
    set "msg="
    set /p msg="Commit message for pending preview changes (Enter for default): "
    if "!msg!"=="" set "msg=Update Side Bar report"
    git commit -m "!msg!"
)
git push origin preview

:: Switch to main and merge preview
echo.
echo Switching to main branch...
git checkout main
if errorlevel 1 (
    echo.
    echo ERROR: could not switch to main - aborting. Check for uncommitted changes above.
    pause
    exit /b 1
)

echo.
echo Merging preview into main...
git merge preview --no-edit

echo.
echo Pushing to GitHub...
git push origin main

echo.
echo Switching back to preview...
git checkout preview

echo.
echo Done! Production site will redeploy in ~30 seconds.
echo Prod:    https://sidebar-spotify-report.netlify.app
echo Preview: https://preview--sidebar-spotify-report.netlify.app
pause
