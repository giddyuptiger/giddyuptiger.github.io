// PRS Command Center — YouTube Analytics auto-sync
//
// Supabase Edge Function (Deno runtime). On invocation:
//   1. Loads the stored OAuth refresh token from prs_oauth_tokens.
//   2. Exchanges it for a short-lived access token at Google's token endpoint.
//   3. For every prs_episodes row with a non-null video_id, calls the
//      YouTube Analytics API for lifetime metrics on that video.
//   4. Writes views / watch_time_hours / avg_view_duration_sec /
//      avg_view_pct / subscribers_gained / impressions / ctr_pct into
//      prs_episodes.metrics (preserving manual ad_* fields).
//   5. Bumps metrics_updated_at.
//
// Required env vars (set with `supabase secrets set ...`):
//   - SUPABASE_URL                 (auto-injected on Supabase Edge runtime)
//   - SUPABASE_SERVICE_ROLE_KEY    (auto-injected on Supabase Edge runtime)
//   - YT_CLIENT_ID                 (OAuth client ID from Google Cloud)
//   - YT_CLIENT_SECRET             (OAuth client secret)
//   - YT_CHANNEL_ID                (optional — defaults to "MINE" using the
//                                   token owner's channel)
//
// Invoke manually:
//   curl -X POST "$SUPABASE_URL/functions/v1/youtube-analytics-sync" \
//        -H "Authorization: Bearer $SUPABASE_ANON_KEY"
//
// Schedule daily: see prs/docs/METRICS_AUTOPULL_SETUP.md.

import { createClient, type SupabaseClient } from "https://esm.sh/@supabase/supabase-js@2";

interface AnalyticsRow {
  views?: number;
  estimatedMinutesWatched?: number;
  averageViewDuration?: number;
  averageViewPercentage?: number;
  subscribersGained?: number;
  impressions?: number;
  impressionsClickThroughRate?: number;
}

interface EpisodeRow {
  id: string;
  slug: string;
  guest_name: string;
  video_id: string;
  metrics: Record<string, unknown> | null;
}

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const YT_CLIENT_ID = Deno.env.get("YT_CLIENT_ID");
const YT_CLIENT_SECRET = Deno.env.get("YT_CLIENT_SECRET");
const YT_CHANNEL_ID = Deno.env.get("YT_CHANNEL_ID") || "MINE";

// Note: `impressions` and `impressionsClickThroughRate` are NOT supported
// in video-level Analytics API queries (you get HTTP 400 "Unknown identifier").
// They are available via a separate channel-level query with dimensions=video,
// which we run as a second pass below.
const METRICS_LIST = [
  "views",
  "estimatedMinutesWatched",
  "averageViewDuration",
  "averageViewPercentage",
  "subscribersGained",
].join(",");

const IMPRESSIONS_METRICS_LIST = [
  "impressions",
  "impressionsClickThroughRate",
].join(",");

// YouTube launched 2005-02-14; using that as startDate gives lifetime totals.
const YOUTUBE_BIRTHDAY = "2005-02-14";

function jsonResponse(body: unknown, status = 200): Response {
  return new Response(JSON.stringify(body, null, 2), {
    status,
    headers: { "Content-Type": "application/json" },
  });
}

async function getAccessToken(refreshToken: string): Promise<string> {
  if (!YT_CLIENT_ID || !YT_CLIENT_SECRET) {
    throw new Error("YT_CLIENT_ID / YT_CLIENT_SECRET env vars are not set.");
  }
  const body = new URLSearchParams({
    client_id: YT_CLIENT_ID,
    client_secret: YT_CLIENT_SECRET,
    refresh_token: refreshToken,
    grant_type: "refresh_token",
  });
  const r = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    body,
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
  });
  const data = await r.json();
  if (!r.ok) {
    throw new Error(`Token refresh failed: ${JSON.stringify(data)}`);
  }
  return data.access_token as string;
}

async function fetchVideoAnalytics(
  accessToken: string,
  videoId: string,
): Promise<AnalyticsRow> {
  const today = new Date().toISOString().slice(0, 10);
  const baseParams = {
    ids: `channel==${YT_CHANNEL_ID}`,
    startDate: YOUTUBE_BIRTHDAY,
    endDate: today,
    filters: `video==${videoId}`,
  };
  const result: AnalyticsRow = {};

  // 1) Primary metrics (work with filters=video).
  const primaryParams = new URLSearchParams({
    ...baseParams,
    metrics: METRICS_LIST,
  });
  const primaryUrl = `https://youtubeanalytics.googleapis.com/v2/reports?${primaryParams}`;
  const r1 = await fetch(primaryUrl, {
    headers: { Authorization: `Bearer ${accessToken}` },
  });
  const data1 = await r1.json();
  if (!r1.ok) {
    throw new Error(
      `Analytics API ${r1.status} for video ${videoId}: ${JSON.stringify(data1)}`,
    );
  }
  const headers1: string[] = (data1.columnHeaders ?? []).map(
    (h: { name: string }) => h.name,
  );
  const row1: unknown[] = (data1.rows && data1.rows[0]) || [];
  headers1.forEach((name, i) => {
    const v = row1[i];
    if (typeof v === "number") (result as Record<string, number>)[name] = v;
  });

  // 2) Impressions + CTR — second call with dimensions=video. If this
  //    errors (some channels/regions don't expose these), swallow the
  //    error and continue without them.
  try {
    const impParams = new URLSearchParams({
      ...baseParams,
      metrics: IMPRESSIONS_METRICS_LIST,
      dimensions: "video",
    });
    const impUrl = `https://youtubeanalytics.googleapis.com/v2/reports?${impParams}`;
    const r2 = await fetch(impUrl, {
      headers: { Authorization: `Bearer ${accessToken}` },
    });
    const data2 = await r2.json();
    if (r2.ok) {
      const headers2: string[] = (data2.columnHeaders ?? []).map(
        (h: { name: string }) => h.name,
      );
      const row2: unknown[] = (data2.rows && data2.rows[0]) || [];
      headers2.forEach((name, i) => {
        const v = row2[i];
        if (typeof v === "number") (result as Record<string, number>)[name] = v;
      });
    }
  } catch (_e) {
    // Impressions are nice-to-have; ignore failures.
  }

  return result;
}

function mapToEpisodeMetrics(
  analytics: AnalyticsRow,
  existing: Record<string, unknown> | null,
): Record<string, unknown> {
  const out: Record<string, unknown> = {};
  // Carry forward all existing manual values; we then overwrite the
  // ones that YouTube knows about. Manual ad-side fields (ad_spend /
  // ad_ctr_pct / ad_cpv) live in Google Ads, not YouTube, so they
  // stay untouched.
  if (existing && typeof existing === "object") {
    for (const k of Object.keys(existing)) out[k] = existing[k];
  }
  if (analytics.views != null) out.views = analytics.views;
  if (analytics.estimatedMinutesWatched != null) {
    out.watch_time_hours = Math.round(analytics.estimatedMinutesWatched / 60);
  }
  if (analytics.averageViewDuration != null) {
    out.avg_view_duration_sec = analytics.averageViewDuration;
  }
  if (analytics.averageViewPercentage != null) {
    out.avg_view_pct = analytics.averageViewPercentage;
  }
  if (analytics.subscribersGained != null) {
    out.subscribers_gained = analytics.subscribersGained;
  }
  if (analytics.impressions != null) out.impressions = analytics.impressions;
  if (analytics.impressionsClickThroughRate != null) {
    // YouTube returns a fraction (0.052 = 5.2%); the UI displays percent.
    out.ctr_pct = analytics.impressionsClickThroughRate * 100;
  }
  return out;
}

async function loadRefreshToken(
  sb: SupabaseClient,
): Promise<{ id: string; refresh_token: string }> {
  const { data, error } = await sb
    .from("prs_oauth_tokens")
    .select("id,refresh_token")
    .order("updated_at", { ascending: false })
    .limit(1);
  if (error) throw new Error(`prs_oauth_tokens query failed: ${error.message}`);
  if (!data || data.length === 0) {
    throw new Error(
      "No OAuth token in prs_oauth_tokens. Complete the OAuth setup first (see METRICS_AUTOPULL_SETUP.md).",
    );
  }
  return data[0];
}

async function loadEpisodesWithVideo(
  sb: SupabaseClient,
): Promise<EpisodeRow[]> {
  const { data, error } = await sb
    .from("prs_episodes")
    .select("id,slug,guest_name,video_id,metrics")
    .not("video_id", "is", null);
  if (error) throw new Error(`prs_episodes query failed: ${error.message}`);
  return (data ?? []) as EpisodeRow[];
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok");
  try {
    const sb = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, {
      auth: { persistSession: false },
    });

    const token = await loadRefreshToken(sb);
    const accessToken = await getAccessToken(token.refresh_token);
    const episodes = await loadEpisodesWithVideo(sb);

    const results: Array<{ slug: string; ok: boolean; error?: string; views?: number }> = [];
    const updatedAt = new Date().toISOString();

    for (const ep of episodes) {
      try {
        const analytics = await fetchVideoAnalytics(accessToken, ep.video_id);
        const newMetrics = mapToEpisodeMetrics(analytics, ep.metrics);
        const { error: upErr } = await sb
          .from("prs_episodes")
          .update({ metrics: newMetrics, metrics_updated_at: updatedAt })
          .eq("id", ep.id);
        if (upErr) throw new Error(upErr.message);
        results.push({
          slug: ep.slug,
          ok: true,
          views: analytics.views,
        });
      } catch (e) {
        results.push({
          slug: ep.slug,
          ok: false,
          error: e instanceof Error ? e.message : String(e),
        });
      }
    }

    // Touch the token row so we can see the function ran.
    await sb
      .from("prs_oauth_tokens")
      .update({ updated_at: updatedAt })
      .eq("id", token.id);

    const okCount = results.filter((r) => r.ok).length;
    return jsonResponse({
      ok: true,
      ran_at: updatedAt,
      synced: okCount,
      total: results.length,
      results,
    });
  } catch (e) {
    return jsonResponse(
      { ok: false, error: e instanceof Error ? e.message : String(e) },
      500,
    );
  }
});
