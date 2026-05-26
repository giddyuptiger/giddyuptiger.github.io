-- PRS Command Center migration — 2026-05-26 (video columns)
-- Adds video_url + video_id columns to prs_episodes so the per-episode page
-- can embed a YouTube mini-player and the auto-sync edge function knows
-- which video to pull metrics for.
-- Paste-and-run in Supabase SQL editor. Idempotent. Does not touch existing rows.

begin;

alter table prs_episodes add column if not exists video_url text;
alter table prs_episodes add column if not exists video_id text;

-- Useful for the edge function: only episodes with a video_id get synced.
create index if not exists prs_episodes_video_id_idx on prs_episodes(video_id) where video_id is not null;

commit;
