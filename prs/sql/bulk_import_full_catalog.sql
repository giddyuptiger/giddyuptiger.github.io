-- PRS bulk import of full 107-episode YouTube catalog
-- Generated from Table_data.csv (YouTube Studio export).
-- Per row: UPDATE if video_id is already in prs_episodes
-- (preserving the existing slug); otherwise INSERT a new row.
-- Existing metrics keys (ad_spend, ad_ctr_pct, ad_cpv) are preserved
-- by JSONB || merge — new keys overwrite old keys for same name.
-- Idempotent: safe to re-run.

begin;

-- DT-Nkdz2kBI  Comedian Sam Miller on Addiction, Jail, & Getting Sober (17 Years Clean) | Punk 
with upd as (
  update prs_episodes set
    guest_name   = 'Sam Miller',
    premiere_at  = '2026-04-27'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=DT-Nkdz2kBI',
    video_id     = 'DT-Nkdz2kBI',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":18683,"ctr_pct":3.62,"avg_view_pct":7.39,"avg_view_duration_sec":306,"watch_time_hours":1052.44,"subscribers_gained":2,"impressions":4088}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'DT-Nkdz2kBI'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'sam-miller-2', 'Sam Miller', '2026-04-27'::date, 'shipped',
       'https://www.youtube.com/watch?v=DT-Nkdz2kBI', 'DT-Nkdz2kBI', '{"views":18683,"ctr_pct":3.62,"avg_view_pct":7.39,"avg_view_duration_sec":306,"watch_time_hours":1052.44,"subscribers_gained":2,"impressions":4088}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'sam-miller-2');

-- x5Y32jLEdFk  The Pitch Tape That Got David Chokachi Cast in Baywatch 2026
with upd as (
  update prs_episodes set
    guest_name   = 'David Chokachi (Pitch Tape)',
    premiere_at  = '2026-04-13'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=x5Y32jLEdFk',
    video_id     = 'x5Y32jLEdFk',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":69553,"ctr_pct":3.09,"avg_view_pct":3.43,"avg_view_duration_sec":178,"watch_time_hours":2758.55,"subscribers_gained":6,"impressions":6249}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'x5Y32jLEdFk'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'david-chokachi-pitch-tape', 'David Chokachi (Pitch Tape)', '2026-04-13'::date, 'shipped',
       'https://www.youtube.com/watch?v=x5Y32jLEdFk', 'x5Y32jLEdFk', '{"views":69553,"ctr_pct":3.09,"avg_view_pct":3.43,"avg_view_duration_sec":178,"watch_time_hours":2758.55,"subscribers_gained":6,"impressions":6249}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'david-chokachi-pitch-tape');

-- VIAiz5tYJ30  Podcasting Changed His Acting Career
with upd as (
  update prs_episodes set
    guest_name   = 'Podcasting & Acting Career',
    premiere_at  = '2026-03-31'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=VIAiz5tYJ30',
    video_id     = 'VIAiz5tYJ30',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":36308,"ctr_pct":13.75,"avg_view_pct":9.16,"avg_view_duration_sec":399,"watch_time_hours":1232.14,"subscribers_gained":28,"impressions":29348}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'VIAiz5tYJ30'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'podcasting-acting-career-2', 'Podcasting & Acting Career', '2026-03-31'::date, 'shipped',
       'https://www.youtube.com/watch?v=VIAiz5tYJ30', 'VIAiz5tYJ30', '{"views":36308,"ctr_pct":13.75,"avg_view_pct":9.16,"avg_view_duration_sec":399,"watch_time_hours":1232.14,"subscribers_gained":28,"impressions":29348}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'podcasting-acting-career-2');

-- 1oJqtqBoC9A  Ibogaine? The Controversial Treatment Helping Veterans
with upd as (
  update prs_episodes set
    guest_name   = 'Ibogaine & Veterans',
    premiere_at  = '2026-03-16'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=1oJqtqBoC9A',
    video_id     = '1oJqtqBoC9A',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":39385,"ctr_pct":2.34,"avg_view_pct":4.05,"avg_view_duration_sec":262,"watch_time_hours":1890.6,"subscribers_gained":9,"impressions":8788}'::jsonb,
    metrics_updated_at = now()
  where video_id = '1oJqtqBoC9A'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'ibogaine-veterans-2', 'Ibogaine & Veterans', '2026-03-16'::date, 'shipped',
       'https://www.youtube.com/watch?v=1oJqtqBoC9A', '1oJqtqBoC9A', '{"views":39385,"ctr_pct":2.34,"avg_view_pct":4.05,"avg_view_duration_sec":262,"watch_time_hours":1890.6,"subscribers_gained":9,"impressions":8788}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'ibogaine-veterans-2');

-- ctIm4J1sBik  Punk Rock Sober: Julie Chang on Celebrity Addiction, Justin Bieber, and Hollywoo
with upd as (
  update prs_episodes set
    guest_name   = 'Julie Chang (Mar 2026)',
    premiere_at  = '2026-03-09'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=ctIm4J1sBik',
    video_id     = 'ctIm4J1sBik',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":118,"ctr_pct":2.82,"avg_view_pct":8.32,"avg_view_duration_sec":366,"watch_time_hours":12.01,"subscribers_gained":0,"impressions":2057}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'ctIm4J1sBik'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'julie-chang-mar-2026', 'Julie Chang (Mar 2026)', '2026-03-09'::date, 'shipped',
       'https://www.youtube.com/watch?v=ctIm4J1sBik', 'ctIm4J1sBik', '{"views":118,"ctr_pct":2.82,"avg_view_pct":8.32,"avg_view_duration_sec":366,"watch_time_hours":12.01,"subscribers_gained":0,"impressions":2057}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'julie-chang-mar-2026');

-- pKIbwpMwjlU  "I Was So Ashamed," John Henson about Sobriety, Stand-Up, and Surviving Hollywoo
with upd as (
  update prs_episodes set
    guest_name   = 'John Henson',
    premiere_at  = '2026-02-23'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=pKIbwpMwjlU',
    video_id     = 'pKIbwpMwjlU',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":20203,"ctr_pct":2.07,"avg_view_pct":4.48,"avg_view_duration_sec":184,"watch_time_hours":364.74,"subscribers_gained":3,"impressions":3956}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'pKIbwpMwjlU'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'john-henson-2', 'John Henson', '2026-02-23'::date, 'shipped',
       'https://www.youtube.com/watch?v=pKIbwpMwjlU', 'pKIbwpMwjlU', '{"views":20203,"ctr_pct":2.07,"avg_view_pct":4.48,"avg_view_duration_sec":184,"watch_time_hours":364.74,"subscribers_gained":3,"impressions":3956}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'john-henson-2');

-- xzB0wVNqZ-w  Mary Alice Haney: When Creativity Replaced Adderall | Punk Rock Sober
with upd as (
  update prs_episodes set
    guest_name   = 'Mary Alice Haney',
    premiere_at  = '2026-02-16'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=xzB0wVNqZ-w',
    video_id     = 'xzB0wVNqZ-w',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":118,"ctr_pct":1.47,"avg_view_pct":12.35,"avg_view_duration_sec":466,"watch_time_hours":15.3,"subscribers_gained":0,"impressions":3461}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'xzB0wVNqZ-w'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'mary-alice-haney-2', 'Mary Alice Haney', '2026-02-16'::date, 'shipped',
       'https://www.youtube.com/watch?v=xzB0wVNqZ-w', 'xzB0wVNqZ-w', '{"views":118,"ctr_pct":1.47,"avg_view_pct":12.35,"avg_view_duration_sec":466,"watch_time_hours":15.3,"subscribers_gained":0,"impressions":3461}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'mary-alice-haney-2');

-- zZQgVkPog70  Armie Hammer on Fame, Sobriety & Why He’s Happier Now
with upd as (
  update prs_episodes set
    guest_name   = 'Armie Hammer (Feb 2026)',
    premiere_at  = '2026-02-02'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=zZQgVkPog70',
    video_id     = 'zZQgVkPog70',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":20980,"ctr_pct":9.1,"avg_view_pct":4.2,"avg_view_duration_sec":170,"watch_time_hours":992.15,"subscribers_gained":29,"impressions":31047}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'zZQgVkPog70'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'armie-hammer-feb-2026', 'Armie Hammer (Feb 2026)', '2026-02-02'::date, 'shipped',
       'https://www.youtube.com/watch?v=zZQgVkPog70', 'zZQgVkPog70', '{"views":20980,"ctr_pct":9.1,"avg_view_pct":4.2,"avg_view_duration_sec":170,"watch_time_hours":992.15,"subscribers_gained":29,"impressions":31047}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'armie-hammer-feb-2026');

-- ScKWCxEhvVs  Jay Mohr Recovery Legend!
with upd as (
  update prs_episodes set
    guest_name   = 'Jay Mohr',
    premiere_at  = '2026-01-26'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=ScKWCxEhvVs',
    video_id     = 'ScKWCxEhvVs',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":150,"ctr_pct":2.52,"avg_view_pct":27.99,"avg_view_duration_sec":1087,"watch_time_hours":45.32,"subscribers_gained":1,"impressions":2106}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'ScKWCxEhvVs'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'jay-mohr-2', 'Jay Mohr', '2026-01-26'::date, 'shipped',
       'https://www.youtube.com/watch?v=ScKWCxEhvVs', 'ScKWCxEhvVs', '{"views":150,"ctr_pct":2.52,"avg_view_pct":27.99,"avg_view_duration_sec":1087,"watch_time_hours":45.32,"subscribers_gained":1,"impressions":2106}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'jay-mohr-2');

-- fQSYePgxchg  Jack Osbourne on Long-Term Sobriety, MS, Fatherhood & Life After Ozzy | Punk Roc
with upd as (
  update prs_episodes set
    guest_name   = 'Jack Osbourne',
    premiere_at  = '2026-01-05'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=fQSYePgxchg',
    video_id     = 'fQSYePgxchg',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":3646,"ctr_pct":5.06,"avg_view_pct":16.29,"avg_view_duration_sec":805,"watch_time_hours":815.57,"subscribers_gained":26,"impressions":29614}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'fQSYePgxchg'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'jack-osbourne-2', 'Jack Osbourne', '2026-01-05'::date, 'shipped',
       'https://www.youtube.com/watch?v=fQSYePgxchg', 'fQSYePgxchg', '{"views":3646,"ctr_pct":5.06,"avg_view_pct":16.29,"avg_view_duration_sec":805,"watch_time_hours":815.57,"subscribers_gained":26,"impressions":29614}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'jack-osbourne-2');

-- zjWV6oU1D2M  Andrew Huberman Gets Real w Tyler's 9-Year-Old Son. | Punk Rock Sober Podcast
with upd as (
  update prs_episodes set
    guest_name   = 'Andrew Huberman',
    premiere_at  = '2025-12-15'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=zjWV6oU1D2M',
    video_id     = 'zjWV6oU1D2M',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":5426,"ctr_pct":5.03,"avg_view_pct":0.97,"avg_view_duration_sec":83,"watch_time_hours":126.22,"subscribers_gained":6,"impressions":1828}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'zjWV6oU1D2M'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'andrew-huberman-2', 'Andrew Huberman', '2025-12-15'::date, 'shipped',
       'https://www.youtube.com/watch?v=zjWV6oU1D2M', 'zjWV6oU1D2M', '{"views":5426,"ctr_pct":5.03,"avg_view_pct":0.97,"avg_view_duration_sec":83,"watch_time_hours":126.22,"subscribers_gained":6,"impressions":1828}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'andrew-huberman-2');

-- qXMU3P2l1TI  Malik Pointer: Growing Up Famous, Surviving Addiction & Finding Sobriety | Painf
with upd as (
  update prs_episodes set
    guest_name   = 'Malik Pointer',
    premiere_at  = '2025-12-08'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=qXMU3P2l1TI',
    video_id     = 'qXMU3P2l1TI',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":123,"ctr_pct":2.91,"avg_view_pct":17.73,"avg_view_duration_sec":804,"watch_time_hours":27.47,"subscribers_gained":1,"impressions":2127}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'qXMU3P2l1TI'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'malik-pointer-2', 'Malik Pointer', '2025-12-08'::date, 'shipped',
       'https://www.youtube.com/watch?v=qXMU3P2l1TI', 'qXMU3P2l1TI', '{"views":123,"ctr_pct":2.91,"avg_view_pct":17.73,"avg_view_duration_sec":804,"watch_time_hours":27.47,"subscribers_gained":1,"impressions":2127}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'malik-pointer-2');

-- h_B3MZKw4lg  Ashley Hamilton: Surviving Addiction, Hollywood Trauma & Cancer | Punk Rock Sobe
with upd as (
  update prs_episodes set
    guest_name   = 'Ashley Hamilton',
    premiere_at  = '2025-11-17'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=h_B3MZKw4lg',
    video_id     = 'h_B3MZKw4lg',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":808,"ctr_pct":4.61,"avg_view_pct":9.9,"avg_view_duration_sec":605,"watch_time_hours":135.98,"subscribers_gained":4,"impressions":6447}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'h_B3MZKw4lg'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'ashley-hamilton-2', 'Ashley Hamilton', '2025-11-17'::date, 'shipped',
       'https://www.youtube.com/watch?v=h_B3MZKw4lg', 'h_B3MZKw4lg', '{"views":808,"ctr_pct":4.61,"avg_view_pct":9.9,"avg_view_duration_sec":605,"watch_time_hours":135.98,"subscribers_gained":4,"impressions":6447}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'ashley-hamilton-2');

-- inZmTX2IXT8  Punk Rock Sober: Billy Jensen on Redemption, Addiction & True Crime | Painful Le
with upd as (
  update prs_episodes set
    guest_name   = 'Billy Jensen (Nov 2025)',
    premiere_at  = '2025-11-10'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=inZmTX2IXT8',
    video_id     = 'inZmTX2IXT8',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":31,"ctr_pct":1.96,"avg_view_pct":10.28,"avg_view_duration_sec":372,"watch_time_hours":3.2,"subscribers_gained":1,"impressions":920}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'inZmTX2IXT8'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'billy-jensen-nov-2025', 'Billy Jensen (Nov 2025)', '2025-11-10'::date, 'shipped',
       'https://www.youtube.com/watch?v=inZmTX2IXT8', 'inZmTX2IXT8', '{"views":31,"ctr_pct":1.96,"avg_view_pct":10.28,"avg_view_duration_sec":372,"watch_time_hours":3.2,"subscribers_gained":1,"impressions":920}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'billy-jensen-nov-2025');

-- 6O-F-jBwHkY  From Korn to Rock to Recovery: Wes Geer on Punk Rock Sobriety | Painful Lessons 
with upd as (
  update prs_episodes set
    guest_name   = 'Wes Geer',
    premiere_at  = '2025-11-03'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=6O-F-jBwHkY',
    video_id     = '6O-F-jBwHkY',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":50,"ctr_pct":2.79,"avg_view_pct":9.78,"avg_view_duration_sec":357,"watch_time_hours":4.97,"subscribers_gained":2,"impressions":860}'::jsonb,
    metrics_updated_at = now()
  where video_id = '6O-F-jBwHkY'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'wes-geer-2', 'Wes Geer', '2025-11-03'::date, 'shipped',
       'https://www.youtube.com/watch?v=6O-F-jBwHkY', '6O-F-jBwHkY', '{"views":50,"ctr_pct":2.79,"avg_view_pct":9.78,"avg_view_duration_sec":357,"watch_time_hours":4.97,"subscribers_gained":2,"impressions":860}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'wes-geer-2');

-- z6KaEG3W_1I  David Chokachi: Baywatch, Recovery & Cold Plunges | Painful Lessons Podcast
with upd as (
  update prs_episodes set
    guest_name   = 'David Chokachi (Oct 2025)',
    premiere_at  = '2025-10-20'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=z6KaEG3W_1I',
    video_id     = 'z6KaEG3W_1I',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":73,"ctr_pct":3,"avg_view_pct":8.77,"avg_view_duration_sec":462,"watch_time_hours":9.37,"subscribers_gained":2,"impressions":1401}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'z6KaEG3W_1I'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'david-chokachi-oct-2025', 'David Chokachi (Oct 2025)', '2025-10-20'::date, 'shipped',
       'https://www.youtube.com/watch?v=z6KaEG3W_1I', 'z6KaEG3W_1I', '{"views":73,"ctr_pct":3,"avg_view_pct":8.77,"avg_view_duration_sec":462,"watch_time_hours":9.37,"subscribers_gained":2,"impressions":1401}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'david-chokachi-oct-2025');

-- E_wT63_mjjg  From Top Chef Winner to Painful Lessons | Gabe Erales on Food, Ego & Redemption
with upd as (
  update prs_episodes set
    guest_name   = 'Gabe Erales',
    premiere_at  = '2025-10-06'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=E_wT63_mjjg',
    video_id     = 'E_wT63_mjjg',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":82,"ctr_pct":2.3,"avg_view_pct":11.14,"avg_view_duration_sec":312,"watch_time_hours":7.12,"subscribers_gained":1,"impressions":695}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'E_wT63_mjjg'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'gabe-erales-2', 'Gabe Erales', '2025-10-06'::date, 'shipped',
       'https://www.youtube.com/watch?v=E_wT63_mjjg', 'E_wT63_mjjg', '{"views":82,"ctr_pct":2.3,"avg_view_pct":11.14,"avg_view_duration_sec":312,"watch_time_hours":7.12,"subscribers_gained":1,"impressions":695}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'gabe-erales-2');

-- 0OnQmAETJKc  James Gunn’s Sobriety Secret: How He Took Over DC Comics
with upd as (
  update prs_episodes set
    guest_name   = 'James Gunn (Short)',
    premiere_at  = '2025-10-02'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=0OnQmAETJKc',
    video_id     = '0OnQmAETJKc',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":9,"ctr_pct":1.52,"avg_view_pct":6.3,"avg_view_duration_sec":41,"watch_time_hours":0.1,"subscribers_gained":0,"impressions":462}'::jsonb,
    metrics_updated_at = now()
  where video_id = '0OnQmAETJKc'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'james-gunn-short', 'James Gunn (Short)', '2025-10-02'::date, 'shipped',
       'https://www.youtube.com/watch?v=0OnQmAETJKc', '0OnQmAETJKc', '{"views":9,"ctr_pct":1.52,"avg_view_pct":6.3,"avg_view_duration_sec":41,"watch_time_hours":0.1,"subscribers_gained":0,"impressions":462}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'james-gunn-short');

-- d0bkG4GD3so  The Sober List, Part 2: Walter May & Tyler Ramsey discuss Sober Celebs | Painful
with upd as (
  update prs_episodes set
    guest_name   = 'The Sober List, Part 2',
    premiere_at  = '2025-09-29'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=d0bkG4GD3so',
    video_id     = 'd0bkG4GD3so',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":6,"ctr_pct":0.59,"avg_view_pct":19.44,"avg_view_duration_sec":686,"watch_time_hours":1.14,"subscribers_gained":0,"impressions":512}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'd0bkG4GD3so'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'the-sober-list-part-2', 'The Sober List, Part 2', '2025-09-29'::date, 'shipped',
       'https://www.youtube.com/watch?v=d0bkG4GD3so', 'd0bkG4GD3so', '{"views":6,"ctr_pct":0.59,"avg_view_pct":19.44,"avg_view_duration_sec":686,"watch_time_hours":1.14,"subscribers_gained":0,"impressions":512}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'the-sober-list-part-2');

-- oXiBKo_mtII  How Julie Chang Stopped Seizures & Chose Sobriety | Painful Lessons Podcast Nugg
with upd as (
  update prs_episodes set
    guest_name   = 'Julie Chang (Seizures Nugget)',
    premiere_at  = '2025-09-25'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=oXiBKo_mtII',
    video_id     = 'oXiBKo_mtII',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":11,"ctr_pct":0.64,"avg_view_pct":52.98,"avg_view_duration_sec":52,"watch_time_hours":0.16,"subscribers_gained":0,"impressions":468}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'oXiBKo_mtII'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'julie-chang-seizures-nugget', 'Julie Chang (Seizures Nugget)', '2025-09-25'::date, 'shipped',
       'https://www.youtube.com/watch?v=oXiBKo_mtII', 'oXiBKo_mtII', '{"views":11,"ctr_pct":0.64,"avg_view_pct":52.98,"avg_view_duration_sec":52,"watch_time_hours":0.16,"subscribers_gained":0,"impressions":468}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'julie-chang-seizures-nugget');

-- jKVlcThDc7o  The Painful Lessons Podcast: Julie Chang on Surviving Brain Cancer, Sobriety & G
with upd as (
  update prs_episodes set
    guest_name   = 'Julie Chang (Sep 2025)',
    premiere_at  = '2025-09-22'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=jKVlcThDc7o',
    video_id     = 'jKVlcThDc7o',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":37,"ctr_pct":1.72,"avg_view_pct":0.74,"avg_view_duration_sec":36,"watch_time_hours":0.37,"subscribers_gained":0,"impressions":464}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'jKVlcThDc7o'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'julie-chang-sep-2025', 'Julie Chang (Sep 2025)', '2025-09-22'::date, 'shipped',
       'https://www.youtube.com/watch?v=jKVlcThDc7o', 'jKVlcThDc7o', '{"views":37,"ctr_pct":1.72,"avg_view_pct":0.74,"avg_view_duration_sec":36,"watch_time_hours":0.37,"subscribers_gained":0,"impressions":464}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'julie-chang-sep-2025');

-- Y4bSKHNYjm4  Anthony Kiedis, Red Hot Chili Peppers Frontman & an Unexpected AA Meeting | Pain
with upd as (
  update prs_episodes set
    guest_name   = 'Anthony Kiedis (Nugget)',
    premiere_at  = '2025-09-11'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=Y4bSKHNYjm4',
    video_id     = 'Y4bSKHNYjm4',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":88,"ctr_pct":3.1,"avg_view_pct":38.72,"avg_view_duration_sec":118,"watch_time_hours":2.89,"subscribers_gained":0,"impressions":484}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'Y4bSKHNYjm4'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'anthony-kiedis-nugget', 'Anthony Kiedis (Nugget)', '2025-09-11'::date, 'shipped',
       'https://www.youtube.com/watch?v=Y4bSKHNYjm4', 'Y4bSKHNYjm4', '{"views":88,"ctr_pct":3.1,"avg_view_pct":38.72,"avg_view_duration_sec":118,"watch_time_hours":2.89,"subscribers_gained":0,"impressions":484}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'anthony-kiedis-nugget');

-- AzoYBF4sc2w  Celebrities Who Chose Sobriety | Painful Lessons Podcast w/ Tyler Ramsey and Cam
with upd as (
  update prs_episodes set
    guest_name   = 'Celebrities Who Chose Sobriety',
    premiere_at  = '2025-09-08'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=AzoYBF4sc2w',
    video_id     = 'AzoYBF4sc2w',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":50,"ctr_pct":1.93,"avg_view_pct":7.35,"avg_view_duration_sec":377,"watch_time_hours":5.25,"subscribers_gained":0,"impressions":725}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'AzoYBF4sc2w'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'celebrities-who-chose-sobriety', 'Celebrities Who Chose Sobriety', '2025-09-08'::date, 'shipped',
       'https://www.youtube.com/watch?v=AzoYBF4sc2w', 'AzoYBF4sc2w', '{"views":50,"ctr_pct":1.93,"avg_view_pct":7.35,"avg_view_duration_sec":377,"watch_time_hours":5.25,"subscribers_gained":0,"impressions":725}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'celebrities-who-chose-sobriety');

-- XQhICXgM7mE  She Got Voted Off Survivor… Then Fell in Love with the Show’s Handler (Real Stor
with upd as (
  update prs_episodes set
    guest_name   = 'Jacqueline Berg-Ramsey (Survivor Short)',
    premiere_at  = '2025-08-28'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=XQhICXgM7mE',
    video_id     = 'XQhICXgM7mE',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":35,"ctr_pct":1.94,"avg_view_pct":27.84,"avg_view_duration_sec":396,"watch_time_hours":3.86,"subscribers_gained":0,"impressions":360}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'XQhICXgM7mE'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'jacqueline-berg-ramsey-survivor-short', 'Jacqueline Berg-Ramsey (Survivor Short)', '2025-08-28'::date, 'shipped',
       'https://www.youtube.com/watch?v=XQhICXgM7mE', 'XQhICXgM7mE', '{"views":35,"ctr_pct":1.94,"avg_view_pct":27.84,"avg_view_duration_sec":396,"watch_time_hours":3.86,"subscribers_gained":0,"impressions":360}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'jacqueline-berg-ramsey-survivor-short');

-- lmkXusVF_Wg  From Survivor to Startup: Jacqueline Berg-Ramsey’s Wild Love Story, Sobriety & T
with upd as (
  update prs_episodes set
    guest_name   = 'Jacqueline Berg-Ramsey',
    premiere_at  = '2025-08-26'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=lmkXusVF_Wg',
    video_id     = 'lmkXusVF_Wg',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":137,"ctr_pct":4.37,"avg_view_pct":8.43,"avg_view_duration_sec":309,"watch_time_hours":11.8,"subscribers_gained":0,"impressions":778}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'lmkXusVF_Wg'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'jacqueline-berg-ramsey-2', 'Jacqueline Berg-Ramsey', '2025-08-26'::date, 'shipped',
       'https://www.youtube.com/watch?v=lmkXusVF_Wg', 'lmkXusVF_Wg', '{"views":137,"ctr_pct":4.37,"avg_view_pct":8.43,"avg_view_duration_sec":309,"watch_time_hours":11.8,"subscribers_gained":0,"impressions":778}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'jacqueline-berg-ramsey-2');

-- y1HMgHv9GY0  AI Breaks Down Celebrity Meltdowns: Will Smith, Johnny Depp & the Sydney Sweeney
with upd as (
  update prs_episodes set
    guest_name   = 'AI Recap: Smith, Depp, Sweeney',
    premiere_at  = '2025-08-22'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=y1HMgHv9GY0',
    video_id     = 'y1HMgHv9GY0',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":3,"ctr_pct":0.59,"avg_view_pct":2.66,"avg_view_duration_sec":20,"watch_time_hours":0.02,"subscribers_gained":0,"impressions":337}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'y1HMgHv9GY0'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'ai-recap-smith-depp-sweeney', 'AI Recap: Smith, Depp, Sweeney', '2025-08-22'::date, 'shipped',
       'https://www.youtube.com/watch?v=y1HMgHv9GY0', 'y1HMgHv9GY0', '{"views":3,"ctr_pct":0.59,"avg_view_pct":2.66,"avg_view_duration_sec":20,"watch_time_hours":0.02,"subscribers_gained":0,"impressions":337}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'ai-recap-smith-depp-sweeney');

-- KLbM_3pQaEI  Matias Desiderio on Addiction, Love & Healing | Painful Lessons Podcast
with upd as (
  update prs_episodes set
    guest_name   = 'Matias Desiderio',
    premiere_at  = '2025-08-18'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=KLbM_3pQaEI',
    video_id     = 'KLbM_3pQaEI',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":9,"ctr_pct":1.08,"avg_view_pct":1.47,"avg_view_duration_sec":51,"watch_time_hours":0.13,"subscribers_gained":0,"impressions":557}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'KLbM_3pQaEI'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'matias-desiderio', 'Matias Desiderio', '2025-08-18'::date, 'shipped',
       'https://www.youtube.com/watch?v=KLbM_3pQaEI', 'KLbM_3pQaEI', '{"views":9,"ctr_pct":1.08,"avg_view_pct":1.47,"avg_view_duration_sec":51,"watch_time_hours":0.13,"subscribers_gained":0,"impressions":557}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'matias-desiderio');

-- LxwWVckXEuc  Jess Adams on Eating Disorder Behaviors, Body Shame & Recovery Clarity
with upd as (
  update prs_episodes set
    guest_name   = 'Jess Adams (Aug 2025 Short)',
    premiere_at  = '2025-08-14'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=LxwWVckXEuc',
    video_id     = 'LxwWVckXEuc',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":9,"ctr_pct":1.18,"avg_view_pct":12.95,"avg_view_duration_sec":50,"watch_time_hours":0.13,"subscribers_gained":0,"impressions":507}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'LxwWVckXEuc'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'jess-adams-aug-2025-short', 'Jess Adams (Aug 2025 Short)', '2025-08-14'::date, 'shipped',
       'https://www.youtube.com/watch?v=LxwWVckXEuc', 'LxwWVckXEuc', '{"views":9,"ctr_pct":1.18,"avg_view_pct":12.95,"avg_view_duration_sec":50,"watch_time_hours":0.13,"subscribers_gained":0,"impressions":507}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'jess-adams-aug-2025-short');

-- cgV8B7meYfE  AI Talks Will Smith, Sydney Sweeney & the Psychology of Pain | ChatGPT on Painfu
with upd as (
  update prs_episodes set
    guest_name   = 'AI on Painful Lessons (ChatGPT)',
    premiere_at  = '2025-08-11'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=cgV8B7meYfE',
    video_id     = 'cgV8B7meYfE',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":15,"ctr_pct":0.7,"avg_view_pct":0.1,"avg_view_duration_sec":4,"watch_time_hours":0.02,"subscribers_gained":0,"impressions":427}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'cgV8B7meYfE'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'ai-on-painful-lessons-chatgpt', 'AI on Painful Lessons (ChatGPT)', '2025-08-11'::date, 'shipped',
       'https://www.youtube.com/watch?v=cgV8B7meYfE', 'cgV8B7meYfE', '{"views":15,"ctr_pct":0.7,"avg_view_pct":0.1,"avg_view_duration_sec":4,"watch_time_hours":0.02,"subscribers_gained":0,"impressions":427}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'ai-on-painful-lessons-chatgpt');

-- tB4smb37-E8  Armie Hammer Reacts to WNBA Drama: Sophie Cunningham & Caitlin Clark | Painful L
with upd as (
  update prs_episodes set
    guest_name   = 'Armie Hammer (WNBA Nugget)',
    premiere_at  = '2025-07-31'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=tB4smb37-E8',
    video_id     = 'tB4smb37-E8',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":21,"ctr_pct":3.92,"avg_view_pct":17.51,"avg_view_duration_sec":61,"watch_time_hours":0.36,"subscribers_gained":0,"impressions":306}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'tB4smb37-E8'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'armie-hammer-wnba-nugget', 'Armie Hammer (WNBA Nugget)', '2025-07-31'::date, 'shipped',
       'https://www.youtube.com/watch?v=tB4smb37-E8', 'tB4smb37-E8', '{"views":21,"ctr_pct":3.92,"avg_view_pct":17.51,"avg_view_duration_sec":61,"watch_time_hours":0.36,"subscribers_gained":0,"impressions":306}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'armie-hammer-wnba-nugget');

-- 4LzTY2JhxRQ  TK McKamy on Country Music, Hot Country Knights & Making Movies From Hit Songs
with upd as (
  update prs_episodes set
    guest_name   = 'TK McKamy',
    premiere_at  = '2025-07-28'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=4LzTY2JhxRQ',
    video_id     = '4LzTY2JhxRQ',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":8,"ctr_pct":0.92,"avg_view_pct":3.14,"avg_view_duration_sec":100,"watch_time_hours":0.22,"subscribers_gained":0,"impressions":326}'::jsonb,
    metrics_updated_at = now()
  where video_id = '4LzTY2JhxRQ'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'tk-mckamy', 'TK McKamy', '2025-07-28'::date, 'shipped',
       'https://www.youtube.com/watch?v=4LzTY2JhxRQ', '4LzTY2JhxRQ', '{"views":8,"ctr_pct":0.92,"avg_view_pct":3.14,"avg_view_duration_sec":100,"watch_time_hours":0.22,"subscribers_gained":0,"impressions":326}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'tk-mckamy');

-- lqg8-bZ5zEE  The God Molecule Explained: Danny Goler on DMT, Reality & Consciousness
with upd as (
  update prs_episodes set
    guest_name   = 'Danny Goler (DMT Short)',
    premiere_at  = '2025-07-24'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=lqg8-bZ5zEE',
    video_id     = 'lqg8-bZ5zEE',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":160,"ctr_pct":4.24,"avg_view_pct":50.59,"avg_view_duration_sec":157,"watch_time_hours":7.02,"subscribers_gained":0,"impressions":1532}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'lqg8-bZ5zEE'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'danny-goler-dmt-short', 'Danny Goler (DMT Short)', '2025-07-24'::date, 'shipped',
       'https://www.youtube.com/watch?v=lqg8-bZ5zEE', 'lqg8-bZ5zEE', '{"views":160,"ctr_pct":4.24,"avg_view_pct":50.59,"avg_view_duration_sec":157,"watch_time_hours":7.02,"subscribers_gained":0,"impressions":1532}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'danny-goler-dmt-short');

-- SnpqjwbQ-Rg  Jess Adams on Recovery, Resilience & Reinvention | Painful Lessons Podcast
with upd as (
  update prs_episodes set
    guest_name   = 'Jess Adams',
    premiere_at  = '2025-07-21'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=SnpqjwbQ-Rg',
    video_id     = 'SnpqjwbQ-Rg',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":33,"ctr_pct":1.81,"avg_view_pct":26.08,"avg_view_duration_sec":1217,"watch_time_hours":11.16,"subscribers_gained":1,"impressions":664}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'SnpqjwbQ-Rg'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'jess-adams', 'Jess Adams', '2025-07-21'::date, 'shipped',
       'https://www.youtube.com/watch?v=SnpqjwbQ-Rg', 'SnpqjwbQ-Rg', '{"views":33,"ctr_pct":1.81,"avg_view_pct":26.08,"avg_view_duration_sec":1217,"watch_time_hours":11.16,"subscribers_gained":1,"impressions":664}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'jess-adams');

-- gBLiF12RQ68  Noah Weiland Opens Up About Losing His Father, Scott Weiland, and Finding His Ow
with upd as (
  update prs_episodes set
    guest_name   = 'Noah Weiland (Father Short)',
    premiere_at  = '2025-07-17'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=gBLiF12RQ68',
    video_id     = 'gBLiF12RQ68',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":741,"ctr_pct":6.51,"avg_view_pct":38.39,"avg_view_duration_sec":239,"watch_time_hours":49.31,"subscribers_gained":5,"impressions":7986}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'gBLiF12RQ68'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'noah-weiland-father-short', 'Noah Weiland (Father Short)', '2025-07-17'::date, 'shipped',
       'https://www.youtube.com/watch?v=gBLiF12RQ68', 'gBLiF12RQ68', '{"views":741,"ctr_pct":6.51,"avg_view_pct":38.39,"avg_view_duration_sec":239,"watch_time_hours":49.31,"subscribers_gained":5,"impressions":7986}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'noah-weiland-father-short');

-- 7lsharRp6yg  Claire Hoffman on the Dark Truth Behind Girls Gone Wild & Joe Francis
with upd as (
  update prs_episodes set
    guest_name   = 'Claire Hoffman (Girls Gone Wild Short)',
    premiere_at  = '2025-07-10'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=7lsharRp6yg',
    video_id     = '7lsharRp6yg',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":61,"ctr_pct":1.84,"avg_view_pct":20.12,"avg_view_duration_sec":151,"watch_time_hours":2.56,"subscribers_gained":0,"impressions":1791}'::jsonb,
    metrics_updated_at = now()
  where video_id = '7lsharRp6yg'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'claire-hoffman-girls-gone-wild-short', 'Claire Hoffman (Girls Gone Wild Short)', '2025-07-10'::date, 'shipped',
       'https://www.youtube.com/watch?v=7lsharRp6yg', '7lsharRp6yg', '{"views":61,"ctr_pct":1.84,"avg_view_pct":20.12,"avg_view_duration_sec":151,"watch_time_hours":2.56,"subscribers_gained":0,"impressions":1791}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'claire-hoffman-girls-gone-wild-short');

-- dxPI69y933g  Armie Hammer Returns - From Rock Bottom to Redemption | Painful Lessons Podcast
with upd as (
  update prs_episodes set
    guest_name   = 'Armie Hammer (Jul 2025)',
    premiere_at  = '2025-07-07'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=dxPI69y933g',
    video_id     = 'dxPI69y933g',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":1903,"ctr_pct":5.29,"avg_view_pct":11.28,"avg_view_duration_sec":521,"watch_time_hours":275.85,"subscribers_gained":10,"impressions":21276}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'dxPI69y933g'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'armie-hammer-jul-2025', 'Armie Hammer (Jul 2025)', '2025-07-07'::date, 'shipped',
       'https://www.youtube.com/watch?v=dxPI69y933g', 'dxPI69y933g', '{"views":1903,"ctr_pct":5.29,"avg_view_pct":11.28,"avg_view_duration_sec":521,"watch_time_hours":275.85,"subscribers_gained":10,"impressions":21276}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'armie-hammer-jul-2025');

-- 3qvSonmROVs  Oliver Trevena Survived a Brutal Attack—Then Rebuilt His Life
with upd as (
  update prs_episodes set
    guest_name   = 'Oliver Trevena (Attack Short)',
    premiere_at  = '2025-07-03'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=3qvSonmROVs',
    video_id     = '3qvSonmROVs',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":28,"ctr_pct":2.61,"avg_view_pct":22.88,"avg_view_duration_sec":102,"watch_time_hours":0.8,"subscribers_gained":0,"impressions":306}'::jsonb,
    metrics_updated_at = now()
  where video_id = '3qvSonmROVs'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'oliver-trevena-attack-short', 'Oliver Trevena (Attack Short)', '2025-07-03'::date, 'shipped',
       'https://www.youtube.com/watch?v=3qvSonmROVs', '3qvSonmROVs', '{"views":28,"ctr_pct":2.61,"avg_view_pct":22.88,"avg_view_duration_sec":102,"watch_time_hours":0.8,"subscribers_gained":0,"impressions":306}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'oliver-trevena-attack-short');

-- mc-WiKZoLao  Danny Goler on Expanding Consciousness & God Codes
with upd as (
  update prs_episodes set
    guest_name   = 'Danny Goler',
    premiere_at  = '2025-06-30'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=mc-WiKZoLao',
    video_id     = 'mc-WiKZoLao',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":1871,"ctr_pct":5.87,"avg_view_pct":23.75,"avg_view_duration_sec":902,"watch_time_hours":469.22,"subscribers_gained":15,"impressions":12154}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'mc-WiKZoLao'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'danny-goler', 'Danny Goler', '2025-06-30'::date, 'shipped',
       'https://www.youtube.com/watch?v=mc-WiKZoLao', 'mc-WiKZoLao', '{"views":1871,"ctr_pct":5.87,"avg_view_pct":23.75,"avg_view_duration_sec":902,"watch_time_hours":469.22,"subscribers_gained":15,"impressions":12154}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'danny-goler');

-- P8z3IUB25ps  Noah Weiland on Addiction, Legacy, and His Father Scott Weiland | Painful Lesson
with upd as (
  update prs_episodes set
    guest_name   = 'Noah Weiland',
    premiere_at  = '2025-06-23'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=P8z3IUB25ps',
    video_id     = 'P8z3IUB25ps',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":2316,"ctr_pct":5.8,"avg_view_pct":10.77,"avg_view_duration_sec":478,"watch_time_hours":307.75,"subscribers_gained":12,"impressions":24506}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'P8z3IUB25ps'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'noah-weiland', 'Noah Weiland', '2025-06-23'::date, 'shipped',
       'https://www.youtube.com/watch?v=P8z3IUB25ps', 'P8z3IUB25ps', '{"views":2316,"ctr_pct":5.8,"avg_view_pct":10.77,"avg_view_duration_sec":478,"watch_time_hours":307.75,"subscribers_gained":12,"impressions":24506}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'noah-weiland');

-- DlbmIB5bXOc  Nicole Aimee Schreiber and Tyler Ramsey Discuss Rumors and “Shenanigans” regardi
with upd as (
  update prs_episodes set
    guest_name   = 'Nicole Aimee Schreiber & Tyler (Rumors)',
    premiere_at  = '2025-06-19'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=DlbmIB5bXOc',
    video_id     = 'DlbmIB5bXOc',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":6,"ctr_pct":2.26,"avg_view_pct":37.87,"avg_view_duration_sec":160,"watch_time_hours":0.27,"subscribers_gained":0,"impressions":265}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'DlbmIB5bXOc'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'nicole-aimee-schreiber-tyler-rumors', 'Nicole Aimee Schreiber & Tyler (Rumors)', '2025-06-19'::date, 'shipped',
       'https://www.youtube.com/watch?v=DlbmIB5bXOc', 'DlbmIB5bXOc', '{"views":6,"ctr_pct":2.26,"avg_view_pct":37.87,"avg_view_duration_sec":160,"watch_time_hours":0.27,"subscribers_gained":0,"impressions":265}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'nicole-aimee-schreiber-tyler-rumors');

-- dCk9gshrpsg  "Claire Hoffman on Cults, Charisma & America's Forgotten Preacher | Painful Less
with upd as (
  update prs_episodes set
    guest_name   = 'Claire Hoffman (Cults)',
    premiere_at  = '2025-06-16'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=dCk9gshrpsg',
    video_id     = 'dCk9gshrpsg',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":13,"ctr_pct":2.35,"avg_view_pct":12.5,"avg_view_duration_sec":453,"watch_time_hours":1.64,"subscribers_gained":0,"impressions":255}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'dCk9gshrpsg'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'claire-hoffman-cults', 'Claire Hoffman (Cults)', '2025-06-16'::date, 'shipped',
       'https://www.youtube.com/watch?v=dCk9gshrpsg', 'dCk9gshrpsg', '{"views":13,"ctr_pct":2.35,"avg_view_pct":12.5,"avg_view_duration_sec":453,"watch_time_hours":1.64,"subscribers_gained":0,"impressions":255}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'claire-hoffman-cults');

-- 0Zdz-cFvrZw  Robert Downey Jr. Helped Save My Son’s Life | Steve Zacharias on Painful Lessons
with upd as (
  update prs_episodes set
    guest_name   = 'Steve Zacharias (RDJ Short)',
    premiere_at  = '2025-06-12'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=0Zdz-cFvrZw',
    video_id     = '0Zdz-cFvrZw',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":12,"ctr_pct":1.43,"avg_view_pct":29.81,"avg_view_duration_sec":110,"watch_time_hours":0.37,"subscribers_gained":0,"impressions":210}'::jsonb,
    metrics_updated_at = now()
  where video_id = '0Zdz-cFvrZw'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'steve-zacharias-rdj-short', 'Steve Zacharias (RDJ Short)', '2025-06-12'::date, 'shipped',
       'https://www.youtube.com/watch?v=0Zdz-cFvrZw', '0Zdz-cFvrZw', '{"views":12,"ctr_pct":1.43,"avg_view_pct":29.81,"avg_view_duration_sec":110,"watch_time_hours":0.37,"subscribers_gained":0,"impressions":210}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'steve-zacharias-rdj-short');

-- 0gJxKnaXhWo  Nicole Aimee Schreiber on Love, Comedy & Painful Lessons | Love Loss, Standup Gr
with upd as (
  update prs_episodes set
    guest_name   = 'Nicole Aimee Schreiber',
    premiere_at  = '2025-06-09'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=0gJxKnaXhWo',
    video_id     = '0gJxKnaXhWo',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":46,"ctr_pct":2.25,"avg_view_pct":5.72,"avg_view_duration_sec":217,"watch_time_hours":2.78,"subscribers_gained":1,"impressions":400}'::jsonb,
    metrics_updated_at = now()
  where video_id = '0gJxKnaXhWo'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'nicole-aimee-schreiber', 'Nicole Aimee Schreiber', '2025-06-09'::date, 'shipped',
       'https://www.youtube.com/watch?v=0gJxKnaXhWo', '0gJxKnaXhWo', '{"views":46,"ctr_pct":2.25,"avg_view_pct":5.72,"avg_view_duration_sec":217,"watch_time_hours":2.78,"subscribers_gained":1,"impressions":400}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'nicole-aimee-schreiber');

-- qSdgi0iClc8  Frankie Grande on Craving Attention: A Journey to Self-Acceptance | Painful Less
with upd as (
  update prs_episodes set
    guest_name   = 'Frankie Grande (Attention Short)',
    premiere_at  = '2025-06-05'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=qSdgi0iClc8',
    video_id     = 'qSdgi0iClc8',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":5,"ctr_pct":1.23,"avg_view_pct":35.34,"avg_view_duration_sec":58,"watch_time_hours":0.08,"subscribers_gained":0,"impressions":244}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'qSdgi0iClc8'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'frankie-grande-attention-short', 'Frankie Grande (Attention Short)', '2025-06-05'::date, 'shipped',
       'https://www.youtube.com/watch?v=qSdgi0iClc8', 'qSdgi0iClc8', '{"views":5,"ctr_pct":1.23,"avg_view_pct":35.34,"avg_view_duration_sec":58,"watch_time_hours":0.08,"subscribers_gained":0,"impressions":244}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'frankie-grande-attention-short');

-- fhs7W35D6Co  Oliver Trevena on Overcoming Trauma, Building Brands & Finding Balance | Painful
with upd as (
  update prs_episodes set
    guest_name   = 'Oliver Trevena',
    premiere_at  = '2025-06-02'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=fhs7W35D6Co',
    video_id     = 'fhs7W35D6Co',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":26,"ctr_pct":4.72,"avg_view_pct":17.64,"avg_view_duration_sec":541,"watch_time_hours":3.91,"subscribers_gained":0,"impressions":339}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'fhs7W35D6Co'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'oliver-trevena', 'Oliver Trevena', '2025-06-02'::date, 'shipped',
       'https://www.youtube.com/watch?v=fhs7W35D6Co', 'fhs7W35D6Co', '{"views":26,"ctr_pct":4.72,"avg_view_pct":17.64,"avg_view_duration_sec":541,"watch_time_hours":3.91,"subscribers_gained":0,"impressions":339}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'oliver-trevena');

-- Q0smsi6npBw  Jeremy Jackson’s Wildest Story: Kidnapped, High, and Fighting for His Life
with upd as (
  update prs_episodes set
    guest_name   = 'Jeremy Jackson (Kidnapped Short)',
    premiere_at  = '2025-05-29'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=Q0smsi6npBw',
    video_id     = 'Q0smsi6npBw',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":2,"ctr_pct":0,"avg_view_pct":3.78,"avg_view_duration_sec":13,"watch_time_hours":0.01,"subscribers_gained":0,"impressions":153}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'Q0smsi6npBw'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'jeremy-jackson-kidnapped-short', 'Jeremy Jackson (Kidnapped Short)', '2025-05-29'::date, 'shipped',
       'https://www.youtube.com/watch?v=Q0smsi6npBw', 'Q0smsi6npBw', '{"views":2,"ctr_pct":0,"avg_view_pct":3.78,"avg_view_duration_sec":13,"watch_time_hours":0.01,"subscribers_gained":0,"impressions":153}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'jeremy-jackson-kidnapped-short');

-- nfNdlQ79b6A  Revenge of the Nerds Writer Steve Zacharias on Hollywood and Recovery | Painful 
with upd as (
  update prs_episodes set
    guest_name   = 'Steve Zacharias',
    premiere_at  = '2025-05-26'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=nfNdlQ79b6A',
    video_id     = 'nfNdlQ79b6A',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":18,"ctr_pct":1.72,"avg_view_pct":19.6,"avg_view_duration_sec":638,"watch_time_hours":3.19,"subscribers_gained":0,"impressions":233}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'nfNdlQ79b6A'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'steve-zacharias', 'Steve Zacharias', '2025-05-26'::date, 'shipped',
       'https://www.youtube.com/watch?v=nfNdlQ79b6A', 'nfNdlQ79b6A', '{"views":18,"ctr_pct":1.72,"avg_view_pct":19.6,"avg_view_duration_sec":638,"watch_time_hours":3.19,"subscribers_gained":0,"impressions":233}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'steve-zacharias');

-- h7ZoRROJfEI  Josie Davis Exposes Gym Encounter: Standing Up to Manipulation | Painful Lessons
with upd as (
  update prs_episodes set
    guest_name   = 'Josie Davis (Gym Short)',
    premiere_at  = '2025-05-22'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=h7ZoRROJfEI',
    video_id     = 'h7ZoRROJfEI',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":25,"ctr_pct":2.37,"avg_view_pct":28.29,"avg_view_duration_sec":86,"watch_time_hours":0.6,"subscribers_gained":0,"impressions":759}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'h7ZoRROJfEI'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'josie-davis-gym-short', 'Josie Davis (Gym Short)', '2025-05-22'::date, 'shipped',
       'https://www.youtube.com/watch?v=h7ZoRROJfEI', 'h7ZoRROJfEI', '{"views":25,"ctr_pct":2.37,"avg_view_pct":28.29,"avg_view_duration_sec":86,"watch_time_hours":0.6,"subscribers_gained":0,"impressions":759}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'josie-davis-gym-short');

-- 4MKe00FaFiw  Jeremy Jackson on Baywatch Fame, Addiction, and Redemption | Painful Lessons Pod
with upd as (
  update prs_episodes set
    guest_name   = 'Jeremy Jackson',
    premiere_at  = '2025-05-19'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=4MKe00FaFiw',
    video_id     = '4MKe00FaFiw',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":202,"ctr_pct":4.86,"avg_view_pct":8.61,"avg_view_duration_sec":345,"watch_time_hours":19.41,"subscribers_gained":1,"impressions":987}'::jsonb,
    metrics_updated_at = now()
  where video_id = '4MKe00FaFiw'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'jeremy-jackson', 'Jeremy Jackson', '2025-05-19'::date, 'shipped',
       'https://www.youtube.com/watch?v=4MKe00FaFiw', '4MKe00FaFiw', '{"views":202,"ctr_pct":4.86,"avg_view_pct":8.61,"avg_view_duration_sec":345,"watch_time_hours":19.41,"subscribers_gained":1,"impressions":987}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'jeremy-jackson');

-- otrNxjaXF34  WRDSMTH (Phil Brody) on Street Art, Inspiration & Following Your Passion | Painf
with upd as (
  update prs_episodes set
    guest_name   = 'WRDSMTH / Phil Brody',
    premiere_at  = '2025-05-12'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=otrNxjaXF34',
    video_id     = 'otrNxjaXF34',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":8,"ctr_pct":0.47,"avg_view_pct":14.93,"avg_view_duration_sec":542,"watch_time_hours":1.21,"subscribers_gained":0,"impressions":214}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'otrNxjaXF34'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'wrdsmth-phil-brody', 'WRDSMTH / Phil Brody', '2025-05-12'::date, 'shipped',
       'https://www.youtube.com/watch?v=otrNxjaXF34', 'otrNxjaXF34', '{"views":8,"ctr_pct":0.47,"avg_view_pct":14.93,"avg_view_duration_sec":542,"watch_time_hours":1.21,"subscribers_gained":0,"impressions":214}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'wrdsmth-phil-brody');

-- byI7dNuG1hM  Josie Davis Opens Up: Acting, Podcasting & Life Lessons | Painful Lessons Podcas
with upd as (
  update prs_episodes set
    guest_name   = 'Josie Davis',
    premiere_at  = '2025-05-05'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=byI7dNuG1hM',
    video_id     = 'byI7dNuG1hM',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":84,"ctr_pct":2.49,"avg_view_pct":9.03,"avg_view_duration_sec":299,"watch_time_hours":6.98,"subscribers_gained":0,"impressions":401}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'byI7dNuG1hM'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'josie-davis', 'Josie Davis', '2025-05-05'::date, 'shipped',
       'https://www.youtube.com/watch?v=byI7dNuG1hM', 'byI7dNuG1hM', '{"views":84,"ctr_pct":2.49,"avg_view_pct":9.03,"avg_view_duration_sec":299,"watch_time_hours":6.98,"subscribers_gained":0,"impressions":401}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'josie-davis');

-- DAgJFsE0TzM  Frankie Grande Opens Up About Sobriety, Fame, and Family | Painful Lessons Podca
with upd as (
  update prs_episodes set
    guest_name   = 'Frankie Grande',
    premiere_at  = '2025-04-28'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=DAgJFsE0TzM',
    video_id     = 'DAgJFsE0TzM',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":114,"ctr_pct":3.11,"avg_view_pct":7.08,"avg_view_duration_sec":343,"watch_time_hours":10.87,"subscribers_gained":1,"impressions":2544}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'DAgJFsE0TzM'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'frankie-grande', 'Frankie Grande', '2025-04-28'::date, 'shipped',
       'https://www.youtube.com/watch?v=DAgJFsE0TzM', 'DAgJFsE0TzM', '{"views":114,"ctr_pct":3.11,"avg_view_pct":7.08,"avg_view_duration_sec":343,"watch_time_hours":10.87,"subscribers_gained":1,"impressions":2544}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'frankie-grande');

-- 2nFIfmvfXaQ  Faith Through Pain: Pastor Aaron Jayne's Journey | Painful Lessons Podcast
with upd as (
  update prs_episodes set
    guest_name   = 'Pastor Aaron Jayne',
    premiere_at  = '2025-04-22'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=2nFIfmvfXaQ',
    video_id     = '2nFIfmvfXaQ',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":15,"ctr_pct":2.12,"avg_view_pct":6.77,"avg_view_duration_sec":326,"watch_time_hours":1.36,"subscribers_gained":0,"impressions":189}'::jsonb,
    metrics_updated_at = now()
  where video_id = '2nFIfmvfXaQ'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'pastor-aaron-jayne', 'Pastor Aaron Jayne', '2025-04-22'::date, 'shipped',
       'https://www.youtube.com/watch?v=2nFIfmvfXaQ', '2nFIfmvfXaQ', '{"views":15,"ctr_pct":2.12,"avg_view_pct":6.77,"avg_view_duration_sec":326,"watch_time_hours":1.36,"subscribers_gained":0,"impressions":189}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'pastor-aaron-jayne');

-- bebTjcqFcA8  Former ESPN Anchor James Swanwick Talks Celebrity Sobriety, Living Alcohol-Free,
with upd as (
  update prs_episodes set
    guest_name   = 'James Swanwick',
    premiere_at  = '2025-03-31'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=bebTjcqFcA8',
    video_id     = 'bebTjcqFcA8',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":19,"ctr_pct":2.09,"avg_view_pct":10.3,"avg_view_duration_sec":373,"watch_time_hours":1.97,"subscribers_gained":0,"impressions":191}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'bebTjcqFcA8'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'james-swanwick', 'James Swanwick', '2025-03-31'::date, 'shipped',
       'https://www.youtube.com/watch?v=bebTjcqFcA8', 'bebTjcqFcA8', '{"views":19,"ctr_pct":2.09,"avg_view_pct":10.3,"avg_view_duration_sec":373,"watch_time_hours":1.97,"subscribers_gained":0,"impressions":191}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'james-swanwick');

-- _O-rI0vLwKk  INSIDE Leonardo DiCaprio's WILD House Party
with upd as (
  update prs_episodes set
    guest_name   = 'Leonardo DiCaprio (House Party Short)',
    premiere_at  = '2025-03-26'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=_O-rI0vLwKk',
    video_id     = '_O-rI0vLwKk',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":77,"ctr_pct":8.53,"avg_view_pct":53.78,"avg_view_duration_sec":287,"watch_time_hours":6.15,"subscribers_gained":0,"impressions":434}'::jsonb,
    metrics_updated_at = now()
  where video_id = '_O-rI0vLwKk'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'leonardo-dicaprio-house-party-short', 'Leonardo DiCaprio (House Party Short)', '2025-03-26'::date, 'shipped',
       'https://www.youtube.com/watch?v=_O-rI0vLwKk', '_O-rI0vLwKk', '{"views":77,"ctr_pct":8.53,"avg_view_pct":53.78,"avg_view_duration_sec":287,"watch_time_hours":6.15,"subscribers_gained":0,"impressions":434}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'leonardo-dicaprio-house-party-short');

-- X0uzXU5UeRA  Tyler Talks Blake Lively & Justin Baldoni Controversy, Bill Maher, and South Par
with upd as (
  update prs_episodes set
    guest_name   = 'Tyler on Lively/Baldoni/Maher',
    premiere_at  = '2025-03-24'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=X0uzXU5UeRA',
    video_id     = 'X0uzXU5UeRA',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":9,"ctr_pct":1.31,"avg_view_pct":0.42,"avg_view_duration_sec":18,"watch_time_hours":0.05,"subscribers_gained":0,"impressions":229}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'X0uzXU5UeRA'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'tyler-on-lively-baldoni-maher', 'Tyler on Lively/Baldoni/Maher', '2025-03-24'::date, 'shipped',
       'https://www.youtube.com/watch?v=X0uzXU5UeRA', 'X0uzXU5UeRA', '{"views":9,"ctr_pct":1.31,"avg_view_pct":0.42,"avg_view_duration_sec":18,"watch_time_hours":0.05,"subscribers_gained":0,"impressions":229}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'tyler-on-lively-baldoni-maher');

-- RwBDK4TPUxI  This Is Us, Stranger Things, & Marvel Actor Chris Sullivan Talks Recovery | Pain
with upd as (
  update prs_episodes set
    guest_name   = 'Chris Sullivan',
    premiere_at  = '2025-03-17'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=RwBDK4TPUxI',
    video_id     = 'RwBDK4TPUxI',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":16,"ctr_pct":3.15,"avg_view_pct":4.67,"avg_view_duration_sec":201,"watch_time_hours":0.9,"subscribers_gained":0,"impressions":349}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'RwBDK4TPUxI'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'chris-sullivan', 'Chris Sullivan', '2025-03-17'::date, 'shipped',
       'https://www.youtube.com/watch?v=RwBDK4TPUxI', 'RwBDK4TPUxI', '{"views":16,"ctr_pct":3.15,"avg_view_pct":4.67,"avg_view_duration_sec":201,"watch_time_hours":0.9,"subscribers_gained":0,"impressions":349}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'chris-sullivan');

-- ZX_BKCXZtw8  A Conversation About Sobriety, Matthew Perry, and Leonardo DiCaprio with Dani Dr
with upd as (
  update prs_episodes set
    guest_name   = 'Dani Druz',
    premiere_at  = '2025-03-10'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=ZX_BKCXZtw8',
    video_id     = 'ZX_BKCXZtw8',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":55,"ctr_pct":4.09,"avg_view_pct":2.55,"avg_view_duration_sec":156,"watch_time_hours":2.4,"subscribers_gained":0,"impressions":269}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'ZX_BKCXZtw8'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'dani-druz', 'Dani Druz', '2025-03-10'::date, 'shipped',
       'https://www.youtube.com/watch?v=ZX_BKCXZtw8', 'ZX_BKCXZtw8', '{"views":55,"ctr_pct":4.09,"avg_view_pct":2.55,"avg_view_duration_sec":156,"watch_time_hours":2.4,"subscribers_gained":0,"impressions":269}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'dani-druz');

-- jcswfdLUpH0  The MOST SHOCKING Art Buying Story Ever Told
with upd as (
  update prs_episodes set
    guest_name   = 'Art Buying Story (Short)',
    premiere_at  = '2025-03-07'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=jcswfdLUpH0',
    video_id     = 'jcswfdLUpH0',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":4,"ctr_pct":0.81,"avg_view_pct":2.54,"avg_view_duration_sec":18,"watch_time_hours":0.02,"subscribers_gained":0,"impressions":124}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'jcswfdLUpH0'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'art-buying-story-short', 'Art Buying Story (Short)', '2025-03-07'::date, 'shipped',
       'https://www.youtube.com/watch?v=jcswfdLUpH0', 'jcswfdLUpH0', '{"views":4,"ctr_pct":0.81,"avg_view_pct":2.54,"avg_view_duration_sec":18,"watch_time_hours":0.02,"subscribers_gained":0,"impressions":124}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'art-buying-story-short');

-- YVxCTdbeGOo  Tyler's Top 10 Movies with Brad Pitt, James Gandolfini, Miles Teller, Robert Dow
with upd as (
  update prs_episodes set
    guest_name   = 'Tyler''s Top 10 Movies',
    premiere_at  = '2025-03-03'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=YVxCTdbeGOo',
    video_id     = 'YVxCTdbeGOo',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":9,"ctr_pct":2.29,"avg_view_pct":18.16,"avg_view_duration_sec":424,"watch_time_hours":1.06,"subscribers_gained":0,"impressions":175}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'YVxCTdbeGOo'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'tylers-top-10-movies', 'Tyler''s Top 10 Movies', '2025-03-03'::date, 'shipped',
       'https://www.youtube.com/watch?v=YVxCTdbeGOo', 'YVxCTdbeGOo', '{"views":9,"ctr_pct":2.29,"avg_view_pct":18.16,"avg_view_duration_sec":424,"watch_time_hours":1.06,"subscribers_gained":0,"impressions":175}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'tylers-top-10-movies');

-- LB-Av2u4V8A  Walter May Shares Lessons About Working in Hollywood, Working with Katy Perry, a
with upd as (
  update prs_episodes set
    guest_name   = 'Walter May',
    premiere_at  = '2025-02-17'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=LB-Av2u4V8A',
    video_id     = 'LB-Av2u4V8A',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":11,"ctr_pct":1.97,"avg_view_pct":2.31,"avg_view_duration_sec":111,"watch_time_hours":0.34,"subscribers_gained":0,"impressions":152}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'LB-Av2u4V8A'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'walter-may', 'Walter May', '2025-02-17'::date, 'shipped',
       'https://www.youtube.com/watch?v=LB-Av2u4V8A', 'LB-Av2u4V8A', '{"views":11,"ctr_pct":1.97,"avg_view_pct":2.31,"avg_view_duration_sec":111,"watch_time_hours":0.34,"subscribers_gained":0,"impressions":152}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'walter-may');

-- 5mwkNP_rJo4  Joshua David Earp Bends A Coin With His Mind, Talks About Ancestor Wyatt Earp, A
with upd as (
  update prs_episodes set
    guest_name   = 'Joshua David Earp',
    premiere_at  = '2025-02-10'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=5mwkNP_rJo4',
    video_id     = '5mwkNP_rJo4',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":40,"ctr_pct":3.38,"avg_view_pct":13.99,"avg_view_duration_sec":515,"watch_time_hours":5.73,"subscribers_gained":2,"impressions":237}'::jsonb,
    metrics_updated_at = now()
  where video_id = '5mwkNP_rJo4'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'joshua-david-earp', 'Joshua David Earp', '2025-02-10'::date, 'shipped',
       'https://www.youtube.com/watch?v=5mwkNP_rJo4', '5mwkNP_rJo4', '{"views":40,"ctr_pct":3.38,"avg_view_pct":13.99,"avg_view_duration_sec":515,"watch_time_hours":5.73,"subscribers_gained":2,"impressions":237}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'joshua-david-earp');

-- jPbUwE3fTac  Billy Jensen Talks True Crime, Recovery, and Working with Patton Oswalt
with upd as (
  update prs_episodes set
    guest_name   = 'Billy Jensen (Feb 2025)',
    premiere_at  = '2025-02-03'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=jPbUwE3fTac',
    video_id     = 'jPbUwE3fTac',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":45,"ctr_pct":3.57,"avg_view_pct":7.97,"avg_view_duration_sec":439,"watch_time_hours":5.49,"subscribers_gained":0,"impressions":224}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'jPbUwE3fTac'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'billy-jensen-feb-2025', 'Billy Jensen (Feb 2025)', '2025-02-03'::date, 'shipped',
       'https://www.youtube.com/watch?v=jPbUwE3fTac', 'jPbUwE3fTac', '{"views":45,"ctr_pct":3.57,"avg_view_pct":7.97,"avg_view_duration_sec":439,"watch_time_hours":5.49,"subscribers_gained":0,"impressions":224}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'billy-jensen-feb-2025');

-- JD1eam1nCEI  David Dastmalchian's Heist Gone Wrong
with upd as (
  update prs_episodes set
    guest_name   = 'David Dastmalchian (Heist Short)',
    premiere_at  = '2025-01-28'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=JD1eam1nCEI',
    video_id     = 'JD1eam1nCEI',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":3,"ctr_pct":0.84,"avg_view_pct":33.86,"avg_view_duration_sec":168,"watch_time_hours":0.14,"subscribers_gained":0,"impressions":119}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'JD1eam1nCEI'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'david-dastmalchian-heist-short', 'David Dastmalchian (Heist Short)', '2025-01-28'::date, 'shipped',
       'https://www.youtube.com/watch?v=JD1eam1nCEI', 'JD1eam1nCEI', '{"views":3,"ctr_pct":0.84,"avg_view_pct":33.86,"avg_view_duration_sec":168,"watch_time_hours":0.14,"subscribers_gained":0,"impressions":119}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'david-dastmalchian-heist-short');

-- Oaz5Gbihf-8  Tom Arnold Shares The TRUTH About Chris Farley
with upd as (
  update prs_episodes set
    guest_name   = 'Tom Arnold (Chris Farley Short)',
    premiere_at  = '2025-01-27'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=Oaz5Gbihf-8',
    video_id     = 'Oaz5Gbihf-8',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":71,"ctr_pct":5.53,"avg_view_pct":57.81,"avg_view_duration_sec":198,"watch_time_hours":3.92,"subscribers_gained":1,"impressions":597}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'Oaz5Gbihf-8'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'tom-arnold-chris-farley-short', 'Tom Arnold (Chris Farley Short)', '2025-01-27'::date, 'shipped',
       'https://www.youtube.com/watch?v=Oaz5Gbihf-8', 'Oaz5Gbihf-8', '{"views":71,"ctr_pct":5.53,"avg_view_pct":57.81,"avg_view_duration_sec":198,"watch_time_hours":3.92,"subscribers_gained":1,"impressions":597}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'tom-arnold-chris-farley-short');

-- PiUGyL1sEpI  Trek Thunder Kelly Talks About Making Art In Ukraine
with upd as (
  update prs_episodes set
    guest_name   = 'Trek Thunder Kelly (Ukraine Short)',
    premiere_at  = '2025-01-23'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=PiUGyL1sEpI',
    video_id     = 'PiUGyL1sEpI',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":11,"ctr_pct":0.79,"avg_view_pct":55.08,"avg_view_duration_sec":137,"watch_time_hours":0.42,"subscribers_gained":0,"impressions":127}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'PiUGyL1sEpI'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'trek-thunder-kelly-ukraine-short', 'Trek Thunder Kelly (Ukraine Short)', '2025-01-23'::date, 'shipped',
       'https://www.youtube.com/watch?v=PiUGyL1sEpI', 'PiUGyL1sEpI', '{"views":11,"ctr_pct":0.79,"avg_view_pct":55.08,"avg_view_duration_sec":137,"watch_time_hours":0.42,"subscribers_gained":0,"impressions":127}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'trek-thunder-kelly-ukraine-short');

-- PZv_gceoIds  Similarities Between Stanford Prison Experience and Hazing in Fraternities
with upd as (
  update prs_episodes set
    guest_name   = 'Stanford Prison & Hazing (Short)',
    premiere_at  = '2025-01-21'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=PZv_gceoIds',
    video_id     = 'PZv_gceoIds',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":4,"ctr_pct":1.8,"avg_view_pct":48.44,"avg_view_duration_sec":215,"watch_time_hours":0.24,"subscribers_gained":0,"impressions":111}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'PZv_gceoIds'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'stanford-prison-hazing-short', 'Stanford Prison & Hazing (Short)', '2025-01-21'::date, 'shipped',
       'https://www.youtube.com/watch?v=PZv_gceoIds', 'PZv_gceoIds', '{"views":4,"ctr_pct":1.8,"avg_view_pct":48.44,"avg_view_duration_sec":215,"watch_time_hours":0.24,"subscribers_gained":0,"impressions":111}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'stanford-prison-hazing-short');

-- A9w6RVXZ3uo  Trek Thunder Kelly Talks Burning Man, Making Art in Ukraine, And Wearing A Barbe
with upd as (
  update prs_episodes set
    guest_name   = 'Trek Thunder Kelly',
    premiere_at  = '2025-01-20'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=A9w6RVXZ3uo',
    video_id     = 'A9w6RVXZ3uo',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":12,"ctr_pct":2.19,"avg_view_pct":1.58,"avg_view_duration_sec":33,"watch_time_hours":0.11,"subscribers_gained":0,"impressions":137}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'A9w6RVXZ3uo'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'trek-thunder-kelly', 'Trek Thunder Kelly', '2025-01-20'::date, 'shipped',
       'https://www.youtube.com/watch?v=A9w6RVXZ3uo', 'A9w6RVXZ3uo', '{"views":12,"ctr_pct":2.19,"avg_view_pct":1.58,"avg_view_duration_sec":33,"watch_time_hours":0.11,"subscribers_gained":0,"impressions":137}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'trek-thunder-kelly');

-- PVSzKNBWzTE  Cameron Moulene Created An AI Company To Help His Son's Autism
with upd as (
  update prs_episodes set
    guest_name   = 'Cameron Moulene (AI Company Short)',
    premiere_at  = '2025-01-14'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=PVSzKNBWzTE',
    video_id     = 'PVSzKNBWzTE',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":25,"ctr_pct":0,"avg_view_pct":13.7,"avg_view_duration_sec":80,"watch_time_hours":0.56,"subscribers_gained":0,"impressions":140}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'PVSzKNBWzTE'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'cameron-moulene-ai-company-short', 'Cameron Moulene (AI Company Short)', '2025-01-14'::date, 'shipped',
       'https://www.youtube.com/watch?v=PVSzKNBWzTE', 'PVSzKNBWzTE', '{"views":25,"ctr_pct":0,"avg_view_pct":13.7,"avg_view_duration_sec":80,"watch_time_hours":0.56,"subscribers_gained":0,"impressions":140}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'cameron-moulene-ai-company-short');

-- -ZtHG4wwjTY  Cameron Moulene on Growing Up in Hollywood, Becoming Sober, and Starting A #poke
with upd as (
  update prs_episodes set
    guest_name   = 'Cameron Moulene',
    premiere_at  = '2025-01-13'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=-ZtHG4wwjTY',
    video_id     = '-ZtHG4wwjTY',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":95,"ctr_pct":4.09,"avg_view_pct":11.44,"avg_view_duration_sec":505,"watch_time_hours":13.33,"subscribers_gained":0,"impressions":318}'::jsonb,
    metrics_updated_at = now()
  where video_id = '-ZtHG4wwjTY'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'cameron-moulene', 'Cameron Moulene', '2025-01-13'::date, 'shipped',
       'https://www.youtube.com/watch?v=-ZtHG4wwjTY', '-ZtHG4wwjTY', '{"views":95,"ctr_pct":4.09,"avg_view_pct":11.44,"avg_view_duration_sec":505,"watch_time_hours":13.33,"subscribers_gained":0,"impressions":318}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'cameron-moulene');

-- _omgILq6zEM  Armie Hammer Got "FLAVA FLAKED" by Flava Flav #flavaflav
with upd as (
  update prs_episodes set
    guest_name   = 'Armie Hammer (Flava Flav Short)',
    premiere_at  = '2025-01-02'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=_omgILq6zEM',
    video_id     = '_omgILq6zEM',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":13,"ctr_pct":4.21,"avg_view_pct":30.85,"avg_view_duration_sec":61,"watch_time_hours":0.22,"subscribers_gained":0,"impressions":214}'::jsonb,
    metrics_updated_at = now()
  where video_id = '_omgILq6zEM'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'armie-hammer-flava-flav-short', 'Armie Hammer (Flava Flav Short)', '2025-01-02'::date, 'shipped',
       'https://www.youtube.com/watch?v=_omgILq6zEM', '_omgILq6zEM', '{"views":13,"ctr_pct":4.21,"avg_view_pct":30.85,"avg_view_duration_sec":61,"watch_time_hours":0.22,"subscribers_gained":0,"impressions":214}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'armie-hammer-flava-flav-short');

-- 9mIL7c6u1lc  Armie Hammer Shares Unbelievable Taylor Sheridan Story #yellowstone #lioness
with upd as (
  update prs_episodes set
    guest_name   = 'Armie Hammer (Sheridan Short)',
    premiere_at  = '2024-12-27'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=9mIL7c6u1lc',
    video_id     = '9mIL7c6u1lc',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":5,"ctr_pct":1.6,"avg_view_pct":37.91,"avg_view_duration_sec":140,"watch_time_hours":0.2,"subscribers_gained":0,"impressions":125}'::jsonb,
    metrics_updated_at = now()
  where video_id = '9mIL7c6u1lc'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'armie-hammer-sheridan-short', 'Armie Hammer (Sheridan Short)', '2024-12-27'::date, 'shipped',
       'https://www.youtube.com/watch?v=9mIL7c6u1lc', '9mIL7c6u1lc', '{"views":5,"ctr_pct":1.6,"avg_view_pct":37.91,"avg_view_duration_sec":140,"watch_time_hours":0.2,"subscribers_gained":0,"impressions":125}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'armie-hammer-sheridan-short');

-- sDtQ2-pa_bk  Special Holiday Mashup with Armie Hammer: Things We Loved in 2024!
with upd as (
  update prs_episodes set
    guest_name   = 'Armie Hammer (Holiday Mashup)',
    premiere_at  = '2024-12-23'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=sDtQ2-pa_bk',
    video_id     = 'sDtQ2-pa_bk',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":282,"ctr_pct":3.94,"avg_view_pct":17.1,"avg_view_duration_sec":501,"watch_time_hours":39.26,"subscribers_gained":4,"impressions":4417}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'sDtQ2-pa_bk'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'armie-hammer-holiday-mashup', 'Armie Hammer (Holiday Mashup)', '2024-12-23'::date, 'shipped',
       'https://www.youtube.com/watch?v=sDtQ2-pa_bk', 'sDtQ2-pa_bk', '{"views":282,"ctr_pct":3.94,"avg_view_pct":17.1,"avg_view_duration_sec":501,"watch_time_hours":39.26,"subscribers_gained":4,"impressions":4417}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'armie-hammer-holiday-mashup');

-- zZ-d1nG6-W0  The TRUTH About Meghan Markle
with upd as (
  update prs_episodes set
    guest_name   = 'Meghan Markle (Short)',
    premiere_at  = '2024-12-18'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=zZ-d1nG6-W0',
    video_id     = 'zZ-d1nG6-W0',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":12,"ctr_pct":2.26,"avg_view_pct":57.26,"avg_view_duration_sec":227,"watch_time_hours":0.76,"subscribers_gained":0,"impressions":133}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'zZ-d1nG6-W0'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'meghan-markle-short', 'Meghan Markle (Short)', '2024-12-18'::date, 'shipped',
       'https://www.youtube.com/watch?v=zZ-d1nG6-W0', 'zZ-d1nG6-W0', '{"views":12,"ctr_pct":2.26,"avg_view_pct":57.26,"avg_view_duration_sec":227,"watch_time_hours":0.76,"subscribers_gained":0,"impressions":133}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'meghan-markle-short');

-- zPQgXyJiSwo  Shawn Meaike Talks Entrepreneurship, Overcoming Addiction, Stopping Alex Rodrigu
with upd as (
  update prs_episodes set
    guest_name   = 'Shawn Meaike',
    premiere_at  = '2024-12-16'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=zPQgXyJiSwo',
    video_id     = 'zPQgXyJiSwo',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":36,"ctr_pct":3.68,"avg_view_pct":8.85,"avg_view_duration_sec":345,"watch_time_hours":3.45,"subscribers_gained":0,"impressions":380}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'zPQgXyJiSwo'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'shawn-meaike', 'Shawn Meaike', '2024-12-16'::date, 'shipped',
       'https://www.youtube.com/watch?v=zPQgXyJiSwo', 'zPQgXyJiSwo', '{"views":36,"ctr_pct":3.68,"avg_view_pct":8.85,"avg_view_duration_sec":345,"watch_time_hours":3.45,"subscribers_gained":0,"impressions":380}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'shawn-meaike');

-- sRzGqky1Mfk  Keegan Caldwell Talks Recovery, Artificial Intelligence, And More
with upd as (
  update prs_episodes set
    guest_name   = 'Keegan Caldwell',
    premiere_at  = '2024-12-09'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=sRzGqky1Mfk',
    video_id     = 'sRzGqky1Mfk',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":21,"ctr_pct":2.27,"avg_view_pct":15.67,"avg_view_duration_sec":564,"watch_time_hours":3.29,"subscribers_gained":0,"impressions":132}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'sRzGqky1Mfk'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'keegan-caldwell', 'Keegan Caldwell', '2024-12-09'::date, 'shipped',
       'https://www.youtube.com/watch?v=sRzGqky1Mfk', 'sRzGqky1Mfk', '{"views":21,"ctr_pct":2.27,"avg_view_pct":15.67,"avg_view_duration_sec":564,"watch_time_hours":3.29,"subscribers_gained":0,"impressions":132}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'keegan-caldwell');

-- P-56YpigsJU  Jeremy Cahen AKA "Pauly0x" Talks About Helping His Friend Armie Hammer Get Sober
with upd as (
  update prs_episodes set
    guest_name   = 'Jeremy Cahen (Armie Short)',
    premiere_at  = '2024-12-05'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=P-56YpigsJU',
    video_id     = 'P-56YpigsJU',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":28,"ctr_pct":3.58,"avg_view_pct":20.53,"avg_view_duration_sec":106,"watch_time_hours":0.83,"subscribers_gained":0,"impressions":279}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'P-56YpigsJU'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'jeremy-cahen-armie-short', 'Jeremy Cahen (Armie Short)', '2024-12-05'::date, 'shipped',
       'https://www.youtube.com/watch?v=P-56YpigsJU', 'P-56YpigsJU', '{"views":28,"ctr_pct":3.58,"avg_view_pct":20.53,"avg_view_duration_sec":106,"watch_time_hours":0.83,"subscribers_gained":0,"impressions":279}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'jeremy-cahen-armie-short');

-- OLpTFbOkJaQ  Jeremy Cahen, AKA Pauly0x Talks Crypto, Painful Lessons In Life, And More
with upd as (
  update prs_episodes set
    guest_name   = 'Jeremy Cahen',
    premiere_at  = '2024-12-02'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=OLpTFbOkJaQ',
    video_id     = 'OLpTFbOkJaQ',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":68,"ctr_pct":2.59,"avg_view_pct":7.25,"avg_view_duration_sec":233,"watch_time_hours":4.41,"subscribers_gained":0,"impressions":425}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'OLpTFbOkJaQ'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'jeremy-cahen', 'Jeremy Cahen', '2024-12-02'::date, 'shipped',
       'https://www.youtube.com/watch?v=OLpTFbOkJaQ', 'OLpTFbOkJaQ', '{"views":68,"ctr_pct":2.59,"avg_view_pct":7.25,"avg_view_duration_sec":233,"watch_time_hours":4.41,"subscribers_gained":0,"impressions":425}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'jeremy-cahen');

-- lolIvc4lHlk  EXCLUSIVE: Armie Hammer REVEALS THE TRUTH About His Mistake
with upd as (
  update prs_episodes set
    guest_name   = 'Armie Hammer (Truth Short)',
    premiere_at  = '2024-11-28'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=lolIvc4lHlk',
    video_id     = 'lolIvc4lHlk',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":10,"ctr_pct":4.69,"avg_view_pct":18.75,"avg_view_duration_sec":110,"watch_time_hours":0.31,"subscribers_gained":0,"impressions":128}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'lolIvc4lHlk'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'armie-hammer-truth-short', 'Armie Hammer (Truth Short)', '2024-11-28'::date, 'shipped',
       'https://www.youtube.com/watch?v=lolIvc4lHlk', 'lolIvc4lHlk', '{"views":10,"ctr_pct":4.69,"avg_view_pct":18.75,"avg_view_duration_sec":110,"watch_time_hours":0.31,"subscribers_gained":0,"impressions":128}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'armie-hammer-truth-short');

-- CXMAfsDK0Yk  Kristoffer Polaha on Making Hallmark Movies, Working with Meghan Markle, and Les
with upd as (
  update prs_episodes set
    guest_name   = 'Kristoffer Polaha',
    premiere_at  = '2024-11-25'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=CXMAfsDK0Yk',
    video_id     = 'CXMAfsDK0Yk',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":76,"ctr_pct":7.91,"avg_view_pct":16.13,"avg_view_duration_sec":737,"watch_time_hours":15.56,"subscribers_gained":0,"impressions":594}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'CXMAfsDK0Yk'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'kristoffer-polaha', 'Kristoffer Polaha', '2024-11-25'::date, 'shipped',
       'https://www.youtube.com/watch?v=CXMAfsDK0Yk', 'CXMAfsDK0Yk', '{"views":76,"ctr_pct":7.91,"avg_view_pct":16.13,"avg_view_duration_sec":737,"watch_time_hours":15.56,"subscribers_gained":0,"impressions":594}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'kristoffer-polaha');

-- SJ0ii7ECWGc  David Dastmalchian Shares His Biggest Life Lesson
with upd as (
  update prs_episodes set
    guest_name   = 'David Dastmalchian (Lesson Short)',
    premiere_at  = '2024-11-21'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=SJ0ii7ECWGc',
    video_id     = 'SJ0ii7ECWGc',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":11,"ctr_pct":2.87,"avg_view_pct":23.15,"avg_view_duration_sec":159,"watch_time_hours":0.49,"subscribers_gained":0,"impressions":174}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'SJ0ii7ECWGc'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'david-dastmalchian-lesson-short', 'David Dastmalchian (Lesson Short)', '2024-11-21'::date, 'shipped',
       'https://www.youtube.com/watch?v=SJ0ii7ECWGc', 'SJ0ii7ECWGc', '{"views":11,"ctr_pct":2.87,"avg_view_pct":23.15,"avg_view_duration_sec":159,"watch_time_hours":0.49,"subscribers_gained":0,"impressions":174}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'david-dastmalchian-lesson-short');

-- fwMOPx4WHA8  David Dastmalchian Talks DC Studios, His Love for Comics, and His Recovery
with upd as (
  update prs_episodes set
    guest_name   = 'David Dastmalchian',
    premiere_at  = '2024-11-18'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=fwMOPx4WHA8',
    video_id     = 'fwMOPx4WHA8',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":281,"ctr_pct":3.45,"avg_view_pct":13.5,"avg_view_duration_sec":603,"watch_time_hours":47.14,"subscribers_gained":0,"impressions":5337}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'fwMOPx4WHA8'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'david-dastmalchian', 'David Dastmalchian', '2024-11-18'::date, 'shipped',
       'https://www.youtube.com/watch?v=fwMOPx4WHA8', 'fwMOPx4WHA8', '{"views":281,"ctr_pct":3.45,"avg_view_pct":13.5,"avg_view_duration_sec":603,"watch_time_hours":47.14,"subscribers_gained":0,"impressions":5337}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'david-dastmalchian');

-- fU09_wpmU9U  Tom Arnold Describes Being On Set with James Cameron, Leonardo DiCaprio, and Arn
with upd as (
  update prs_episodes set
    guest_name   = 'Tom Arnold (Cameron/DiCaprio Short)',
    premiere_at  = '2024-11-13'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=fU09_wpmU9U',
    video_id     = 'fU09_wpmU9U',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":12,"ctr_pct":3.74,"avg_view_pct":39.54,"avg_view_duration_sec":192,"watch_time_hours":0.64,"subscribers_gained":0,"impressions":214}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'fU09_wpmU9U'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'tom-arnold-cameron-dicaprio-short', 'Tom Arnold (Cameron/DiCaprio Short)', '2024-11-13'::date, 'shipped',
       'https://www.youtube.com/watch?v=fU09_wpmU9U', 'fU09_wpmU9U', '{"views":12,"ctr_pct":3.74,"avg_view_pct":39.54,"avg_view_duration_sec":192,"watch_time_hours":0.64,"subscribers_gained":0,"impressions":214}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'tom-arnold-cameron-dicaprio-short');

-- g28FoEWa-Ls  Tom Arnold's Wild Night with Hugh Grant featuring Robin Williams and Madonna
with upd as (
  update prs_episodes set
    guest_name   = 'Tom Arnold (Hugh Grant Short)',
    premiere_at  = '2024-11-09'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=g28FoEWa-Ls',
    video_id     = 'g28FoEWa-Ls',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":86,"ctr_pct":5.46,"avg_view_pct":50.58,"avg_view_duration_sec":212,"watch_time_hours":5.08,"subscribers_gained":0,"impressions":769}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'g28FoEWa-Ls'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'tom-arnold-hugh-grant-short', 'Tom Arnold (Hugh Grant Short)', '2024-11-09'::date, 'shipped',
       'https://www.youtube.com/watch?v=g28FoEWa-Ls', 'g28FoEWa-Ls', '{"views":86,"ctr_pct":5.46,"avg_view_pct":50.58,"avg_view_duration_sec":212,"watch_time_hours":5.08,"subscribers_gained":0,"impressions":769}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'tom-arnold-hugh-grant-short');

-- G9pNK_-TjJg  What Are The Biggest Life Lessons of King David from the Bible?
with upd as (
  update prs_episodes set
    guest_name   = 'King David Lessons',
    premiere_at  = '2024-11-04'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=G9pNK_-TjJg',
    video_id     = 'G9pNK_-TjJg',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":2,"ctr_pct":0,"avg_view_pct":77.1,"avg_view_duration_sec":329,"watch_time_hours":0.18,"subscribers_gained":0,"impressions":96}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'G9pNK_-TjJg'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'king-david-lessons', 'King David Lessons', '2024-11-04'::date, 'shipped',
       'https://www.youtube.com/watch?v=G9pNK_-TjJg', 'G9pNK_-TjJg', '{"views":2,"ctr_pct":0,"avg_view_pct":77.1,"avg_view_duration_sec":329,"watch_time_hours":0.18,"subscribers_gained":0,"impressions":96}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'king-david-lessons');

-- SletzjHUCVM  Pastor Matthew shares his thoughts on scandals in churches
with upd as (
  update prs_episodes set
    guest_name   = 'Pastor Matthew (Scandals Short)',
    premiere_at  = '2024-11-01'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=SletzjHUCVM',
    video_id     = 'SletzjHUCVM',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":3,"ctr_pct":2.17,"avg_view_pct":49.27,"avg_view_duration_sec":102,"watch_time_hours":0.09,"subscribers_gained":0,"impressions":92}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'SletzjHUCVM'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'pastor-matthew-scandals-short', 'Pastor Matthew (Scandals Short)', '2024-11-01'::date, 'shipped',
       'https://www.youtube.com/watch?v=SletzjHUCVM', 'SletzjHUCVM', '{"views":3,"ctr_pct":2.17,"avg_view_pct":49.27,"avg_view_duration_sec":102,"watch_time_hours":0.09,"subscribers_gained":0,"impressions":92}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'pastor-matthew-scandals-short');

-- 75_e2qbw93k  Pastor Matthew Talks About Almost Quitting
with upd as (
  update prs_episodes set
    guest_name   = 'Pastor Matthew (Quitting Short)',
    premiere_at  = '2024-10-30'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=75_e2qbw93k',
    video_id     = '75_e2qbw93k',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":2,"ctr_pct":1.06,"avg_view_pct":93.63,"avg_view_duration_sec":373,"watch_time_hours":0.21,"subscribers_gained":0,"impressions":94}'::jsonb,
    metrics_updated_at = now()
  where video_id = '75_e2qbw93k'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'pastor-matthew-quitting-short', 'Pastor Matthew (Quitting Short)', '2024-10-30'::date, 'shipped',
       'https://www.youtube.com/watch?v=75_e2qbw93k', '75_e2qbw93k', '{"views":2,"ctr_pct":1.06,"avg_view_pct":93.63,"avg_view_duration_sec":373,"watch_time_hours":0.21,"subscribers_gained":0,"impressions":94}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'pastor-matthew-quitting-short');

-- BRjfa5yIiEM  Pastor Matthew Barnett Shares About God, Working with People Off The Streets, an
with upd as (
  update prs_episodes set
    guest_name   = 'Pastor Matthew Barnett',
    premiere_at  = '2024-10-28'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=BRjfa5yIiEM',
    video_id     = 'BRjfa5yIiEM',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":3,"ctr_pct":1.83,"avg_view_pct":0.42,"avg_view_duration_sec":13,"watch_time_hours":0.01,"subscribers_gained":0,"impressions":109}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'BRjfa5yIiEM'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'pastor-matthew-barnett', 'Pastor Matthew Barnett', '2024-10-28'::date, 'shipped',
       'https://www.youtube.com/watch?v=BRjfa5yIiEM', 'BRjfa5yIiEM', '{"views":3,"ctr_pct":1.83,"avg_view_pct":0.42,"avg_view_duration_sec":13,"watch_time_hours":0.01,"subscribers_gained":0,"impressions":109}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'pastor-matthew-barnett');

-- e9EXKEz4eNc  Immediate Things To Fight Depression from Kyle Nicolaides and Blake Mycoskie
with upd as (
  update prs_episodes set
    guest_name   = 'Kyle Nicolaides & Blake (Depression Short)',
    premiere_at  = '2024-10-17'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=e9EXKEz4eNc',
    video_id     = 'e9EXKEz4eNc',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":3,"ctr_pct":2.88,"avg_view_pct":37.63,"avg_view_duration_sec":124,"watch_time_hours":0.1,"subscribers_gained":0,"impressions":104}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'e9EXKEz4eNc'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'kyle-nicolaides-blake-depression-short', 'Kyle Nicolaides & Blake (Depression Short)', '2024-10-17'::date, 'shipped',
       'https://www.youtube.com/watch?v=e9EXKEz4eNc', 'e9EXKEz4eNc', '{"views":3,"ctr_pct":2.88,"avg_view_pct":37.63,"avg_view_duration_sec":124,"watch_time_hours":0.1,"subscribers_gained":0,"impressions":104}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'kyle-nicolaides-blake-depression-short');

-- -fKz5Lezazc  Author Kyle Nicolaides Joins Blake Myscoskie and Goes Deep on Battling Depressio
with upd as (
  update prs_episodes set
    guest_name   = 'Kyle Nicolaides & Blake Mycoskie',
    premiere_at  = '2024-10-16'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=-fKz5Lezazc',
    video_id     = '-fKz5Lezazc',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":17,"ctr_pct":2.69,"avg_view_pct":14.24,"avg_view_duration_sec":735,"watch_time_hours":3.47,"subscribers_gained":0,"impressions":223}'::jsonb,
    metrics_updated_at = now()
  where video_id = '-fKz5Lezazc'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'kyle-nicolaides-blake-mycoskie', 'Kyle Nicolaides & Blake Mycoskie', '2024-10-16'::date, 'shipped',
       'https://www.youtube.com/watch?v=-fKz5Lezazc', '-fKz5Lezazc', '{"views":17,"ctr_pct":2.69,"avg_view_pct":14.24,"avg_view_duration_sec":735,"watch_time_hours":3.47,"subscribers_gained":0,"impressions":223}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'kyle-nicolaides-blake-mycoskie');

-- WuvWuctzLAc  Kameron Westcott talks Katy Perry, Real Housewives, and more on Painful Lessons
with upd as (
  update prs_episodes set
    guest_name   = 'Kameron Westcott',
    premiere_at  = '2024-09-23'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=WuvWuctzLAc',
    video_id     = 'WuvWuctzLAc',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":2,"ctr_pct":0.84,"avg_view_pct":0.35,"avg_view_duration_sec":15,"watch_time_hours":0.01,"subscribers_gained":0,"impressions":119}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'WuvWuctzLAc'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'kameron-westcott', 'Kameron Westcott', '2024-09-23'::date, 'shipped',
       'https://www.youtube.com/watch?v=WuvWuctzLAc', 'WuvWuctzLAc', '{"views":2,"ctr_pct":0.84,"avg_view_pct":0.35,"avg_view_duration_sec":15,"watch_time_hours":0.01,"subscribers_gained":0,"impressions":119}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'kameron-westcott');

-- vs1MKf4tTOk  Painful Lessons Podcast: Brian Banks' Journey from Wrongful Conviction to Redemp
with upd as (
  update prs_episodes set
    guest_name   = 'Brian Banks',
    premiere_at  = '2024-09-04'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=vs1MKf4tTOk',
    video_id     = 'vs1MKf4tTOk',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":2,"ctr_pct":1.8,"avg_view_pct":0.45,"avg_view_duration_sec":24,"watch_time_hours":0.01,"subscribers_gained":0,"impressions":111}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'vs1MKf4tTOk'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'brian-banks', 'Brian Banks', '2024-09-04'::date, 'shipped',
       'https://www.youtube.com/watch?v=vs1MKf4tTOk', 'vs1MKf4tTOk', '{"views":2,"ctr_pct":1.8,"avg_view_pct":0.45,"avg_view_duration_sec":24,"watch_time_hours":0.01,"subscribers_gained":0,"impressions":111}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'brian-banks');

-- UKBZqgQpfRA  Tom Arnold Shares Stories of Wisdom, Donald Trump, Wild Nights, and Being Servic
with upd as (
  update prs_episodes set
    guest_name   = 'Tom Arnold',
    premiere_at  = '2024-07-27'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=UKBZqgQpfRA',
    video_id     = 'UKBZqgQpfRA',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":13,"ctr_pct":2.24,"avg_view_pct":21.24,"avg_view_duration_sec":876,"watch_time_hours":3.17,"subscribers_gained":0,"impressions":312}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'UKBZqgQpfRA'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'tom-arnold', 'Tom Arnold', '2024-07-27'::date, 'shipped',
       'https://www.youtube.com/watch?v=UKBZqgQpfRA', 'UKBZqgQpfRA', '{"views":13,"ctr_pct":2.24,"avg_view_pct":21.24,"avg_view_duration_sec":876,"watch_time_hours":3.17,"subscribers_gained":0,"impressions":312}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'tom-arnold');

-- Fl2PJj5b2G0  Tom Schwartz on Authenticity & Success | Painful Lessons Podcast with Tyler Rams
with upd as (
  update prs_episodes set
    guest_name   = 'Tom Schwartz',
    premiere_at  = '2024-06-23'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=Fl2PJj5b2G0',
    video_id     = 'Fl2PJj5b2G0',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":2,"ctr_pct":1.71,"avg_view_pct":0.74,"avg_view_duration_sec":29,"watch_time_hours":0.02,"subscribers_gained":0,"impressions":117}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'Fl2PJj5b2G0'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'tom-schwartz', 'Tom Schwartz', '2024-06-23'::date, 'shipped',
       'https://www.youtube.com/watch?v=Fl2PJj5b2G0', 'Fl2PJj5b2G0', '{"views":2,"ctr_pct":1.71,"avg_view_pct":0.74,"avg_view_duration_sec":29,"watch_time_hours":0.02,"subscribers_gained":0,"impressions":117}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'tom-schwartz');

-- lVRYOmUaL6g  EXCLUSIVE: Armie Hammer FINALLY BREAKS SILENCE!
with upd as (
  update prs_episodes set
    guest_name   = 'Armie Hammer (Breaks Silence)',
    premiere_at  = '2024-06-16'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=lVRYOmUaL6g',
    video_id     = 'lVRYOmUaL6g',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":1130,"ctr_pct":4.58,"avg_view_pct":15.8,"avg_view_duration_sec":587,"watch_time_hours":183.85,"subscribers_gained":4,"impressions":14133}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'lVRYOmUaL6g'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'armie-hammer-breaks-silence', 'Armie Hammer (Breaks Silence)', '2024-06-16'::date, 'shipped',
       'https://www.youtube.com/watch?v=lVRYOmUaL6g', 'lVRYOmUaL6g', '{"views":1130,"ctr_pct":4.58,"avg_view_pct":15.8,"avg_view_duration_sec":587,"watch_time_hours":183.85,"subscribers_gained":4,"impressions":14133}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'armie-hammer-breaks-silence');

-- m-HW_--pmbY  Nick Weidenfeld on Creativity & Content Innovation | Painful Lessons Podcast
with upd as (
  update prs_episodes set
    guest_name   = 'Nick Weidenfeld',
    premiere_at  = '2024-06-07'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=m-HW_--pmbY',
    video_id     = 'm-HW_--pmbY',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":11,"ctr_pct":3.85,"avg_view_pct":19.84,"avg_view_duration_sec":822,"watch_time_hours":2.51,"subscribers_gained":0,"impressions":104}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'm-HW_--pmbY'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'nick-weidenfeld', 'Nick Weidenfeld', '2024-06-07'::date, 'shipped',
       'https://www.youtube.com/watch?v=m-HW_--pmbY', 'm-HW_--pmbY', '{"views":11,"ctr_pct":3.85,"avg_view_pct":19.84,"avg_view_duration_sec":822,"watch_time_hours":2.51,"subscribers_gained":0,"impressions":104}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'nick-weidenfeld');

-- 3ZNzPF4RZgU  Blake Mycoskie on Mental Health & Ayahuasca: A Painful Lessons Podcast Exclusive
with upd as (
  update prs_episodes set
    guest_name   = 'Blake Mycoskie (May 2024)',
    premiere_at  = '2024-05-24'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=3ZNzPF4RZgU',
    video_id     = '3ZNzPF4RZgU',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":8,"ctr_pct":1.71,"avg_view_pct":1.28,"avg_view_duration_sec":50,"watch_time_hours":0.11,"subscribers_gained":0,"impressions":117}'::jsonb,
    metrics_updated_at = now()
  where video_id = '3ZNzPF4RZgU'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'blake-mycoskie-may-2024', 'Blake Mycoskie (May 2024)', '2024-05-24'::date, 'shipped',
       'https://www.youtube.com/watch?v=3ZNzPF4RZgU', '3ZNzPF4RZgU', '{"views":8,"ctr_pct":1.71,"avg_view_pct":1.28,"avg_view_duration_sec":50,"watch_time_hours":0.11,"subscribers_gained":0,"impressions":117}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'blake-mycoskie-may-2024');

-- VEDy7oacL-Q  Max Joseph Reveals Secrets to 'Happiness' in New Documentary | Painful Lessons P
with upd as (
  update prs_episodes set
    guest_name   = 'Max Joseph',
    premiere_at  = '2024-05-17'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=VEDy7oacL-Q',
    video_id     = 'VEDy7oacL-Q',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":12,"ctr_pct":2.82,"avg_view_pct":12.54,"avg_view_duration_sec":467,"watch_time_hours":1.56,"subscribers_gained":0,"impressions":284}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'VEDy7oacL-Q'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'max-joseph', 'Max Joseph', '2024-05-17'::date, 'shipped',
       'https://www.youtube.com/watch?v=VEDy7oacL-Q', 'VEDy7oacL-Q', '{"views":12,"ctr_pct":2.82,"avg_view_pct":12.54,"avg_view_duration_sec":467,"watch_time_hours":1.56,"subscribers_gained":0,"impressions":284}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'max-joseph');

-- s5vCBFn9rC0  From Struggle to Strength: Kathryn Brolin Shares Her Toughest Lessons | Painful 
with upd as (
  update prs_episodes set
    guest_name   = 'Kathryn Brolin',
    premiere_at  = '2024-05-07'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=s5vCBFn9rC0',
    video_id     = 's5vCBFn9rC0',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":11,"ctr_pct":7.48,"avg_view_pct":2.24,"avg_view_duration_sec":89,"watch_time_hours":0.27,"subscribers_gained":0,"impressions":107}'::jsonb,
    metrics_updated_at = now()
  where video_id = 's5vCBFn9rC0'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'kathryn-brolin', 'Kathryn Brolin', '2024-05-07'::date, 'shipped',
       'https://www.youtube.com/watch?v=s5vCBFn9rC0', 's5vCBFn9rC0', '{"views":11,"ctr_pct":7.48,"avg_view_pct":2.24,"avg_view_duration_sec":89,"watch_time_hours":0.27,"subscribers_gained":0,"impressions":107}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'kathryn-brolin');

-- SeY7r7AeJwI  Dree Hemingway Unveils Her Journey of Resilience and Self-Discovery | Painful Le
with upd as (
  update prs_episodes set
    guest_name   = 'Dree Hemingway',
    premiere_at  = '2024-04-23'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=SeY7r7AeJwI',
    video_id     = 'SeY7r7AeJwI',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":89,"ctr_pct":7.82,"avg_view_pct":3.75,"avg_view_duration_sec":158,"watch_time_hours":3.92,"subscribers_gained":1,"impressions":895}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'SeY7r7AeJwI'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'dree-hemingway', 'Dree Hemingway', '2024-04-23'::date, 'shipped',
       'https://www.youtube.com/watch?v=SeY7r7AeJwI', 'SeY7r7AeJwI', '{"views":89,"ctr_pct":7.82,"avg_view_pct":3.75,"avg_view_duration_sec":158,"watch_time_hours":3.92,"subscribers_gained":1,"impressions":895}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'dree-hemingway');

-- E-pVgI0sc0s  Painful Lessons Podcast with Blake Mycoskie
with upd as (
  update prs_episodes set
    guest_name   = 'Blake Mycoskie (Apr 2024)',
    premiere_at  = '2024-04-22'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=E-pVgI0sc0s',
    video_id     = 'E-pVgI0sc0s',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":9,"ctr_pct":1.99,"avg_view_pct":14.2,"avg_view_duration_sec":319,"watch_time_hours":0.8,"subscribers_gained":1,"impressions":151}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'E-pVgI0sc0s'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'blake-mycoskie-apr-2024', 'Blake Mycoskie (Apr 2024)', '2024-04-22'::date, 'shipped',
       'https://www.youtube.com/watch?v=E-pVgI0sc0s', 'E-pVgI0sc0s', '{"views":9,"ctr_pct":1.99,"avg_view_pct":14.2,"avg_view_duration_sec":319,"watch_time_hours":0.8,"subscribers_gained":1,"impressions":151}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'blake-mycoskie-apr-2024');

-- uVprq2dgMec  Follow what you care about #painfullessons #shorts
with upd as (
  update prs_episodes set
    guest_name   = 'Follow What You Care About (Short)',
    premiere_at  = '2024-04-21'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=uVprq2dgMec',
    video_id     = 'uVprq2dgMec',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":1,"ctr_pct":1.85,"avg_view_pct":59.39,"avg_view_duration_sec":43,"watch_time_hours":0.01,"subscribers_gained":0,"impressions":54}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'uVprq2dgMec'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'follow-what-you-care-about-short', 'Follow What You Care About (Short)', '2024-04-21'::date, 'shipped',
       'https://www.youtube.com/watch?v=uVprq2dgMec', 'uVprq2dgMec', '{"views":1,"ctr_pct":1.85,"avg_view_pct":59.39,"avg_view_duration_sec":43,"watch_time_hours":0.01,"subscribers_gained":0,"impressions":54}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'follow-what-you-care-about-short');

-- WiLz5PuK-cI  Julie Chang's Inspiring Journey: Surviving Brain Cancer & Sharing Life Lessons
with upd as (
  update prs_episodes set
    guest_name   = 'Julie Chang (Mar 2024)',
    premiere_at  = '2024-03-20'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=WiLz5PuK-cI',
    video_id     = 'WiLz5PuK-cI',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":5,"ctr_pct":2.17,"avg_view_pct":0.59,"avg_view_duration_sec":11,"watch_time_hours":0.02,"subscribers_gained":0,"impressions":92}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'WiLz5PuK-cI'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'julie-chang-mar-2024', 'Julie Chang (Mar 2024)', '2024-03-20'::date, 'shipped',
       'https://www.youtube.com/watch?v=WiLz5PuK-cI', 'WiLz5PuK-cI', '{"views":5,"ctr_pct":2.17,"avg_view_pct":0.59,"avg_view_duration_sec":11,"watch_time_hours":0.02,"subscribers_gained":0,"impressions":92}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'julie-chang-mar-2024');

-- 7ChGMTKUDy8  Welcome to The Painful Lessons Podcast: Learn from Our Mistakes!
with upd as (
  update prs_episodes set
    guest_name   = 'Welcome to the Podcast',
    premiere_at  = '2024-03-19'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=7ChGMTKUDy8',
    video_id     = '7ChGMTKUDy8',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":14,"ctr_pct":3.03,"avg_view_pct":0.53,"avg_view_duration_sec":20,"watch_time_hours":0.08,"subscribers_gained":1,"impressions":99}'::jsonb,
    metrics_updated_at = now()
  where video_id = '7ChGMTKUDy8'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'welcome-to-the-podcast', 'Welcome to the Podcast', '2024-03-19'::date, 'shipped',
       'https://www.youtube.com/watch?v=7ChGMTKUDy8', '7ChGMTKUDy8', '{"views":14,"ctr_pct":3.03,"avg_view_pct":0.53,"avg_view_duration_sec":20,"watch_time_hours":0.08,"subscribers_gained":1,"impressions":99}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'welcome-to-the-podcast');

-- GvB0AKk1-Ms  Painful Lessons Podcast   - Ep 3 -   Dr. Laura Danly
with upd as (
  update prs_episodes set
    guest_name   = 'Dr. Laura Danly',
    premiere_at  = '2024-03-05'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=GvB0AKk1-Ms',
    video_id     = 'GvB0AKk1-Ms',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":10,"ctr_pct":1.12,"avg_view_pct":3.89,"avg_view_duration_sec":148,"watch_time_hours":0.41,"subscribers_gained":0,"impressions":89}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'GvB0AKk1-Ms'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'dr-laura-danly', 'Dr. Laura Danly', '2024-03-05'::date, 'shipped',
       'https://www.youtube.com/watch?v=GvB0AKk1-Ms', 'GvB0AKk1-Ms', '{"views":10,"ctr_pct":1.12,"avg_view_pct":3.89,"avg_view_duration_sec":148,"watch_time_hours":0.41,"subscribers_gained":0,"impressions":89}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'dr-laura-danly');

-- ENu6v70JOBc  Turning Pain into Power: Former Navy SEAL Pat Dossett’s Journey to Entrepreneurs
with upd as (
  update prs_episodes set
    guest_name   = 'Pat Dossett',
    premiere_at  = '2024-03-03'::date,
    status       = 'shipped',
    video_url    = 'https://www.youtube.com/watch?v=ENu6v70JOBc',
    video_id     = 'ENu6v70JOBc',
    metrics      = coalesce(prs_episodes.metrics, '{}'::jsonb) || '{"views":36,"ctr_pct":1.9,"avg_view_pct":6.77,"avg_view_duration_sec":288,"watch_time_hours":2.88,"subscribers_gained":0,"impressions":789}'::jsonb,
    metrics_updated_at = now()
  where video_id = 'ENu6v70JOBc'
  returning id
)
insert into prs_episodes (slug, guest_name, premiere_at, status, video_url, video_id, metrics, metrics_updated_at)
select 'pat-dossett', 'Pat Dossett', '2024-03-03'::date, 'shipped',
       'https://www.youtube.com/watch?v=ENu6v70JOBc', 'ENu6v70JOBc', '{"views":36,"ctr_pct":1.9,"avg_view_pct":6.77,"avg_view_duration_sec":288,"watch_time_hours":2.88,"subscribers_gained":0,"impressions":789}'::jsonb, now()
where not exists (select 1 from upd)
  and not exists (select 1 from prs_episodes where slug = 'pat-dossett');

commit;
