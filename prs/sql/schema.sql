-- PRS Episode Command Center — schema
-- Run this once on the PRS Supabase project, in the SQL editor.
-- Idempotent: safe to re-run; uses IF NOT EXISTS and drop-then-create for policies.

create table if not exists prs_episodes (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  guest_name text not null,
  premiere_at timestamptz,
  status text not null default 'in-progress',
  sheet_url text,
  metrics jsonb not null default '{}'::jsonb,
  metrics_updated_at timestamptz,
  created_at timestamptz not null default now()
);

-- Idempotent column adds for existing installs:
alter table prs_episodes add column if not exists metrics jsonb not null default '{}'::jsonb;
alter table prs_episodes add column if not exists metrics_updated_at timestamptz;
alter table prs_episodes add column if not exists shooting_date date;
alter table prs_episodes add column if not exists airing_date date;
alter table prs_episodes add column if not exists transcript_received boolean not null default false;
alter table prs_episodes add column if not exists transcript_received_at timestamptz;

create table if not exists prs_checklist_items (
  id uuid primary key default gen_random_uuid(),
  episode_id uuid not null references prs_episodes(id) on delete cascade,
  role_group text not null,
  title text not null,
  instructions_md text,
  sort_order integer not null default 0,
  done boolean not null default false,
  done_at timestamptz,
  done_by text,
  created_at timestamptz not null default now()
);

create index if not exists prs_items_episode_idx on prs_checklist_items(episode_id);
create index if not exists prs_items_sort_idx on prs_checklist_items(episode_id, sort_order);

-- Sponsors: one row per sponsor placement on an episode. Josh enters these
-- through the SPONSORSHIP section's "Input Sponsors" task; each row then
-- renders as a "Cut into show" task for Jerry to verify in the final cut.
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

-- Row Level Security. v1: open access (the page lives at an unlisted URL).
alter table prs_episodes enable row level security;
alter table prs_checklist_items enable row level security;
alter table prs_sponsors enable row level security;

drop policy if exists "prs_episodes select" on prs_episodes;
drop policy if exists "prs_episodes insert" on prs_episodes;
drop policy if exists "prs_episodes update" on prs_episodes;
drop policy if exists "prs_episodes delete" on prs_episodes;
drop policy if exists "prs_items select" on prs_checklist_items;
drop policy if exists "prs_items insert" on prs_checklist_items;
drop policy if exists "prs_items update" on prs_checklist_items;
drop policy if exists "prs_items delete" on prs_checklist_items;
drop policy if exists "prs_sponsors select" on prs_sponsors;
drop policy if exists "prs_sponsors insert" on prs_sponsors;
drop policy if exists "prs_sponsors update" on prs_sponsors;
drop policy if exists "prs_sponsors delete" on prs_sponsors;

create policy "prs_episodes select" on prs_episodes for select using (true);
create policy "prs_episodes insert" on prs_episodes for insert with check (true);
create policy "prs_episodes update" on prs_episodes for update using (true) with check (true);
create policy "prs_episodes delete" on prs_episodes for delete using (true);

create policy "prs_items select" on prs_checklist_items for select using (true);
create policy "prs_items insert" on prs_checklist_items for insert with check (true);
create policy "prs_items update" on prs_checklist_items for update using (true) with check (true);
create policy "prs_items delete" on prs_checklist_items for delete using (true);

create policy "prs_sponsors select" on prs_sponsors for select using (true);
create policy "prs_sponsors insert" on prs_sponsors for insert with check (true);
create policy "prs_sponsors update" on prs_sponsors for update using (true) with check (true);
create policy "prs_sponsors delete" on prs_sponsors for delete using (true);

-- Realtime publication. Toggles propagate live across viewers.
do $$
begin
  perform 1 from pg_publication where pubname = 'supabase_realtime';
  if found then
    begin
      execute 'alter publication supabase_realtime add table prs_checklist_items';
    exception when duplicate_object then null; end;
    begin
      execute 'alter publication supabase_realtime add table prs_episodes';
    exception when duplicate_object then null; end;
    begin
      execute 'alter publication supabase_realtime add table prs_sponsors';
    exception when duplicate_object then null; end;
  end if;
end $$;
