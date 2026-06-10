# The Side Bar Spotify Report

A data report for the Side Bar Friday night playlist collection — 10 years of music built by Gareth Ouellette and friends.

**Live site:** https://sidebar-spotify-report.netlify.app  
**GitHub:** https://github.com/pdkjr20/sidebar-spotify-report

---

## Current Stats (June 2026)

- **96 playlists** · **~9,365 track adds** · **27+ contributors**
- Oldest: Hey Ladies (Apr 2016) · Newest: Friday Funnigans (Mar 2026)

---

## Files

| File | Purpose |
|---|---|
| `index.html` | The entire report — HTML, CSS, JS, data all in one file |
| `CLAUDE.md` | Full guide for Claude: Spotify methods, deploy workflow, what not to redo |
| `deploy.bat` | Double-click to push changes to GitHub → Netlify (handles git lock) |
| `README.md` | This file |

---

## Deploying Changes

Double-click **`deploy.bat`**, or from a terminal:

```
cd "C:\Users\pdkjr\OneDrive\01 PROJECT\Side Bar Spotify"
git add index.html
git commit -m "describe your change"
git push
```

Netlify redeploys automatically within ~30 seconds.

---

## Setup

| Thing | Detail |
|---|---|
| Live URL | https://sidebar-spotify-report.netlify.app |
| GitHub repo | https://github.com/pdkjr20/sidebar-spotify-report |
| Branch | main — every push auto-deploys |
| Data source | Gareth Ouellette (gco13-us) + Meredith Ouellette (mco120) |

---

## Working with Claude

See **`CLAUDE.md`** for the full technical guide — Spotify token method, API endpoints, playlist rules, known issues, and what not to redo from scratch.
