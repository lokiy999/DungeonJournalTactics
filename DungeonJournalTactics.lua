------------------------------------------------------------
-- DungeonJournalTactics
--
-- Standalone strategy/tactics companion for DungeonJournal. Purely additive:
-- if DungeonJournal isn't installed, this addon registers nothing and does
-- NOTHING (no frames, no UI, no error). If it is installed, each entry below
-- is handed to DungeonJournal via DungeonJournal_RegisterTactics(bossKey, data)
-- so it can show a "Tactics" button on the matching boss.
--
-- data = { title = "...", lines = { ... }, resistances = { ... } (optional) }
-- Each entry in `lines` is either:
--   "a paragraph of body text"
--   { separator = true, name = "Section label", color = "ffRRGGBB" (optional) }
-- matching the same separator shape DungeonJournal's own ability lists use
-- (see AGENTS.md's Data model) - a section header renders as a colored bar,
-- with the following plain-string entries as its body until the next one.
--
-- `resistances` (optional) drives the "FR: 315 recommended" part of the
-- Broadcast button's header line - keyed the same as a boss/pack's `stats`
-- table (fire/frost/nature/shadow/arcane), value is the recommended amount
-- OR { amount = 315, note = "buffed" } to append a short parenthesized
-- note. Holds as many schools as needed, e.g. resistances = { fire = 315,
-- nature = 200 } for a fight that wants both. Omit entirely if no
-- particular resistance is worth calling out.
--
-- bsep(name) marks a broadcast section: a separator with broadcast = true.
-- Everything under it (until the next separator, broadcast or not) is
-- exactly what the Broadcast button sends to raid/party chat instead of
-- its default auto-summary (every warning ability + every tactics line) -
-- and it renders green in the Tactics panel so you can see precisely what
-- will go out before clicking Broadcast. Use this to keep `lines` as the
-- full writeup you explain over voice, while hand-picking only the
-- wipe-mechanic essentials worth putting in chat. If an entry has no
-- bsep() section, Broadcast falls back to the auto-summary.
--
-- rw(text) marks ONE line inside a bsep() section as a raid warning: it's
-- sent via /rw (RAID_WARNING) instead of /raid, and renders bold/red in the
-- Tactics panel preview so it's visually distinct before you click
-- Broadcast. There's no fixed format for the text - write whatever's
-- clearest for that fight - but `{boss}` in the text is substituted with
-- the boss's display name at send/preview time, so a line can be written
-- generically. Example (Baron Geddon):
--   rw("{boss}: [SKULL] Living Bomb -> RUN OUT | [CROSS] Spreading Flames -> STACK ON SQUARE"),
-- Only one rw() line is expected per fight (it's meant for THE wipe
-- mechanic callout) - every other line in the bsep() section is still sent
-- as a normal /raid message.
--
-- Source: "Tips_Tricks about 40-man content for RL.docx" (Peach's Guide to
-- World Bosses / Addendum 1: Peach's Guide to Molten Core), transcribed
-- close to verbatim - only obvious typos and stray markup fixed (curly
-- quotes normalized, a stray "]" dropped, "GFrPP"/"GAPP" normalized to the
-- "GFPP" spelling used everywhere else in the doc). This is raid-lead
-- strategy content, not mechanics - see DungeonJournal's CLAUDE.md scope
-- rule for why it lives here instead of in the main journal.
------------------------------------------------------------

local function sep(name)
    return { separator = true, name = name }
end

local function bsep(name)
    return { separator = true, name = name, broadcast = true }
end

local function rw(text)
    return { warning = true, text = text }
end

local TACTICS = {

    ------------------------------------------------------------
    -- World Bosses
    ------------------------------------------------------------

    kurinnaxx = {
        title = "Kurinnaxx",
        lines = {
            sep("Pre-pull"),
            "Scout him out.",
            "Poison Cleanse totem in tank group.",
            sep("Mechanics"),
            "Do not stand behind Kuri - Tail Swipe.",
            "Do not stand in front of Kuri unless you are tanking - ranged Poison Bolt Volley.",
            "All dps and healers should be positioned at Kuri's left or right side.",
            "Move away from Sand Trap or you will be silenced for 20s.",
            "Cleanse poison/totem - Poison Bolt Volley.",
            "Stop dps on Charge.",
            "Tanks taunt off each other at three to five stacks of Mortal Wound.",
            "Mortal Wound reduces healing taken by 10% per stack.",
            "Save CDs for Enrage at 30%.",
            "Boss needs to be disarmed as much as possible during Enrage.",
        },
    },

    azuregos = {
        title = "Azuregos",
        lines = {
            sep("Pre-pull"),
            "Assign 2 dispellers.",
            "Assign 1-2 resto druids for Deep Freeze.",
            "Use GFrPP.",
            "Track Deep Freeze.",
            sep("Mechanics"),
            "Do not stand in front unless you are tanking him - Frost Breath.",
            "Stand behind; does not tail swipe like most dragons.",
            "Move away from Mana Storm - it will mana drain.",
            "Heal Deep Freeze targets - freezes target in place and big DoT.",
            "Stop dps on Teleport.",
            "Casters stop spell damage on Magic Reflection.",
            "Dispel Chill, tanks before melee. Skip the rest.",
            "Immune to arcane, high frost resist.",
            "Mark of Frost - 15 minute undispellable debuff that freezes the player in place after death when Azuregos is nearby.",
        },
    },

    kazzak = {
        title = "Lord Kazzak",
        lines = {
            sep("Pre-pull"),
            "Mark melee for Meteor.",
            sep("Mechanics"),
            "Do not fall below 2k mana.",
            "Decurse Mark of Kazzak - drains mana over time; if the target goes oom with the debuff, they will explode.",
            "Do not die - every player that dies will heal him 70k+ hp.",
            "Pets dying will also heal Kazzak. This includes Eskhandar's.",
            "Any player or pet outside the raid will also provide healing if they're close to or in combat with him.",
            "Shadow Bolt Volley - AoE shadow bolts that hit everyone, ignoring line of sight.",
            "Melee dps must stay at max range from behind - Meteor (AoE knockback that could hit the tank) plus frontal Cleave.",
            "Dispel Twisted Reflection - heals Kazzak when damage is dealt to the target.",
        },
    },

    hederine = {
        title = "Lady Hederine",
        lines = {
            sep("Pre-pull"),
            "Share the map.",
            "Assign MT and 2 tanks for each add (5 tanks total).",
            "Assign MoT healers (1 druid + 1 paladin/priest).",
            "Mark ranged for stacking.",
            "Nature Resist + Fire Resist totem in MT's group.",
            "Sonic Lash is nature damage, Lash of Pain is fire damage.",
            "Shaman and/or hunter in each group.",
            sep("Adds"),
            "OTs must pull.",
            "Tanks must taunt off each other at 3 stacks of Sunder Armor.",
            "Tanks must immediately taunt when adds start charging the MT on Hederine.",
            sep("Mechanics"),
            "Bloating Toxins target must be outside of line of sight of the whole raid - after the debuff expires, the target will AoE poison bolt volley anyone in their line of sight, including themself.",
            "Refer to the map for ideal LoS'ing positions.",
            "Every cast debuffs 2 units - targets the furthest raid member and a target within the top 3 threat (assumption; might be highest/2nd highest).",
            "Can assign a ranged soaker - resto shaman/resto druid/holy paladin with nature resist works well, and can be assigned as dispeller/decurser plus soaker.",
            "Cleanse the poison Flesh Explosion that occurs after Bloating Toxins.",
            "Move away from Tears of the Hederine (green gas) - you will get frozen if you stand in it too long, take a big DoT, and cannot be healed.",
            "Decurse Curse of Weakness, tanks before hunters and melee dps. Skip the rest.",
            "Dispel Impotence, shaman/paladin tank before dps shaman/warlock before mages/boomkins. Dps priests/paladins should dispel themselves.",
            "Impotence reduces magic damage by 90%.",
            "CC the mind-controlled target, do NOT kill them.",
            "Run back if you die when the boss is over 30%.",
            sep("Note"),
            "If many are dead and it's a slow kill, you may still want to run back, but if it's a smooth fight just stay nearby at 30% to avoid loot issues.",
        },
    },

    onyxia = {
        title = "Onyxia",
        lines = {
            sep("Forming"),
            "Stack and buff outside - spells are more expensive in the instance.",
            sep("Trash"),
            "Melee move out if you're low, wait for heals/bandage - Fire Nova/Cleave.",
            sep("Pre-pull"),
            "Use GFPP.",
            "Stack on 1 side.",
            "Mark a star for moving on pull.",
            "Tremor totem + Fire Resist totem + Devotion Aura in MT group.",
            "Track Threatening Gaze.",
            "Track Engulfing Flames.",
            sep("On pull"),
            "Move together, do not pass the star.",
            "Do not stand behind her - Tail Swipe.",
            "Do not stand in front of her unless you are tanking - Flame Breath.",
            sep("Whelps"),
            "Assign a whelp tank.",
            "Kill all whelps that spawn - make sure healers aren't getting whelp aggro.",
            sep("Phase 1"),
            "Slow dps until positioned, set up debuffs while moving into position, e.g. Expose Armor/curses/DoTs.",
            "Threatening Gaze target must stop all actions or they will aggro her.",
            "Save damage cooldowns for as soon as she hits 66% when she begins to move - BLOW EVERYTHING.",
            sep("Phase 2"),
            "Use CDs before she flies away at the beginning of phase 2 (~70%).",
            "Avoid Deep Breath - call out safe spots when she moves to a new position.",
            "Do not stand in the middle.",
            "Spread out to avoid Fireball - AoE conflagration (Onyxia telegraphs who she is casting on; they get a mark ~3s before it hits, so avoidance/dodge also works).",
            sep("Phase 3"),
            "Slow dps on landing, let the MT reposition to the phase 1 tanking position, be careful with DoT aggro during the phase change.",
            "Threatening Gaze target must stop all actions or they will aggro her.",
            "TREMOR TOTEM up - Bellowing Roar is an AoE fear.",
            "Druid tank can spec for enrage to avoid every fear, warrior can stance-dance most of it, paladin can spec for morale.",
        },
    },

    ------------------------------------------------------------
    -- Molten Core
    ------------------------------------------------------------

    lucifron = {
        title = "Lucifron",
        lines = {
            sep("Pre-pull"),
            "Assign tanks (5), dispellers (all healers that can dispel and are not MT healers), decursers (ALL mages, resto druids, and boomkins), and boss ToT healers (2).",
            sep("Adds"),
            "Assign 2 tanks to each.",
            "Priority-kill one by one.",
            "NO AoE - Mind Control.",
            "Spread them out - Whirlwind.",
            sep("Mechanics"),
            "Dispel Impending Doom - 2k shadow damage when the debuff expires.",
            "Decurse Lucifron's Curse, tanks before healers before the rest - abilities become more expensive.",
            "Taunt rotation - stacking debuff on the MT, swap at 3 stacks.",
        },
    },

    -- Patrols and boss-room trash on the way to/around Lucifron, split into
    -- their own entries (registered under their MC.lua trash keys) so each
    -- pack gets its own Tactics button in the Trash view instead of being
    -- bundled into Lucifron's.
    lava_surger = {
        title = "Lava Surger",
        lines = {
            "Stack and banish - charges.",
            "Heal through Flamestrike.",
            "Magic debuff (Magma Shackles) that slows.",
        },
    },

    ancient_core_hound = {
        title = "Ancient Core Hound",
        lines = {
            "Pre-shield tanks - Vicious Bite (hateful strike).",
            "Cannot be avoided or dodged; needs armor + stamina for OTs.",
            "Do not dispel/decurse in combat - applies a random debuff.",
            "BoS + Soulstone/Life up on tanks for Disorient.",
            "2 MTs in front, rest to the side facing away from the raid - Flamebreath.",
            "Bleed debuff on tanks - Serrated Bite.",
        },
    },

    molten_giant = {
        title = "Molten Giant",
        lines = {
            "Up to 3 tanks on each - Knockaway.",
            "Spread them out - Cleave.",
        },
    },

    lava_annihilator = {
        title = "Lava Annihilator",
        lines = {
            "Burst down - explodes.",
            "Banish and spread if more than 1 mob.",
            "Stacking debuff on tank that increases physical damage taken.",
            "Stop dps on threat drop.",
        },
    },

    firelord = {
        title = "Fire Lord",
        lines = {
            "Priority-kill the spawn (cannot be AoE'd).",
            "Pull away from the tank on Conflagration.",
            "Keep HoTs up on the Soul Burn target - big DoT plus silence.",
        },
    },

    molten_destroyer = {
        title = "Molten Destroyer",
        lines = {
            "Pre-shield tanks, tanks must move together on pull - Hateful Strike.",
            "Kill the destroyer first (best tanks).",
            "Spread them out - AoE knockdown.",
            "Big heals - Pyroblast on tanks.",
        },
    },

    flame_imp = {
        title = "Flame Imps",
        lines = {
            "Pre-shield tank.",
            "Tank should use as much thorns damage as possible.",
            "Melee stay out - Fire Nova.",
            "Do not pull threat, small heals only, wait on AoE.",
        },
    },

    core_hound = {
        title = "Core Hound x5",
        lines = {
            "Assign 1 tank to each.",
            "Must all die at the same time or they revive.",
            "Face away from raid and other tanks - Flame Breath.",
            "Tanks save taunt for threat drops and Piercing Howl.",
            "Bleed debuff on tanks - Serrated Bite.",
        },
    },

    magmadar = {
        title = "Magmadar",
        lines = {
            sep("Pre-pull"),
            "Buff spell power.",
            "Use GFPP.",
            "Move shaman(s) into the MT's group and healer groups for Tremor totem.",
            "Tranq Shot rotation (need at least 2 hunters).",
            "Track Conflagration and Panic.",
            sep("Mechanics"),
            "Do not stand in front - Flame Breath.",
            "Move out of fire.",
            "Watch for Frenzy and call for Tranquilizing Shot.",
        },
    },

    garr = {
        title = "Garr",
        lines = {
            sep("Pre-pull"),
            "Mark 8 tanks + warlocks and prepare assignments.",
            "Track Magnetize.",
            "All the buffs.",
            sep("Adds"),
            "Spread the ads, ranged finish the ads - they explode on death.",
            "Kill all ads except 2 to leave banished - each ad killed increases Garr's attack speed.",
            sep("Mechanics"),
            "Magnetize target must MOVE AWAY FROM THE RAID - spreading, big DoT.",
            "Healers must keep the Magnetize target alive.",
            "Dispel Magma Shackles off the Magnetize target - slow.",
            "Stacking debuff on the MT that increases physical damage taken - tanks cannot taunt, so a second tank (assigned to the first ad) must start building threat early.",
        },
    },

    gehennas = {
        title = "Gehennas",
        lines = {
            sep("Pre-pull"),
            "Buff spell power.",
            "Use GFPP.",
            "Assign up to 3 tanks to each ad, 1 strong MT, 2 MT healers (1 strong priest, 1 resto druid), 2 boss kickers.",
            "Track Gehennas' Curse.",
            "Pet pull.",
            sep("Adds"),
            "Kill first.",
            "Spread them out - War Stomp.",
            "Taunt rotation - Sunder Armor.",
            sep("Mechanics"),
            "DECURSE TANKS before the rest - reduces healing received by 90%.",
            "Move out of Rain of Fire.",
            "Kick Shadow Bolt.",
        },
    },

    baron_geddon = {
        title = "Baron Geddon",
        lines = {
            -- CHANGED: Fireguard has no matching trash key in MC.lua (not one
            -- of the packs the addon currently tracks), so it stays here
            -- rather than being split into its own entry like its neighbors.
            sep("Trash - Fireguard"),
            "1-2 Fire Resist/avoidance tank(s).",
            "Fire Prison second on threat.",
            "Tank away from Lava Elementals - Melt Armor hits nearby targets.",
            sep("Pre-pull"),
            "Use GFPP.",
            "Mark ranged and melee for stacking.",
            "Assign 2 dispellers.",
            "Make sure the MT has Fire Resist aura/totem.",
            "Track Living Bomb and Spreading Flames.",
            "Pet pull.",
            sep("Mechanics"),
            "LIVING BOMB target must MOVE AWAY FROM THE RAID - explodes.",
            "Pre-shield and keep the Living Bomb target alive.",
            "Spreading Flames target must move into the ranged group and STACK - splash, shared damage when the debuff expires.",
            "Dispel Ignite Mana, healers before mana users - chance to silence on dispel.",
            "Melee out during Inferno.",
            "Move out of Molten Ground.",
            "Line of sight the Last Service adds.",
            bsep("Broadcast"),
            rw("{boss}: [SKULL] Living Bomb -> RUN OUT || [CROSS] Spreading Flames -> STACK ON SQUARE"),
            "Melee out during Inferno, move out of Molten Ground.",
        },
    },

    -- Trash on the way to/around Baron Geddon, split into their own entries
    -- (registered under their MC.lua trash keys) the same way Lucifron's
    -- patrols were - see lava_surger/etc. above.
    firewalker = {
        title = "Firewalker",
        lines = {
            "1 Fire Resist/avoidance tank.",
            "Heal the Fireblossom target.",
        },
    },

    lava_elemental = {
        title = "Lava Elemental",
        lines = {
            "2 tanks on each (assign a banisher if not enough tanks).",
            "Face away from the raid - Pyroclast Barrage stun plus big DoT.",
            "Tanks stay 90 degrees from each other.",
        },
    },

    lava_reaver = {
        title = "Lava Reaver",
        lines = {
            "Watch for threat drops.",
        },
    },

    shazzrah = {
        title = "Shazzrah",
        lines = {
            sep("Pre-pull"),
            "Use GFPP.",
            "Bear MT.",
            sep("Mechanics"),
            "SPREAD - splash AoE Arcane Missiles.",
            "Mana drain hits hunters, warlocks, and dps priests.",
            "Decurse until the boss is oom.",
            "Avoid Counterspell.",
            "Move out of the rune.",
            "Watch for Polymorphs.",
            "Stop dps on Teleport.",
        },
    },

    golemagg = {
        title = "Golemagg",
        lines = {
            sep("Pre-pull"),
            "Assign 3-4 MTs, 1 tank for each dog.",
            "Dog tanks must have Luffa.",
            "Armor + Fire Resist totem/aura + Blood Pact in MT group.",
            "Assign 1 healer to each dog tank.",
            "Titan's Grip/Titans on all boss tanks.",
            "Make sure MTs and melee have Flask of the Titans (FAP).",
            "Track Implosion and Pyroblast.",
            sep("Mechanics"),
            "Move away from the Implosion target.",
            "Give MTs time to build threat - Hateful Strike.",
            "Melee must stop dps at 15 stacks of Magma Splash - reduces armor.",
            "Watch for Cleaves.",
            "Enrage at 20% - use Flask of the Titans for Warstomp, use CDs.",
        },
    },

    sulfuron = {
        title = "Sulfuron Harbinger",
        lines = {
            sep("Pre-pull"),
            "Buff spell power.",
            "Assign 1 tank to each ad (4 total), 2 MTs, 1 pickup tank, 1-2 kickers for each ad.",
            "Track War Stomp, Unbalancing Strike, and Sunder Armor.",
            sep("Adds"),
            "Spread them and kill one by one - Shadow Nova.",
            "Kick Dark Mending (heal).",
            "DISPEL Shadow Word: Pain and Immolate.",
            sep("Mechanics - Battle Stance"),
            "Chance to use Retaliation, melee don't kill yourself.",
            sep("Mechanics - Defensive Stance"),
            "Melee + OT move out initially to avoid War Stomp.",
            "He will continue to War Stomp after ~15s.",
            "OT gets ready to pick up if the MT gets stunned.",
            "Chance to use Shield Wall, save CDs.",
            "Sunder Armor on the MT - taunt at 3 stacks.",
            sep("Mechanics - Berserker Stance"),
            "Pickup tank be ready - he charges the furthest target.",
            "STOP DPS on charge.",
            "Use CDs - takes more damage.",
            "Mortal Strike is up - heals on attacks.",
            "Use CDs early.",
        },
    },

    majordomo = {
        title = "Major Domo Executus",
        lines = {
            sep("Pre-pull"),
            "Buff spell power.",
            "Detect Magic on all adds.",
            "Assign 1 mage to maintain Detect Magic throughout the fight.",
            "Assign 2 MTs, 1 tank for all healer adds, 1 tank for each melee add (4 total), and up to 3 mages to polymorph healers on pull.",
            sep("On pull"),
            "The tank on healers will pull - all other tanks/CCers MUST BE READY TO PICK UP THEIR TARGET.",
            sep("Mechanics"),
            "All adds will gain Damage Shield or Magic Reflection at the same time.",
            "Damage Shield (purple) causes thorns damage back to melee.",
            "Magic Reflection (white) reflects some spell damage back to casters.",
            "Kill melee adds first, then healer adds.",
            "Look for the add with Offensive Action Order - it takes 50% more damage.",
            "Teleports a random target to the pit.",
            "Polymorphs a random target.",
            "Kick Dark Mending once we start killing the healer adds.",
            "Use CDs early.",
        },
    },

    ragnaros = {
        title = "Ragnaros",
        resistances = { fire = { amount = 200, note = "buffed" } },
        lines = {
            sep("Pre-pull"),
            "Clear the first room of UBRS for the Fire Resist buff, save 1 spellbinder.",
            "Mark 1 melee for the stack.",
            "Assign 3-4 MT healers - 1 druid, 1 inspiration priest, 1-2 priests/resto shamans.",
            "MT group needs Blood Pact, Fire Resist aura/totem, and Armor aura/totem.",
            "Stack for buffs then position everyone by group - make sure each group has Fire Resist aura/totem.",
            "Use GFPP.",
            sep("Mechanics"),
            "AoE Fireball Volley.",
            "Ranged knockback on a random target.",
            "Melee move out before the AoE Knockback, then wait for tanks to re-establish aggro after the knockback.",
            "Submerge - everyone but the MTs and heals move onto the MT, start stacking before Submerge.",
            "Stack all Sons of Flame and AoE them down - do not CC, do not slow. Each Son alive at the end will heal Rag.",
            "Casters and healers stay back from the AoE Mana Drain.",
            bsep("Broadcast"),
            "Melee out before Knockback, stack for Submerge.",
            "Stack + AoE all Sons of Flame - do NOT let any survive, they heal Rag.",
        },
    },

    -- Blackwing Lair test entry - resistances-only, no tactics text yet.
    -- Ebonroc and Flamegor are fought together as one encounter (BWL.lua's
    -- "ebonroc_flamegor" key), so one entry covers both.
    ebonroc_flamegor = {
        title = "Ebonroc & Flamegor",
        resistances = { fire = 200, shadow = 200 },
        lines = {},
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
