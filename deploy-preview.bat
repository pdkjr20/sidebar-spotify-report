@echo off
cd /d "C:\Users\pdkjr\OneDrive\01 PROJECT\Side Bar Spotify"
echo Deploying preview branch...

:: Remove ALL git lock files (OneDrive leaves these behind)
if exist ".git\index.lock"    del /f /q ".git\index.lock"
if exist ".git\HEAD.lock"     del /f /q ".git\HEAD.lock"
if exist ".git\COMMIT_EDITMSG.lock" del /f /q ".git\COMMIT_EDITMSG.lock"
if exist ".git\config.lock"   del /f /q ".git\config.lock"
echo Lock files cleared.

:: Stage and commit any changes on preview branch
git checkout preview
git add index.html README.md CLAUDE.md deploy.bat deploy-preview.bat
git diff --cached --quiet
if errorlevel 1 (
    set /p msg="Commit message (or press Enter to skip): "
    if not "%msg%"=="" git commit -m "%msg%"
)

:: Push preview to GitHub
git push origin preview

echo.
echo Done! Preview will deploy to:
echo https://preview--sidebar-spotify-report.netlify.app
echo (after you enable branch deploys in Netlify settings)
pause
