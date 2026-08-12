------------------------------------------------------------
-- DungeonJournalTactics
--
-- Standalone strategy/tactics companion for DungeonJournal. Purely additive:
-- if DungeonJournal isn't installed, this addon registers nothing and does
-- NOTHING (no frames, no UI, no error). If it is installed, each entry below
-- is handed to DungeonJournal via DungeonJournal_RegisterTactics(bossKey, data)
-- so it can show a "Tactics" button on the matching boss.
--
-- data = { title = "...", lines = { "paragraph one", "paragraph two", ... } }
------------------------------------------------------------

local TACTICS = {
    razorgore = {
        title = "Razorgore the Untamed",
        lines = {
            "Placeholder tactics text - not yet written.",
        },
    },
}

local tacticsFrame = CreateFrame("Frame")
tacticsFrame:RegisterEvent("PLAYER_LOGIN")
tacticsFrame:SetScript("OnEvent", function()
    -- CHANGED: only act if DungeonJournal is actually loaded and has exposed
    -- its registration hook; otherwise this addon is inert by design.
    if type(DungeonJournal_RegisterTactics) ~= "function" then
        return
    end

    for bossKey, data in pairs(TACTICS) do
        DungeonJournal_RegisterTactics(bossKey, data)
    end
end)
