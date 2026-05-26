-- PRS Command Center migration — 2026-05-26
-- Adds: shooting_date / airing_date / transcript_received(_at) columns on prs_episodes,
--       the prs_sponsors table, its RLS policies + indexes, and the realtime publication entry.
-- Paste-and-run in Supabase SQL editor. Idempotent — safe to re-run.
-- Does NOT touch any existing rows.

begin;

-- 1) New columns on prs_episodes (idempotent).
alter table prs_episodes add column if not exists shooting_date date;
alter table prs_episodes add column if not exists airing_date date;
alter table prs_episodes add column if not exists transcript_received boolean not null default false;
alter table prs_episodes add column if not exists transcript_received_at timestamptz;

-- 2) prs_sponsors table.
create table if not exists prs_sponsors (
  id uuid primary key default gen_random_uuid(),
  episode_id uuid not null references prs_episodes(id) on delete cascade,
  name text not null,
  slot text,
  timestamp text,
  notes text,
  entered_by text,
  entered_at timestamptz not null default now(),
  cut_into_show boolean not null default false,
  cut_at timestamptz
);

create index if not exists prs_sponsors_episode_idx on prs_sponsors(episode_id);

-- 3) RLS — open access (matches the other PRS tables; the page lives at an unlisted URL).
alter table prs_sponsors enable row level security;

drop policy if exists "prs_sponsors select" on prs_sponsors;
drop policy if exists "prs_sponsors insert" on prs_sponsors;
drop policy if exists "prs_sponsors update" on prs_sponsors;
drop policy if exists "prs_sponsors delete" on prs_sponsors;

create policy "prs_sponsors select" on prs_sponsors for select using (true);
create policy "prs_sponsors insert" on prs_sponsors for insert with check (true);
create policy "prs_sponsors update" on prs_sponsors for update using (true) with check (true);
create policy "prs_sponsors delete" on prs_sponsors for delete using (true);

-- 4) Add prs_sponsors to the realtime publication (no-op if already added).
do $$
begin
  perform 1 from pg_publication where pubname = 'supabase_realtime';
  if found then
    begin
      execute 'alter publication supabase_realtime add table prs_sponsors';
    exception when duplicate_object then null; end;
  end if;
end $$;

commit;
