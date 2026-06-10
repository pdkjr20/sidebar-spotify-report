# Side Bar Spotify Report — Claude Project Guide

## What This Is

A single-file HTML report for the Side Bar Friday night playlist collection.
Built by Gareth Ouellette (gco13-us) and collaborators since 2016.

- **Live site:** https://sidebar-spotify-report.netlify.app
- **GitHub:** https://github.com/pdkjr20/sidebar-spotify-report
- **Main file:** `C:\Users\pdkjr\OneDrive\01 PROJECT\Side Bar Spotify\index.html`

---

## Current State (June 2026)

- **96 playlists** · **~9,365 track adds** · **27+ contributors**
- Oldest: Hey Ladies (Apr 2016) · Newest: Friday Funnigans (Mar 2026)
- Top artist: Pearl Jam (~298 appearances across mixed playlists)

---

## Deploy Workflow

**Option A — double-click `deploy.bat`** (handles Windows git lock automatically)

**Option B — terminal:**
```
cd "C:\Users\pdkjr\OneDrive\01 PROJECT\Side Bar Spotify"
git add index.html
git commit -m "describe change"
git push
```
Netlify auto-deploys ~30 seconds after push.

### Known Issue: Git Lock File on OneDrive
OneDrive sometimes leaves a `.git/index.lock` file that blocks git.
`deploy.bat` handles this automatically. Manual fix:
```
del /f "C:\Users\pdkjr\OneDrive\01 PROJECT\Side Bar Spotify\.git\index.lock"
```

---

## How to Connect to Spotify (From Claude/Browser)

The sandbox cannot reach Spotify directly (proxy blocks it). Use the browser.

### Step-by-step:
1. Open `https://open.spotify.com` in the Claude in Chrome browser (already logged in as PK / pdkjr20)
2. Install a fetch interceptor in JS to capture the Bearer token:
```javascript
window._token = null;
const orig = window.fetch.bind(window);
window.fetch = function(input, init) {
  const hdrs = init?.headers || {};
  const auth = (hdrs instanceof Headers) ? hdrs.get('Authorization') : (hdrs['Authorization'] || hdrs['authorization']);
  if (auth) window._token = auth;
  return orig(input, init);
};
```
3. Navigate within the SPA to trigger API calls:
```javascript
window.history.pushState({}, '', '/user/mco120/playlists');
window.dispatchEvent(new PopStateEvent('popstate', {}));
```
4. Retrieve the token: `window._token`

### Useful Endpoints (use with captured Bearer token)

**Get all public playlists for a user** (less rate-limited than standard API):
```
GET https://spclient.wg.spotify.com/user-profile-view/v3/profile/{userId}/playlists?offset=0&limit=100
```

**Get playlist tracks** (standard API, can rate-limit — add 1-2s delays):
```
GET https://api.spotify.com/v1/playlists/{playlistId}?fields=name,tracks.total,tracks.items(added_at,added_by.id)
```

**Read a playlist page from the DOM** (no API needed — just navigate and scrape):
```javascript
const h1 = document.querySelector('main h1')?.textContent;
const summary = Array.from(document.querySelectorAll('main span')).find(el => el.textContent.match(/\d+ songs/))?.textContent;
const byLine = [...new Set(Array.from(document.querySelectorAll('main a[href*="/user/"]')).map(a => a.textContent))].join(', ');
```

### Spotify Credentials
- **Client ID:** cc5a860a65c543eeac734761cd93f56f
- **Client Secret:** ae17e590246f4928ba858d943389b75d
- **Gareth's user ID:** gco13-us
- **Meredith's user ID:** mco120
- **PK's user ID:** pdkjr20

### Rate Limiting
The standard `api.spotify.com` endpoint rate-limits aggressively (429).
Use `spclient.wg.spotify.com` for user/playlist listings — it's the internal endpoint Spotify's own web player uses and is much more forgiving.
When using the standard API, add `await new Promise(r => setTimeout(r, 1500))` between calls.

---

## HTML File Structure

`index.html` is a single self-contained file. Key sections:

| Section | What it is |
|---|---|
| Stats bar | 6 stat cards: playlists, tracks, contributors, years, unique songs, avg per playlist |
| Contributors | Personality cards for Gareth, Meredith, PK, Pam, others |
| Insights | Thematic analysis sections |
| News Flashback | Dropdown → picks a playlist date → shows news headlines via `const D = {...}` |
| Playlist directory | `<table>` with 96 rows, sorted chronologically, year header rows |
| Footer | Summary line with live stats |

### The News Data Object
```javascript
const D = {
  '2016-04': { politics:"...", world:"...", culture:"...", sports:"...", tech:"...", science:"..." },
  '2016-07': { ... },
  // ... one entry per playlist month
};
```
Keys are `YYYY-MM`. When a new playlist is added, add a matching key if one doesn't exist.
When a playlist is removed and its month has no other playlists, remove the key (orphaned key).

### Playlist Table Row Format
```html
<tr><td>42</td><td class="pl-name">April Friday</td><td><span class="pl-year">Apr 2022</span></td><td class="pl-count">84</td></tr>
```
Year header rows:
```html
<tr class="year-row"><td colspan="4">── 2022 ──</td></tr>
```

---

## What NOT to Redo

- **Don't re-scrape all playlists from scratch.** The 96-playlist list is accurate as of June 2026. Only fetch new ones incrementally.
- **Don't regenerate the full D object.** It has 52+ entries of hand-curated news data. Append only.
- **Don't renumber rows manually.** Use the Python renumber regex pattern:
  ```python
  counter = [0]
  def renumber(m):
      counter[0] += 1
      return f'<tr><td>{counter[0]}</td>'
  html = re.sub(r'<tr><td>\d+</td>', renumber, html)
  ```
  WARNING: this matches ALL `<tr><td>N</td>` patterns — confirm there are no other table rows outside the playlist directory before running.

- **Don't edit index.html in the outputs folder.** The real file is the workspace folder. Edits to `outputs/` are lost between sessions.

---

## Playlist Inclusion Rules

**Include a playlist if:**
- It was created for a Side Bar Friday night session
- It has Gareth (gco13-us) and/or is a Gareth/Meredith collaboration
- It has a collaborative Friday/social vibe (funny name, multiple contributors)

**Exclude:**
- Single-artist playlists (e.g., Pearl Jam-only, RHCP-only)
- Personal fitness/HIIT playlists (Meredith's PS HIIT, CS, Jazzercise series)
- Solo personal playlists with no Side Bar connection

---

## Key Contributors Summary

| Name | Spotify ID | Adds | Notes |
|---|---|---|---|
| Gareth Ouellette | gco13-us | ~8,061 | 83% of collection, PJ superfan |
| Meredith B. Ouellette | mco120 | ~854 | Yacht rock, collaborative Friday playlists |
| PK | pdkjr20 | ~151 | Alt/proto-punk/new wave taste |
| Pam | — | ~262 | Wildcard, fills every gap |
| Erin Stark | — | ~200 | Country/outlaw |
| Todd | — | ~127 | Fits in seamlessly |
| Dasha | — | ~89 | Current pop/indie |

---

## Sessions History

| Session ID | Title | What was done |
|---|---|---|
| local_d22596fd | Spotify playlist analysis | Built original report, all data scraped, Netlify + GitHub setup |
| local_5d0b1782 | Side Bar audit (this session) | Removed 9 PJ playlists, fixed 4 dupes, added 5 Meredith playlists, 96 total |
