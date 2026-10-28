# DungeonJournalTactics — read this first

Part of the **WoW Website Project**: read the hub's `CLAUDE.md` and `MAP.md` first (`C:\Users\Leon_\Documents\WoW Website Project`, two folders up). Its rules apply here: db.lokiy.dev is the only item / source data, no server-only code, document + commit + push every change, IDs are the keys between projects.

**What:** WoW 1.12 addon with tactics for DungeonJournal's bosses (DungeonJournal itself is mechanics only).
Public repo, branch `raid-tactics-content`.

**Where it runs:** linked (junction) into the live client's `Interface\AddOns\DungeonJournalTactics`: editing here
edits what WoW loads. Plain Lua 5.0, no build step; `/reload` in game to see a change.

**Docs:** `HISTORY.md` (numbered sections + "Still open"; earlier history in DungeonJournal's HISTORY.md), `MINOR.md`.

**Change log (Lokiy, 2026-10-28):** real changes (code) go in `HISTORY.md` (a numbered section); minor ones (hotfixes, data added /
removed, wording, settings, rebuilds: no code change) are one dated line in `MINOR.md`. After either, run
`python tools/changelog.py` in the hub (`C:\Users\Leon_\Documents\WoW Website Project`) and commit + push the hub: its `CHANGELOG.md` and
`CHANGELOG_MINOR.md` show every project's changes together.
