# PRS Command Center — Metrics Options

Today the metrics tiles on the per-episode page (and the home aggregate strip)
are populated by hand: someone opens YouTube Studio, copies the numbers, and
clicks **Edit** on the "This Episode" card to type them in. The seed
`prs/sql/seed_past_episodes_metrics.sql` did this once for the 8 past episodes;
ongoing episodes need fresh data after each launch.

This doc lays out three options for taking that workload off the team —
plus how to embed the actual YouTube video player on the episode page so the
team can scrub the cut without leaving the dashboard.

---

## Option A — Auto-pull from the YouTube Analytics API *(recommended)*

A small server-side worker polls the YouTube Analytics API every 24 hours for
each episode's video ID and writes the latest numbers into
`prs_episodes.metrics`. The Command Center reads from Supabase as it does
today, so the UI changes are zero. The metrics tiles just start filling in
on their own — and stay current.

**What gets pulled per episode (mapped to the existing `metrics` jsonb):**

| Existing key in `prs_episodes.metrics` | YouTube Analytics field |
|---|---|
| `views` | `views` |
| `ctr_pct` | `cardClickRate` × 100 *(or impressionsClickThroughRate from Reporting API)* |
| `avg_view_pct` | `averageViewPercentage` |
| `avg_view_duration_sec` | `averageViewDuration` |
| `watch_time_hours` | `estimatedMinutesWatched` / 60 |
| `subscribers_gained` | `subscribersGained` |
| `impressions` | `impressions` *(needs YouTube Reporting API, not classic Analytics)* |
| `ad_spend` | Manual — Google Ads, not YouTube Analytics |
| `ad_ctr_pct` | Manual — Google Ads |
| `ad_cpv` | Manual — Google Ads |

The first 6 (the ones that come from YouTube itself) auto-populate. The 3 ad
fields stay manual via the existing **Edit** form, since they live in Google
Ads, not YouTube. That's still a big win — 60-70% less typing per episode.

**What we'd need to set up (one-time):**

1. **Google Cloud project** — Jeremy or the channel owner creates one at
   `console.cloud.google.com`. Free tier is fine.
2. **Enable the YouTube Analytics API + YouTube Data API v3** on that
   project (both required: Data API to resolve channel/video IDs, Analytics
   API for the metrics themselves).
3. **OAuth 2.0 client credentials** — create a "Web application" OAuth
   client. Set the redirect URI to whatever serverless URL ends up hosting
   the auth callback (e.g. `https://prs-metrics-worker.workers.dev/auth/callback`).
4. **One-time channel-owner authorization** — the PRS YouTube channel owner
   (the Google account that owns "Punk Rock Sober" on YouTube) opens the
   auth URL once, grants `youtubeanalytics.readonly` + `youtube.readonly`,
   and the worker stores the refresh token. After that, no human
   interaction is needed.
5. **Tiny worker** — Cloudflare Worker, Supabase Edge Function, or a Vercel
   cron job. ~200 LOC. Runs daily; for each episode row with a non-null
   `video_id`, calls the Analytics API and upserts `metrics` +
   `metrics_updated_at`. Total cost: ~$0/mo on free tiers.
6. **Add `video_id text` column to `prs_episodes`** — small migration. The
   worker keys off this; episodes without a video_id are skipped.

**Concrete handoff for Jeremy:**

- [ ] Create GCP project. Name doesn't matter (e.g., `prs-command-center`).
- [ ] Enable YouTube Analytics API + YouTube Data API v3.
- [ ] Create OAuth 2.0 Web application client. Note the **Client ID** and
      **Client secret**.
- [ ] Decide the worker host. Easiest: Cloudflare Workers (free tier,
      cron triggers). Supabase Edge Functions also fine.
- [ ] Share the client ID + secret + chosen worker host so the worker can
      be built and the redirect URI registered.
- [ ] Sign in once via the auth URL (will be a short link generated after
      the worker is deployed) using the **PRS YouTube channel owner**
      Google account — not a personal account, has to be the one that
      manages the channel.

After that: the worker fills `metrics` for any episode that has a
`video_id` populated. Zero ongoing work.

**Pros:** zero manual entry going forward; metrics always within 24 hours
of YouTube Studio; the home-page aggregate strip is always live.

**Cons:** one-time setup (~1 hour total once credentials are in hand); the
Analytics API is owner-scoped, so the PRS Google account specifically has
to authorize — a personal account won't work. Requires a tiny serverless
function (worth it for the leverage).

---

## Option B — Mini player embed in the episode header *(no auth, ships today)*

Adds a single text column `video_url text` to `prs_episodes`. When set,
the per-episode page renders a small responsive `<iframe>` of the YouTube
watch page directly in the header area, above the metrics card.

**What changes:**

- One-line schema migration: `alter table prs_episodes add column if not exists video_url text;`
- Episode-edit affordance (small "Edit video URL" link in the episode
  header) so Tyler/Jeremy can paste the YouTube URL once after upload.
- JS rendering: if `video_url` is present, embed
  `<iframe src="https://www.youtube.com/embed/{video_id}">` with a
  16:9 aspect-ratio wrapper. ~30 LOC.

**Pros:**
- Zero auth, zero new external services.
- Can ship the same day Jeremy asks for it — no GCP work needed.
- Lets the team scrub the cut and check the published metadata
  (title, description, chapters) without leaving the Command Center.
- Plays nicely with Option A later: same `video_id` (derived from
  `video_url`) feeds the metrics worker.

**Cons:**
- Doesn't pull metrics. Tiles stay manual until Option A is wired up.

---

## Option C — Both *(actual recommendation)*

Build Option B now (fast win, immediate utility) and queue Option A as
the proper fix for manual metrics entry. Final state:

- Per-episode header has the mini player at top.
- Metrics tiles auto-populate daily from YouTube Analytics.
- Top-line metrics (Views / CTR / Avg view %) render right next to the
  player so the team sees performance at a glance.
- Manual **Edit** form stays available for the 3 ad-side metrics
  (`ad_spend`, `ad_ctr_pct`, `ad_cpv`) and as a fallback if the worker
  ever hiccups.

**Suggested order:**

1. **Today** — ship Option B (mini player). Single small commit;
   covers the "embed the ep link" half of Jeremy's ask immediately.
2. **When GCP credentials are in hand** — ship Option A (metrics worker).
   ~1 day of work once the OAuth client is created and authorized.

Both options share the same `video_id` derived from `video_url`, so
nothing in Option B becomes throwaway when Option A lands.
