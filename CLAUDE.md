# DungeonJournalTactics — read this first

Part of the **WoW Website Project**: read the hub's `CLAUDE.md` and `MAP.md` first (`C:\Users\Leon_\Documents\WoW Website Project`, two folders up). Its rules apply here: db.lokiy.dev is the only item / source data, no server-only code, document + commit + push every change, IDs are the keys between projects.

**What:** WoW 1.12 addon with tactics for DungeonJournal's bosses (DungeonJournal itself is mechanics only).
Public repo, branch `raid-tactics-content`.

**Where it runs:** linked (junction) into the live client's `Interface\AddOns\DungeonJournalTactics`: editing here
edits what WoW loads. Plain Lua 5.0, no build step; `/reload` in game to see a change.

**Docs:** none yet besides the commit log. Add a `HISTORY.md` (dated sections + "Still open") with the next change.
