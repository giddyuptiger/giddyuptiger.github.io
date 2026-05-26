# youtube-analytics-sync

Supabase Edge Function (Deno) that pulls per-video metrics from the YouTube
Analytics API and writes them into `prs_episodes.metrics`.

See `prs/docs/METRICS_AUTOPULL_SETUP.md` for the end-to-end setup checklist.

## Environment variables

Set with `supabase secrets set` (or via the Supabase Dashboard → Project
Settings → Edge Functions → Secrets):

| Name | Value |
|---|---|
| `YT_CLIENT_ID` | OAuth 2.0 client ID from Google Cloud Console. |
| `YT_CLIENT_SECRET` | OAuth 2.0 client secret from Google Cloud Console. |
| `YT_CHANNEL_ID` | *(Optional)* The PRS YouTube channel ID. Defaults to `MINE`, which uses whichever channel the OAuth token owner manages. Set explicitly if the token owner manages multiple channels. |

`SUPABASE_URL` and `SUPABASE_SERVICE_ROLE_KEY` are injected automatically
by the Supabase Edge runtime — you do not need to set them yourself.

## Deploy

From the repo root (the Supabase CLI expects functions under
`supabase/functions/...`, so symlink or copy on deploy):

```sh
# One-time setup: tell the CLI which project to deploy to
supabase link --project-ref umtckshrjeyueyzgkuwm

# Copy this function into the supabase/functions/ tree the CLI expects
mkdir -p supabase/functions/youtube-analytics-sync
cp prs/functions/youtube-analytics-sync/index.ts supabase/functions/youtube-analytics-sync/

# Push secrets
supabase secrets set YT_CLIENT_ID=...   YT_CLIENT_SECRET=...   YT_CHANNEL_ID=...

# Deploy
supabase functions deploy youtube-analytics-sync
```

## Invoke

```sh
curl -X POST "https://umtckshrjeyueyzgkuwm.supabase.co/functions/v1/youtube-analytics-sync" \
     -H "Authorization: Bearer $SUPABASE_ANON_KEY"
```

Response:

```json
{
  "ok": true,
  "ran_at": "2026-05-26T20:00:00.000Z",
  "synced": 9,
  "total": 9,
  "results": [
    { "slug": "rob-morrow", "ok": true, "views": 12345 },
    ...
  ]
}
```

## Schedule

See the **Step 9 — Schedule the daily cron** section of
`prs/docs/METRICS_AUTOPULL_SETUP.md`. Two options:

- **Supabase Dashboard cron** (recommended) — Edge Functions →
  *Cron Jobs* tab → New job → invoke this function daily at 04:00 PT.
- **pg_cron from inside Postgres** — schedule a `select net.http_post(...)`
  call. SQL example in the setup doc.

## What it does, in detail

1. Reads the most recent row from `prs_oauth_tokens` (stored once during
   the OAuth setup) and exchanges the refresh token for a short-lived
   access token at `https://oauth2.googleapis.com/token`.
2. Selects all `prs_episodes` rows with a non-null `video_id`.
3. For each video, calls
   `GET https://youtubeanalytics.googleapis.com/v2/reports` with
   `ids=channel==${YT_CHANNEL_ID}`, `startDate=2005-02-14`,
   `endDate=today`, `filters=video==${video_id}`, and
   `metrics=views,estimatedMinutesWatched,averageViewDuration,averageViewPercentage,subscribersGained,impressions,impressionsClickThroughRate`.
4. Maps the response into the existing `prs_episodes.metrics` JSONB keys:
   - `views` ← `views`
   - `watch_time_hours` ← round(`estimatedMinutesWatched` / 60)
   - `avg_view_duration_sec` ← `averageViewDuration`
   - `avg_view_pct` ← `averageViewPercentage`
   - `subscribers_gained` ← `subscribersGained`
   - `impressions` ← `impressions`
   - `ctr_pct` ← `impressionsClickThroughRate` × 100
5. Preserves any existing keys that YouTube doesn't know about
   (`ad_spend`, `ad_ctr_pct`, `ad_cpv` — these live in Google Ads).
6. Updates `metrics_updated_at` to the run timestamp.
7. Returns a JSON summary listing each episode and whether it synced.

## Failure modes

- **No token row** → returns 500 with a message pointing at the OAuth
  setup. Run the setup flow.
- **Token revoked or expired (`invalid_grant`)** → returns 500. The PRS
  YouTube channel owner needs to re-authorize. Delete the row and rerun
  the OAuth flow.
- **A single video fails** (deleted, private, wrong channel) → its entry
  in `results` has `ok: false` with the error message; the rest still
  sync.
- **Quota exceeded** → YouTube Analytics API has a generous quota
  (10,000 units/day, ~1 unit per request) but back off if you see
  `quotaExceeded` — the daily cron should be well within limits.
