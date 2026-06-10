@echo off
echo Shipping preview to production...

:: Remove ALL git lock files
if exist ".git\index.lock"          del /f /q ".git\index.lock"
if exist ".git\HEAD.lock"           del /f /q ".git\HEAD.lock"
if exist ".git\COMMIT_EDITMSG.lock" del /f /q ".git\COMMIT_EDITMSG.lock"
if exist ".git\config.lock"         del /f /q ".git\config.lock"
echo Lock files cleared.

:: Switch to main and merge preview
echo.
echo Switching to main branch...
git checkout main

echo.
echo Merging preview into main...
git merge preview --no-edit

echo.
echo Pushing to GitHub...
git push origin main

echo.
echo Done! Production site will redeploy in ~30 seconds.
echo Prod:    https://sidebar-spotify-report.netlify.app
echo Preview: https://preview--sidebar-spotify-report.netlify.app
pause
