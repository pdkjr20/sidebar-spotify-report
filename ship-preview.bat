@echo off
setlocal
cd /d "C:\Users\pdkjr\OneDrive\01 PROJECT\Side Bar Spotify"

echo Removing stale git lock files...
if exist ".git\index.lock"          del /f /q ".git\index.lock"
if exist ".git\HEAD.lock"           del /f /q ".git\HEAD.lock"
if exist ".git\COMMIT_EDITMSG.lock" del /f /q ".git\COMMIT_EDITMSG.lock"
if exist ".git\config.lock"         del /f /q ".git\config.lock"

echo.
echo Rebuilding index from HEAD (fixes a corrupted index)...
git reset

echo.
echo Switching to preview branch...
git checkout preview

echo.
echo Staging Weather section + supporting changes...
git add index.html README.md CLAUDE.md deploy.bat deploy-preview.bat ship-to-prod.bat

echo.
echo Committing...
git commit -m "Add Ten Years of Porch Weather section"

echo.
echo Pushing to preview...
git push origin preview

echo.
echo ==== RESULT ====
git status > ship-preview-result.txt
echo. >> ship-preview-result.txt
git log --oneline -5 >> ship-preview-result.txt
