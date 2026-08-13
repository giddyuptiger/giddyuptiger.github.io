# Rolling back the Maestro app

`main` is what's live — GitHub Pages publishes it on every push. So a rollback is a commit, not a
file swap.

## Undo the last change

```bash
git revert <sha>          # e.g. git revert f5ba3b1
git push origin main
```

`revert` makes a *new* commit that undoes the old one, so the history of what happened stays intact
and the revert itself can be reverted. Pages redeploys automatically.

Find the sha with `git log --oneline maestro/index.html`, or on a phone: the repo's Commits list →
open the commit → **Revert** (GitHub offers this as a button; it opens a PR you can merge).

## Go back to how the file looked at some point

```bash
git checkout <sha> -- maestro/index.html
git commit -m "restore maestro/index.html to <sha>"
git push origin main
```

## Why there are no more `index.pre-*.html` files

There used to be a copy of `index.html` saved beside it before each significant change
(`index.pre-vault-tab-fixes-20260812.html` and friends) — nine of them, 3.1 MB of duplicated HTML,
growing with every change. Git already stores every version of the file, with a message explaining
each one, so the copies were a second, worse history: no diffs, no reasons, and easy to mistake for
a live file.

They were removed on 2026-08-13. **Nothing was lost** — every one of them is still in git history
and can be recovered:

```bash
git log --oneline --diff-filter=D -- 'maestro/index.pre-*.html'   # find the commit that removed them
git show <sha>^:maestro/index.pre-vault-tab-fixes-20260812.html > /tmp/old.html
```

## Before you roll back

The Pages workflow runs the Vault test suites (`maestro/test/`) before publishing, so a revert also
gets checked. If you are rolling back *because* the tests are failing, that is the system working —
prefer fixing forward if the fix is small and obvious, and reverting if it is not.
