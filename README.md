# The Side Bar Spotify Report

A data report for the Side Bar Friday night playlist collection — 10 years of music built by Gareth Ouellette and friends.

**Live (prod):** https://sidebar-spotify-report.netlify.app  
**Preview:** https://preview--sidebar-spotify-report.netlify.app  
**GitHub:** https://github.com/pdkjr20/sidebar-spotify-report

---

## Current Stats (June 2026)

- **89 playlists** · **9,356 track adds** · **27+ contributors**
- Oldest: Hey Ladies (Apr 2016) · Newest: Paul n party (Jun 2026)

---

## Files

| File | Purpose |
|---|---|
| `index.html` | The entire report — HTML, CSS, JS, data all in one file |
| `deploy.bat` | Push a hotfix directly to prod (main branch) |
| `deploy-preview.bat` | Push changes to the preview branch |
| `ship-to-prod.bat` | Merge preview into prod and deploy to live site |
| `CLAUDE.md` | Full guide for Claude: Spotify methods, data objects, what not to redo |
| `README.md` | This file |

---

## Branches

| Branch | URL | Purpose |
|---|---|---|
| `main` | https://sidebar-spotify-report.netlify.app | Production — the live public site |
| `preview` | https://preview--sidebar-spotify-report.netlify.app | Staging — test changes before shipping |

---

## Workflow

### Making changes

1. Edit `index.html` (the whole site lives here)
2. Run `deploy-preview.bat` to push to the preview branch
3. Check the preview URL to confirm everything looks right
4. Run `ship-to-prod.bat` to merge preview into main and deploy to the live site

### Hotfixing prod directly

If it's a small urgent fix you don't need to preview first:

1. Edit `index.html`
2. Run `deploy.bat` — pushes straight to main/prod

### Manual terminal commands

```
cd "C:\Users\pdkjr\OneDrive\01 PROJECT\Side Bar Spotify"

# Push to preview
git checkout preview
git add index.html
git commit -m "describe change"
git push origin preview

# Ship preview to prod
git checkout main
git merge preview
git push origin main
```

Netlify redeploys automatically within ~30 seconds after each push.

---

## Known Issue: Git Lock File

OneDrive sometimes leaves a `.git\index.lock` file that blocks git commands. All three `.bat` files handle this automatically. If you hit the error manually, delete the lock file:

1. Open File Explorer → enable **View → Hidden items**
2. Navigate to `C:\Users\pdkjr\OneDrive\01 PROJECT\Side Bar Spotify\.git\`
3. Delete any files ending in `.lock`

Or from Command Prompt:
```
del /f /q "C:\Users\pdkjr\OneDrive\01 PROJECT\Side Bar Spotify\.git\index.lock"
del /f /q "C:\Users\pdkjr\OneDrive\01 PROJECT\Side Bar Spotify\.git\HEAD.lock"
```

---

## Data Objects in index.html

| Object | Purpose |
|---|---|
| `const D = {...}` | News headlines keyed by `YYYY-MM` — one entry per playlist month |
| `const W = {...}` | Historical weather keyed by `YYYY-MM-DD` — real session dates from Spotify track timestamps |
| Playlist dropdown | Option values are exact session dates (`YYYY-MM-DD`), derived from peak track-add day |

Weather data sourced from Open-Meteo historical archive for Groton, MA (42.6093°N, 71.5714°W).

---

## Working with Claude

See **`CLAUDE.md`** for the full technical guide — Spotify token method, API endpoints, playlist inclusion rules, session date detection, and what not to redo from scratch.
