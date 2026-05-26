-- Past episodes seed — YouTube Studio metrics (Jan-Apr 2026)
-- Run AFTER schema.sql and seed_rob_morrow.sql.
-- These rows give the Past Episodes comparison strip real numbers from day one.
-- Status = 'shipped' marks them as completed historical episodes (vs. Rob Morrow which is 'in-progress').
-- Slugs are derived from the guest name — rename via the page or SQL later if your team has its own slug convention.

insert into prs_episodes (slug, guest_name, premiere_at, status, metrics, metrics_updated_at) values
  ('sam-miller', 'Sam Miller', '2026-04-27', 'shipped',
   '{"views":18683,"ctr_pct":3.62,"avg_view_pct":7.39,"avg_view_duration_sec":306,"watch_time_hours":1052.4,"subscribers_gained":2,"impressions":4088}'::jsonb,
   now()),
  ('david-chokachi', 'David Chokachi', '2026-04-13', 'shipped',
   '{"views":69553,"ctr_pct":3.09,"avg_view_pct":3.43,"avg_view_duration_sec":178,"watch_time_hours":2758.5,"subscribers_gained":6,"impressions":6249}'::jsonb,
   now()),
  ('julie-chang', 'Julie Chang', '2026-03-09', 'shipped',
   '{"views":118,"ctr_pct":2.82,"avg_view_pct":8.32,"avg_view_duration_sec":366,"watch_time_hours":12.0,"subscribers_gained":0,"impressions":2057}'::jsonb,
   now()),
  ('john-henson', 'John Henson', '2026-02-23', 'shipped',
   '{"views":20203,"ctr_pct":2.07,"avg_view_pct":4.48,"avg_view_duration_sec":184,"watch_time_hours":364.7,"subscribers_gained":3,"impressions":3956}'::jsonb,
   now()),
  ('mary-alice-haney', 'Mary Alice Haney', '2026-02-16', 'shipped',
   '{"views":118,"ctr_pct":1.47,"avg_view_pct":12.35,"avg_view_duration_sec":466,"watch_time_hours":15.3,"subscribers_gained":0,"impressions":3461}'::jsonb,
   now()),
  ('armie-hammer-fame', 'Armie Hammer (Feb 2026)', '2026-02-02', 'shipped',
   '{"views":20980,"ctr_pct":9.1,"avg_view_pct":4.2,"avg_view_duration_sec":170,"watch_time_hours":992.1,"subscribers_gained":29,"impressions":31047}'::jsonb,
   now()),
  ('jay-mohr', 'Jay Mohr', '2026-01-26', 'shipped',
   '{"views":150,"ctr_pct":2.52,"avg_view_pct":27.99,"avg_view_duration_sec":1087,"watch_time_hours":45.3,"subscribers_gained":1,"impressions":2106}'::jsonb,
   now()),
  ('jack-osbourne', 'Jack Osbourne', '2026-01-05', 'shipped',
   '{"views":3646,"ctr_pct":5.06,"avg_view_pct":16.29,"avg_view_duration_sec":805,"watch_time_hours":815.6,"subscribers_gained":26,"impressions":29614}'::jsonb,
   now())
on conflict (slug) do nothing;
