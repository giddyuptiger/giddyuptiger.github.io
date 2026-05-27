-- PRS Command Center — strategy action-item seed.
-- Drawn from the 2026-05-27 Johnny strategy session (ex Mr. Beast / Hormozi / Chamath).
-- Idempotent: re-running upserts on seed_key, so operator-toggled `done` and
-- operator-edited `notes` survive a re-seed of title/instructions.

begin;

insert into prs_strategy_items (seed_key, category, title, instructions_md, sort_order)
values
  -- ROUTINE — weekly outlier-research cadence
  ('routine-research-session', 'Routine',
   'Run a 60–90 min weekly outlier research session',
   $$Block a recurring 60–90 minute slot every week to hunt outliers. This is the only routine that compounds — skip it and the rest of the playbook starves.$$, 10),

  ('routine-pick-3-outliers', 'Routine',
   'Pick 3 outliers from adjacent niches',
   $$Pull from any of: **recovery, sobriety, mental health, men's health, neuroscience, self-development, masculinity, fitness, spirituality**.

Adjacent ≠ identical. The pattern transfers across niches as long as the audience overlap is plausible.$$, 20),

  ('routine-compute-multiplier', 'Routine',
   'Compute the multiplier for each candidate',
   $$**The Outlier Method:** `video views ÷ channel average`.

- `< 5×` = noise, skip it.
- `10×` = signal, worth studying.
- `100×` = must-mimic.$$, 30),

  ('routine-save-thumb-title-2sent', 'Routine',
   'Save thumbnail, title, and first two sentences for each outlier',
   $$Capture the *control points* — for long-form: thumbnail + title. For shorts: first two sentences. Everything else is downstream of these.$$, 40),

  ('routine-pattern-across-2-3', 'Routine',
   'Look for patterns across 2–3 outliers and combine them',
   $$One outlier is anecdote. Two or three with the same structural move is a pattern. Stack patterns when they reinforce — e.g., "callout + number + payoff" + "first-person POV".$$, 50),

  ('routine-translate-to-niche', 'Routine',
   'Translate to the recovery/sobriety niche (keep structure, swap the noun)',
   $$Outlier patterns are **structural, not topical**. Find the move in any niche, then swap the noun for ours.

> Example: "I tried every productivity hack for 30 days" → "I tried every relapse-prevention trick for 30 days."$$, 60),

  ('routine-validate-hook-first', 'Routine',
   'Validate by writing the matching hook before producing anything',
   $$**The Portal Rule:** thumbnail + title is the portal. The first sentence of the video must speak the portal's words *almost verbatim*.

Plan the portal first, then write the hook. If you can't draft a hook that matches, the pattern doesn't translate yet — drop it.$$, 70),

  -- CONTENT FORMAT — the weekly content system
  ('content-podcast-weekly', 'Content Format',
   '1 podcast episode per week (long-form guest interview)',
   $$The flagship: one long-form podcast per week. Engineered from the winning outlier of the cycle.$$, 80),

  ('content-talking-head-weekly', 'Content Format',
   '1 talking-head video per week (Tyler solo, scripted from outlier pattern)',
   $$Solo Tyler video, scripted from the week's strongest outlier pattern. Johnny's prediction: these outperform podcast clips on cold audiences.$$, 90),

  ('content-shorts-daily', 'Content Format',
   '1 short / reel / TikTok per day, hook-driven, batch-filmed',
   $$**7 shorts/week target.** Hook-driven (first two sentences = the entire control point). Batch-film them all in one sit-down at the start of the week.$$, 100),

  ('content-podcast-mentions-2x', 'Content Format',
   'Every talking-head video and short mentions the podcast 2× organically',
   $$**The 30-Second Mention.** Two mentions per talking-head and per short:

1. Around 30 seconds in.
2. Near the end.

Organic, in-flow — not an outro card.$$, 110),

  -- PODCAST-SPECIFIC
  ('podcast-research-thumb-title-first', 'Podcast',
   'Research thumbnail + title BEFORE shooting',
   $$Diary of a CEO ad-tests **50 thumbnail variations on Facebook** before committing. We don't have to go that far, but the principle stands: pick the portal first, then build the episode to fit it.$$, 120),

  ('podcast-cold-open-question', 'Podcast',
   'Engineer the cold-open question to match the winning thumbnail',
   $$Reverse-engineer the very first question you ask the guest so that their answer naturally contains the thumbnail words.$$, 130),

  ('podcast-lead-with-guest-answer', 'Podcast',
   'Lead the episode with the guest answering that question',
   $$**First 15–30 seconds of the cut must contain the thumbnail words.** The portal needs to deliver on its promise inside the retention danger zone.$$, 140),

  ('podcast-batch-shorts', 'Podcast',
   'Batch shorts: write a week''s worth from outlier research, then film in one sit-down',
   $$Don't write shorts ad-hoc. Pull the week's batch from your outlier research session, write all 7 hooks together, film in one sitting.$$, 150),

  -- VALIDATION — pre-production gate
  ('validation-multiplier', 'Validation',
   'Outlier has at least 5× multiplier (10× preferred)',
   $$Sub-5× is noise. If you can't find a 5× source pattern, you're producing on vibes, not data.$$, 160),

  ('validation-structural-not-topical', 'Validation',
   'Pattern is structural, not topical (you can swap the noun)',
   $$Sanity check: can you describe the move without naming the topic? If not, it's a topical curiosity, not a transferable pattern.$$, 170),

  ('validation-hook-matches-thumb', 'Validation',
   'Hook contains the thumbnail words almost verbatim',
   $$Read your hook out loud. If the thumbnail's literal words aren't in the first sentence (or close enough that a viewer would feel them land), rewrite.$$, 180),

  ('validation-fits-niche', 'Validation',
   'Hook fits naturally in the recovery/sobriety niche',
   $$Translation has to feel native, not forced. If you have to twist the hook to make it fit, the source pattern wasn't actually adjacent.$$, 190),

  ('validation-plan-mentions', 'Validation',
   'Plan where the two podcast mentions land',
   $$Decide before shooting: which beat at ~30 sec carries the first podcast mention, which beat near the end carries the second. Pre-planning beats improvising.$$, 200),

  -- 30-DAY TEST — the cycle to verify Johnny's prediction
  ('30day-pick-3-outliers', '30-Day Test',
   'Pick 3 outliers from the recovery/sobriety niche this week',
   $$The test starts with three. One outlier per format. Record them in the seed of this 30-day cycle so we can compare results at day 30.$$, 210),

  ('30day-podcast-from-outlier-1', '30-Day Test',
   'Use 1 outlier for the podcast episode',
   $$Use it to engineer the cold-open question (per the Podcast section above). Note which outlier you used in the cycle notes.$$, 220),

  ('30day-talking-head-from-outlier-2', '30-Day Test',
   'Use 1 outlier for the talking-head video',
   $$Tyler solo, scripted directly from the pattern. This is the format Johnny expects to win.$$, 230),

  ('30day-shorts-from-outlier-3', '30-Day Test',
   'Use 1 outlier as the seed for a batch of shorts',
   $$Spawn the week's 7 shorts from this single pattern. Variations on the same hook, not 7 disconnected ideas.$$, 240),

  ('30day-track-multipliers', '30-Day Test',
   'Track the multiplier achieved on each',
   $$Day 30: pull views on each of the three pieces, divide by our channel average, log the multiplier in the 30-day status field above.$$, 250),

  ('30day-verify-prediction', '30-Day Test',
   'Verify Johnny''s prediction: talking-head videos outperform podcast clips',
   $$The whole point of the test. If talking-head wins, double down on Tyler solo. If clips win, revisit Johnny's framing for our niche.$$, 260),

  -- TOOLING
  ('tooling-1of10-account', 'Tooling',
   'Set up account on 1of10.com (Johnny''s tool)',
   $$Also referenced as **oneoften.com**. Built for outlier research — surfaces videos performing N× their channel's average.

Sign up, link YouTube, start saving candidates to a board.$$, 270),

  ('tooling-capture-template', 'Tooling',
   'Set up the outlier capture template',
   $$One row per outlier candidate. Fields:

- Source channel + channel average views
- Source video views → multiplier
- Original thumbnail
- Original title
- Original first two sentences (for shorts) or hook
- Recovery-niche adaptation (translated hook + thumb concept)

Notion, a sheet, or Airtable — pick one and stick with it.$$, 280)

on conflict (seed_key) do update set
  category = excluded.category,
  title = excluded.title,
  instructions_md = excluded.instructions_md,
  sort_order = excluded.sort_order,
  updated_at = now();

commit;
