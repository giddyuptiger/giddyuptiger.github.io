# Command Center (giddyuptiger.github.io)

> Pointer file — governance lives in Drive `CLAUDE/INDEX.md` (the single source of truth). Created to carry the standard governance + Definition-of-Done blocks; add any repo-specific build/test/deploy notes above this line.

## Governance front door — read INDEX first

Before nontrivial work, consult the canonical governance front door — **Drive `CLAUDE/INDEX.md`** — the single source of truth for how this system operates. This file is a pointer; if anything here ever conflicts with INDEX, INDEX wins.

## Definition of Done — every task (two co-equal, mandatory steps)

A task is not finished until BOTH of these are written. They are co-equal and mandatory — neither is optional, and neither outranks the other:

**(a) Code-history log** — write a dated entry to Drive at `CLAUDE/code-history/<project>/<YYYY-MM-DD>_<slug>.md` (what changed, why, and how it was verified). For a code task, add a `resolves:` line to the entry's YAML frontmatter so it auto-closes the matching STATUS item.

**(b) STATUS.md "Waiting on you"** — update Drive `CLAUDE/STATUS.md` in place: remove the item you just finished, add anything now newly waiting on Jeremy, and keep every remaining item *actionable* (the concrete next action / how-to, not just a title). Edit above the Scribe block.
