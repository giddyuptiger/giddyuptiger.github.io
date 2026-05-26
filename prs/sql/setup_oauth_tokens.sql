-- PRS Command Center — OAuth token storage for YouTube Analytics auto-sync
--
-- Stores the refresh token granted by the PRS YouTube channel owner one
-- time during OAuth setup. The youtube-analytics-sync edge function reads
-- this row, exchanges the refresh token for a short-lived access token,
-- and pulls metrics from the YouTube Analytics API.
--
-- SECURITY: RLS is ON and there are NO policies. That means the anon key
-- and browser code CANNOT read or write this table — only the
-- service_role key (which bypasses RLS) can. The edge function uses
-- SUPABASE_SERVICE_ROLE_KEY so it has access; the public PRS page
-- (which uses the anon key) does not.
--
-- Paste-and-run in Supabase SQL editor. Idempotent.

begin;

create table if not exists prs_oauth_tokens (
  id uuid primary key default gen_random_uuid(),
  provider text not null default 'google',
  access_token text,
  refresh_token text not null,
  expires_at timestamptz,
  scope text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table prs_oauth_tokens enable row level security;

-- Defensive: drop any prior policies in case this table was set up
-- before with looser rules. With RLS enabled and zero policies, only
-- roles that bypass RLS (service_role) can access this table.
drop policy if exists "prs_oauth_tokens select" on prs_oauth_tokens;
drop policy if exists "prs_oauth_tokens insert" on prs_oauth_tokens;
drop policy if exists "prs_oauth_tokens update" on prs_oauth_tokens;
drop policy if exists "prs_oauth_tokens delete" on prs_oauth_tokens;

-- NO CREATE POLICY statements below — that is intentional. Service-role
-- access is sufficient for the edge function and prevents the browser
-- from ever seeing these tokens.

commit;
