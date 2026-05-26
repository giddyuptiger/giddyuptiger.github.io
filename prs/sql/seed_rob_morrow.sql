-- PRS Episode Command Center — Rob Morrow seed
-- Run after schema.sql. Idempotent on the episode row; items are inserted fresh each run, so only run once unless you've cleared existing Rob Morrow items.

insert into prs_episodes (slug, guest_name, status, sheet_url)
values (
  'rob-morrow',
  'Rob Morrow',
  'in-progress',
  'https://drive.google.com/file/d/1DG5O-o-eCrA4ovw2N3faeKkhMF9QVcZA/view?usp=drivesdk'
)
on conflict (slug) do nothing;

with ep as (select id from prs_episodes where slug = 'rob-morrow')
insert into prs_checklist_items (episode_id, role_group, title, instructions_md, sort_order)
select ep.id, x.role_group, x.title, x.instructions_md, x.sort_order
from ep, (values
  -- Editorial (pre-edit) -------------------------------------------------
  ('Editorial', 'Apply 🔴 compliance trim: father-suicide method (~40:00)', E'Tyler describes his father''s death by suicide and states the method ("shot himself in the head"). YouTube''s suicide-policy classifier targets method language specifically.\n\nFix: trim to "my father took his own life" or "my father died by suicide". Keeps the entire narrative, drops only the method phrase. See RobMorrow_ProductionSheet.md Open Question 1.', 10),
  ('Editorial', 'Confirm sponsor reads intact', E'• BetterHelp at ~29:03 (formal mid-roll).\n• Morning Watcher mention at ~1:17:40 (organic; Tyler hands Rob a sample on-mic).\n• Boom Boom Stick at ~1:18:49 (organic; Tyler self-IDs it as a sponsor).\n\nConfirm all three are in the line cut. No host-read ad within 60 seconds of the weed-edible / child-hospitalization story (~43:00).', 20),
  ('Editorial', 'Editorial call: #MeToo segment (~51-56 min)', E'Tyler calls James Franco "railroaded" and is dismissive of the Al Franken story. Rob is more measured. The most backlash-prone segment in the episode — reputational risk, not a platform risk.\n\nDecide: keep / trim / soften. Flagged so it does not ship by accident. See Open Question 2.', 30),
  ('Editorial', 'Lock the edit', 'Pass the locked cut to Stage 2b/3 of the SOP (post-edit cleanup, chapter timestamps).', 40),

  -- Metadata & Upload ----------------------------------------------------
  ('Metadata & Upload', 'Set YouTube title', E'Recommended: **Northern Exposure''s Rob Morrow on Treating Anger Like an Addiction** (64 char).\n\nFour other variants in Stage 2a of the production sheet. The title can use the words "Sober", "Addiction", "Depression" — §8 banned-word rules apply to ad copy and thumbnail text only, not the title.', 50),
  ('Metadata & Upload', 'Set description + 10 hashtags + 28 tags', E'Full description with 10 "In This Episode" bullets, plus the hashtags and tags lists — all verbatim in Stage 2a of the production sheet. Include both "Numb3rs" and "Numbers" in tags for searchability.', 60),
  ('Metadata & Upload', 'Add 36 chapter markers', 'Marketing-style chapters in Stage 2a — copy-paste into the YouTube chapter field. Finer-grained than usual: includes the #MeToo / Armie Hammer / Charlie Sheen / JFK Jr. beats.', 70),
  ('Metadata & Upload', 'Upload thumbnail', E'Recommended: **Concept A "ANGER IS A POISON"** — banned-word safe (the original "ANGER IS A DRUG" trips the §8 classifier on the literal token DRUG, even metaphorical). "POISON" is also Rob''s own language ("it felt like poison").\n\nFormat: two-face, guest LEFT, Tyler RIGHT, equal size. Three concepts in Stage 4.', 80),
  ('Metadata & Upload', 'Upload video as scheduled YouTube Premiere', 'Confirm date + time. Note: a YouTube Premiere cannot be advertised on Google Ads until after it airs (Google Ads rejects an unaired premiere as an ad asset). Build the ad campaign now, launch it within ~15 min of premiere ending.', 90),

  -- Ads & Marketing ------------------------------------------------------
  ('Ads & Marketing', 'Build Custom Segment (20 keywords)', 'The 20-keyword list is in the Campaign 1 spec in Stage 5 of the production sheet.', 100),
  ('Ads & Marketing', 'Set audience + geo + budget', E'• Exclude All Channel Viewers.\n• Geo = United States only (sponsor optics, Strategy v1.2.1).\n• Budget $80/day × 5 days, end date auto-pause.', 110),
  ('Ads & Marketing', 'Build ad copy (banned-word verified)', E'• 8 long headlines, 7 short headlines, 3 descriptions — verbatim in Stage 5.\n• Every line already verified clean against the §8 banned-word list (including the "Walked Away" / "Killed/Saved" pattern triggers).\n• Do NOT use the in-conversation phrase "DRUGS KEEP YOU FROM" in any overlay or copy — superseded by "WHAT YOU''RE CHASING / IS WHY YOU CAN''T REACH IT" for Concept B.', 120),
  ('Ads & Marketing', 'Set display URL (two-box field)', E'• Path 1 = **Painful-Lessons**\n• Path 2 = **Rob-Morrow**\n\nOne channel ("Punk Rock Sober"). "Painful Lessons" is a display-label convention on ad creative only, not a separate channel.', 130),
  ('Ads & Marketing', 'Build campaign and leave PAUSED', 'Have everything ready (custom segment, audience, ad copy, display URL) but pause the campaign until the premiere finishes airing.', 140),
  ('Ads & Marketing', '⭐ Launch the Google Ads campaign right after premiere ends', 'Within ~15 min of the premiere finishing, build the ad group on the now-public video and launch. **This is the step a recent episode missed — do not let this ship unchecked.**', 150),

  -- Social & Clips -------------------------------------------------------
  ('Social & Clips', 'Produce the 6 social clips', '6 candidates in Stage 6 of the production sheet. Schedule across launch week.', 160),
  ('Social & Clips', 'Produce the 3 collab clips with @tags', E'Stage 6b:\n1. Live-your-life-backward (primary).\n2. Noah Wyle mantra — tag **@noahwyle**.\n3. The aphorism.', 170),
  ('Social & Clips', 'Send collab clips to collab partners', 'Send the Noah Wyle clip to his team / channel for boost potential.', 180),

  -- Launch Day -----------------------------------------------------------
  ('Launch Day', 'Confirm premiere goes live', 'Watch the premiere start. Confirm the watch page is live and the video is playing.', 190),
  ('Launch Day', 'Post + pin the 3 seeded comments (within ~30 min)', E'Stage 6c — three verbatim comments to copy-paste:\n1. Self-ID pin (host account, pinned).\n2. Anger-as-addiction pushback (spark debate on Rob''s core framing).\n3. Weed/sobriety stat ask (invite audience experiences).\n\nFull text in Stage 6c of the production sheet.', 200),
  ('Launch Day', 'Launch Google Ads (paired with Ads & Marketing item above)', '15-min ad-group build immediately after premiere ends. Pause the campaign if any 🔴 flag surfaces in the first minutes.', 210),
  ('Launch Day', 'Spot-check first 30 min', 'Watch the comment stream, the playback, and any policy flags or unusual notices.', 220),

  -- Post-Launch ----------------------------------------------------------
  ('Post-Launch', 'Day-1 monitor', 'Comments, retention curve, any YouTube policy flags. Respond / address as needed.', 230),
  ('Post-Launch', 'Day-3 ad spend pacing check', 'Confirm the campaign is pacing as expected. Adjust if the $80/day is over/underspending.', 240),
  ('Post-Launch', 'Mark production sheet shipped', 'Update RobMorrow_ProductionSheet.md status. Add a "Recently shipped" entry on the project command center (status.json recentlyShipped array).', 250)
) as x(role_group, title, instructions_md, sort_order);
