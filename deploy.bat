@echo off
cd /d "C:\Users\pdkjr\OneDrive\01 PROJECT\Side Bar Spotify"

echo Clearing git lock files if present...
if exist ".git\index.lock"    del /f /q ".git\index.lock"
if exist ".git\HEAD.lock"     del /f /q ".git\HEAD.lock"
if exist ".git\COMMIT_EDITMSG.lock" del /f /q ".git\COMMIT_EDITMSG.lock"
if exist ".git\config.lock"   del /f /q ".git\config.lock"

echo.
echo Adding changes...
git add index.html

echo.
echo Committing...
git commit -m "Update Side Bar report"

echo.
echo Pushing to GitHub...
git push

echo.
echo Done! Netlify will redeploy in ~30 seconds.
echo Site: https://sidebar-spotify-report.netlify.app
pause
