-- PRS Episode Command Center — schema
-- Run this once on the PRS Supabase project, in the SQL editor.

create table if not exists prs_episodes (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  guest_name text not null,
  premiere_at timestamptz,
  status text not null default 'in-progress',
  sheet_url text,
  created_at timestamptz not null default now()
);

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

-- Row Level Security. v1: open access (the page lives at an unlisted URL).
-- To lock down later, replace these policies with auth-aware ones.
alter table prs_episodes enable row level security;
alter table prs_checklist_items enable row level security;

drop policy if exists "prs_episodes select" on prs_episodes;
drop policy if exists "prs_episodes insert" on prs_episodes;
drop policy if exists "prs_episodes update" on prs_episodes;
drop policy if exists "prs_episodes delete" on prs_episodes;
drop policy if exists "prs_items select" on prs_checklist_items;
drop policy if exists "prs_items insert" on prs_checklist_items;
drop policy if exists "prs_items update" on prs_checklist_items;
drop policy if exists "prs_items delete" on prs_checklist_items;

create policy "prs_episodes select" on prs_episodes for select using (true);
create policy "prs_episodes insert" on prs_episodes for insert with check (true);
create policy "prs_episodes update" on prs_episodes for update using (true) with check (true);
create policy "prs_episodes delete" on prs_episodes for delete using (true);

create policy "prs_items select" on prs_checklist_items for select using (true);
create policy "prs_items insert" on prs_checklist_items for insert with check (true);
create policy "prs_items update" on prs_checklist_items for update using (true) with check (true);
create policy "prs_items delete" on prs_checklist_items for delete using (true);

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
  end if;
end $$;
