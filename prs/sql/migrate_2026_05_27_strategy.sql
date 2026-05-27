-- PRS Command Center migration — 2026-05-27
-- Adds the Strategy section: a single-row prs_strategy_state (operator-tracked
-- goals: weekly counts, outlier hit rate, 30-day test status) and a
-- prs_strategy_items checklist (Johnny's growth playbook action items).
-- Paste-and-run in Supabase SQL editor. Idempotent — safe to re-run.
-- Does NOT touch any existing rows.

begin;

-- 1) prs_strategy_items — the action-item checklist (Routine / Content Format /
--    Podcast / Validation / 30-Day Test / Tooling). seed_key is a stable
--    identifier so seed_strategy.sql can upsert without creating duplicates.
create table if not exists prs_strategy_items (
  id uuid primary key default gen_random_uuid(),
  seed_key text unique,
  category text not null,
  title text not null,
  instructions_md text,
  sort_order integer not null default 0,
  done boolean not null default false,
  done_at timestamptz,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists prs_strategy_items_category_idx on prs_strategy_items(category, sort_order);

-- 2) prs_strategy_state — single-row table that holds the three operator-edited
--    goal blurbs (weekly progress, outlier hit rate, 30-day test status). The
--    check constraint pins this to exactly one row keyed on id=1.
create table if not exists prs_strategy_state (
  id integer primary key default 1,
  weekly_progress text,
  outlier_hit_rate text,
  thirty_day_status text,
  updated_at timestamptz not null default now(),
  constraint prs_strategy_state_single_row check (id = 1)
);

-- Make sure the single row exists. ON CONFLICT no-op keeps any operator edits.
insert into prs_strategy_state (id) values (1)
on conflict (id) do nothing;

-- 3) RLS — open access (matches the other PRS tables; the page lives at an unlisted URL).
alter table prs_strategy_items enable row level security;
alter table prs_strategy_state enable row level security;

drop policy if exists "prs_strategy_items select" on prs_strategy_items;
drop policy if exists "prs_strategy_items insert" on prs_strategy_items;
drop policy if exists "prs_strategy_items update" on prs_strategy_items;
drop policy if exists "prs_strategy_items delete" on prs_strategy_items;
drop policy if exists "prs_strategy_state select" on prs_strategy_state;
drop policy if exists "prs_strategy_state insert" on prs_strategy_state;
drop policy if exists "prs_strategy_state update" on prs_strategy_state;
drop policy if exists "prs_strategy_state delete" on prs_strategy_state;

create policy "prs_strategy_items select" on prs_strategy_items for select using (true);
create policy "prs_strategy_items insert" on prs_strategy_items for insert with check (true);
create policy "prs_strategy_items update" on prs_strategy_items for update using (true) with check (true);
create policy "prs_strategy_items delete" on prs_strategy_items for delete using (true);

create policy "prs_strategy_state select" on prs_strategy_state for select using (true);
create policy "prs_strategy_state insert" on prs_strategy_state for insert with check (true);
create policy "prs_strategy_state update" on prs_strategy_state for update using (true) with check (true);
create policy "prs_strategy_state delete" on prs_strategy_state for delete using (true);

-- 4) Add to the realtime publication so toggles propagate live.
do $$
begin
  perform 1 from pg_publication where pubname = 'supabase_realtime';
  if found then
    begin
      execute 'alter publication supabase_realtime add table prs_strategy_items';
    exception when duplicate_object then null; end;
    begin
      execute 'alter publication supabase_realtime add table prs_strategy_state';
    exception when duplicate_object then null; end;
  end if;
end $$;

commit;
