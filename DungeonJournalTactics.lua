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
--
-- Source: "Tips_Tricks about 40-man content for RL.docx" (Peach's Guide to
-- World Bosses / Addendum 1: Peach's Guide to Molten Core), transcribed
-- close to verbatim - only obvious typos and stray markup fixed (curly
-- quotes normalized, a stray "]" dropped, "GFrPP"/"GAPP" normalized to the
-- "GFPP" spelling used everywhere else in the doc). This is raid-lead
-- strategy content, not mechanics - see DungeonJournal's CLAUDE.md scope
-- rule for why it lives here instead of in the main journal.
------------------------------------------------------------

local TACTICS = {

    ------------------------------------------------------------
    -- World Bosses
    ------------------------------------------------------------

    kurinnaxx = {
        title = "Kurinnaxx",
        lines = {
            "General: If there are dps paladins, assign 1 of them to always do Judgement of Wisdom.",
            "Pre-pull: Scout him out.",
            "Pre-pull: Poison Cleanse totem in tank group.",
            "Pre-pull: Track Poison Bolt Volley.",
            "Pre-pull: Track Mortal Wound.",
            "Mechanics: Do not stand behind Kuri - Tail Swipe.",
            "Mechanics: Do not stand in front of Kuri unless you are tanking - ranged Poison Bolt Volley.",
            "Mechanics: All dps and healers should be positioned at Kuri's left or right side.",
            "Mechanics: Move away from Sand Trap or you will be silenced (Sand Trap) for 20s.",
            "Mechanics: Cleanse poison/totem - Poison Bolt Volley.",
            "Mechanics: Stop dps on Charge.",
            "Mechanics: Tanks taunt off each other at three to five stacks of Mortal Wound.",
            "Mechanics: Mortal Wound reduces healing taken by 10% per stack.",
            "Mechanics: Save CDs for Enrage at 30%.",
            "Mechanics: Boss needs to be disarmed as much as possible during Enrage.",
        },
    },

    azuregos = {
        title = "Azuregos",
        lines = {
            "Pre-pull: Assign 2 dispellers.",
            "Pre-pull: Assign 1-2 resto druids for Deep Freeze.",
            "Pre-pull: Use GFPP.",
            "Pre-pull: Track Deep Freeze.",
            "Mechanics: Do not stand in front unless you are tanking him - Frost Breath.",
            "Mechanics: Stand behind; does not tail swipe like most dragons.",
            "Mechanics: Move away from Mana Storm - it will mana drain.",
            "Mechanics: Heal Deep Freeze targets - freezes target in place and big DoT.",
            "Mechanics: Stop dps on Teleport.",
            "Mechanics: Casters stop spell damage on Magic Reflection.",
            "Mechanics: Dispel Chill, tanks before melee. Skip the rest.",
            "Mechanics: Immune to arcane, high frost resist.",
            "Mechanics: Mark of Frost - 15 minute undispellable debuff that freezes the player in place after death when Azuregos is nearby.",
        },
    },

    kazzak = {
        title = "Lord Kazzak",
        lines = {
            "Pre-pull: Mark melee for Meteor.",
            "Pre-pull: Assign a dispeller and a decurser.",
            "Pre-pull: Track Mark of Kazzak.",
            "Pre-pull: Track Twisted Reflection.",
            "Mechanics: Do not fall below 2k mana.",
            "Mechanics: Decurse Mark of Kazzak - drains mana over time; if the target goes oom with the debuff, they will explode.",
            "Mechanics: Do not die - every player that dies will heal him 70k+ hp.",
            "Mechanics: Pets dying will also heal Kazzak. This includes Eskhandar's.",
            "Mechanics: Any player or pet outside the raid will also provide healing if they're close to or in combat with him.",
            "Mechanics: Shadow Bolt Volley - AoE shadow bolts that hit everyone, ignoring line of sight.",
            "Mechanics: Melee dps must stay at max range from behind - Meteor (AoE knockback that could hit the tank) plus frontal Cleave.",
            "Mechanics: Dispel Twisted Reflection - heals Kazzak when damage is dealt to the target.",
            "Mechanics: Dispel Thunderclap from the MT, and assign a dedicated dispeller for all high-value melee dps.",
        },
    },

    hederine = {
        title = "Lady Hederine",
        lines = {
            "Pre-pull: Share the map.",
            "Pre-pull: Assign MT and 2 tanks for each add (5 tanks total).",
            "Pre-pull: Assign MoT healers (1 druid + 1 paladin/priest).",
            "Pre-pull: Mark ranged for stacking.",
            "Pre-pull: Nature Resist + Fire Resist totem in MT's group.",
            "Pre-pull: Sonic Lash is nature damage, Lash of Pain is fire damage.",
            "Pre-pull: Shaman and/or hunter in each group.",
            "Pre-pull: Track Bloating Toxins.",
            "Pre-pull: Track Flesh Explosion.",
            "Pre-pull: Track Curse of Weakness.",
            "Adds: OTs must pull.",
            "Adds: Tanks must taunt off each other at 3 stacks of Sunder Armor.",
            "Adds: Tanks must immediately taunt when adds start charging the MT on Hederine.",
            "Mechanics: Bloating Toxins target must be outside of line of sight of the whole raid - after the debuff expires, the target will AoE poison bolt volley anyone in their line of sight, including themself.",
            "Mechanics: Refer to the map for ideal LoS'ing positions.",
            "Mechanics: Every cast debuffs 2 units - targets the furthest raid member and a target within the top 3 threat (assumption; might be highest/2nd highest).",
            "Mechanics: Can assign a ranged soaker - resto shaman/resto druid/holy paladin with nature resist works well, and can be assigned as dispeller/decurser plus soaker.",
            "Mechanics: Cleanse the poison Flesh Explosion that occurs after Bloating Toxins.",
            "Mechanics: Move away from Tears of the Hederine (green gas) - you will get frozen if you stand in it too long, take a big DoT, and cannot be healed.",
            "Mechanics: Decurse Curse of Weakness, tanks before hunters and melee dps. Skip the rest.",
            "Mechanics: Dispel Impotence, shaman/paladin tank before dps shaman/warlock before mages/boomkins. Dps priests/paladins should dispel themselves.",
            "Mechanics: Impotence reduces magic damage by 90%.",
            "Mechanics: CC the mind-controlled target, do NOT kill them.",
            "Mechanics: Run back if you die when the boss is over 30%.",
            "Note: If many are dead and it's a slow kill, you may still want to run back, but if it's a smooth fight just stay nearby at 30% to avoid loot issues.",
        },
    },

    onyxia = {
        title = "Onyxia",
        lines = {
            "Forming: Stack and buff outside - spells are more expensive in the instance.",
            "Trash: Melee move out if you're low, wait for heals/bandage - Fire Nova/Cleave.",
            "Pre-pull: Use GFPP.",
            "Pre-pull: Stack on 1 side if able; otherwise make sure there is at least a tank/healer on the other side.",
            "Pre-pull: Mark a star for moving on pull.",
            "Pre-pull: Tremor totem + Fire Resist totem + Devotion Aura in MT group.",
            "Pre-pull: Track Threatening Gaze.",
            "Pre-pull: Track Engulfing Flames.",
            "On pull: Move together, do not pass the star.",
            "On pull: Do not stand behind her - Tail Swipe.",
            "On pull: Do not stand in front of her unless you are tanking - Flame Breath.",
            "Whelps: Assign a whelp tank.",
            "Whelps: Kill all whelps that spawn - make sure healers aren't getting whelp aggro.",
            "Phase 1: Slow dps until positioned, set up debuffs while moving into position, e.g. Expose Armor/curses/DoTs.",
            "Phase 1: Threatening Gaze target must stop all actions or they will aggro her.",
            "Phase 1: Save damage cooldowns for as soon as she hits 66% when she begins to move - BLOW EVERYTHING.",
            "Phase 2: Use CDs before she flies away at the beginning of phase 2 (~70%).",
            "Phase 2: Avoid Deep Breath - call out safe spots when she moves to a new position.",
            "Phase 2: Do not stand in the middle.",
            "Phase 2: Spread out to avoid Fireball - AoE conflagration (Onyxia telegraphs who she is casting on; they get a mark ~3s before it hits, so avoidance/dodge also works).",
            "Phase 3: Slow dps on landing, let the MT reposition to the phase 1 tanking position, be careful with DoT aggro during the phase change.",
            "Phase 3: Threatening Gaze target must stop all actions or they will aggro her.",
            "Phase 3: TREMOR TOTEM up - Bellowing Roar is an AoE fear.",
            "Phase 3: Druid tank can spec for enrage to avoid every fear, warrior can stance-dance most of it, paladin can spec for morale.",
        },
    },

    ------------------------------------------------------------
    -- Molten Core
    ------------------------------------------------------------

    lucifron = {
        title = "Lucifron",
        lines = {
            "Forming: Promote a paladin to handle blessings and judgements.",
            "Forming: BoK, BoS/Sanctuary/BoL, BoM/BoW required.",
            "Forming: Judgement priority - JoW > JoL > JoC.",
            "Forming: Assign a warlock to handle curses - CoS (arcane + shadow pen) > CoR (armor pen) > CoE (nature pen).",
            "Forming: Need improved Faerie Fire druid (boomkin/resto).",
            "Forming: Need improved Thunder Clap (arms/tank).",
            "Forming: Need improved Demoralizing Roar (feral tank).",
            "Forming: Need Find Weakness hunter (survival).",
            "Forming: Need a carrion bird/owl/bat pet for Screech.",
            "Forming: Need an inspiration priest.",
            "Forming: Need an ancestral healing shaman.",
            "Forming: Assign Sacrifice (Guardian's Favor paladin) + Soulstone/Life (Chain Heal or resto shaman) for the dogs.",
            "Forming: Improved Defensive Aura (paladin)?",
            "Forming: Guardian Totems (shaman)?",
            "Patrol - Lava Surger: Stack and banish - charges.",
            "Patrol - Lava Surger: Heal through Flamestrike.",
            "Patrol - Lava Surger: Magic debuff (Magma Shackles) that slows.",
            "Patrol - Ancient Core Hound: Pre-shield tanks - Vicious Bite (hateful strike).",
            "Patrol - Ancient Core Hound: Cannot be avoided or dodged; needs armor + stamina for OTs.",
            "Patrol - Ancient Core Hound: Do not dispel/decurse in combat - applies a random debuff.",
            "Patrol - Ancient Core Hound: BoS + Soulstone/Life up on tanks for Disorient.",
            "Patrol - Ancient Core Hound: 2 MTs in front, rest to the side facing away from the raid - Flamebreath.",
            "Patrol - Ancient Core Hound: Bleed debuff on tanks - Serrated Bite.",
            "Trash - Molten Giant: Up to 3 tanks on each - Knockaway.",
            "Trash - Molten Giant: Spread them out - Cleave.",
            "Trash - Lava Annihilator: Burst down - explodes.",
            "Trash - Lava Annihilator: Banish and spread if more than 1 mob.",
            "Trash - Lava Annihilator: Stacking debuff on tank that increases physical damage taken.",
            "Trash - Lava Annihilator: Stop dps on threat drop.",
            "Trash - Fire Lord: Priority-kill the spawn (cannot be AoE'd).",
            "Trash - Fire Lord: Pull away from the tank on Conflagration.",
            "Trash - Fire Lord: Keep HoTs up on the Soul Burn target - big DoT plus silence.",
            "Trash - Molten Destroyer: Pre-shield tanks, tanks must move together on pull - Hateful Strike.",
            "Trash - Molten Destroyer: Kill the destroyer first (best tanks).",
            "Trash - Molten Destroyer: Spread them out - AoE knockdown.",
            "Trash - Molten Destroyer: Big heals - Pyroblast on tanks.",
            "Boss trash - Flame Imps: Pre-shield tank.",
            "Boss trash - Flame Imps: Tank should use as much thorns damage as possible.",
            "Boss trash - Flame Imps: Melee stay out - Fire Nova.",
            "Boss trash - Flame Imps: Do not pull threat, small heals only, wait on AoE.",
            "Boss trash - Core Hound x5: Assign 1 tank to each.",
            "Boss trash - Core Hound x5: Must all die at the same time or they revive.",
            "Boss trash - Core Hound x5: Face away from raid and other tanks - Flame Breath.",
            "Boss trash - Core Hound x5: Tanks save taunt for threat drops and Piercing Howl.",
            "Boss trash - Core Hound x5: Bleed debuff on tanks - Serrated Bite.",
            "Pre-pull: Buff spell power.",
            "Pre-pull: Track Impending Doom and Lucifron's Curse.",
            "Pre-pull: Assign tanks (5-6), dispellers (all healers that can dispel and are not MT healers), decursers (ALL mages, resto druids, and boomkins), and boss ToT healers (2).",
            "Adds: Assign up to 2 tanks to each.",
            "Adds: Priority-kill one by one.",
            "Adds: NO AoE - Mind Control.",
            "Adds: Spread them out - Whirlwind.",
            "Mechanics: Dispel Impending Doom - 2k shadow damage when the debuff expires.",
            "Mechanics: Decurse Lucifron's Curse, tanks before healers before the rest - abilities become more expensive.",
            "Mechanics: Taunt rotation - stacking debuff on the MT, swap at 3 stacks.",
        },
    },

    magmadar = {
        title = "Magmadar",
        lines = {
            "Pre-pull: Buff spell power.",
            "Pre-pull: Use GFPP.",
            "Pre-pull: Move shaman(s) into the MT's group and healer groups for Tremor totem.",
            "Pre-pull: Tranq Shot rotation (need at least 2 hunters).",
            "Pre-pull: Track Conflagration and Panic.",
            "Mechanics: Do not stand in front - Flame Breath.",
            "Mechanics: Move out of fire.",
            "Mechanics: Watch for Frenzy and call for Tranquilizing Shot.",
        },
    },

    garr = {
        title = "Garr",
        lines = {
            "Pre-pull: Mark 8 tanks + warlocks and prepare assignments.",
            "Pre-pull: Track Magnetize.",
            "Pre-pull: All the buffs.",
            "Adds: Spread the ads, ranged finish the ads - they explode on death.",
            "Adds: Kill all ads except 2 to leave banished - each ad killed increases Garr's attack speed.",
            "Mechanics: Magnetize target must MOVE AWAY FROM THE RAID - spreading, big DoT.",
            "Mechanics: Healers must keep the Magnetize target alive.",
            "Mechanics: Dispel Magma Shackles off the Magnetize target - slow.",
            "Mechanics: Stacking debuff on the MT that increases physical damage taken - tanks cannot taunt, so a second tank (assigned to the first ad) must start building threat early.",
        },
    },

    gehennas = {
        title = "Gehennas",
        lines = {
            "Pre-pull: Buff spell power.",
            "Pre-pull: Use GFPP.",
            "Pre-pull: Assign up to 3 tanks to each ad, 1 strong MT, 2 MT healers (1 strong priest, 1 resto druid), 2 boss kickers.",
            "Pre-pull: Track Gehennas' Curse.",
            "Pre-pull: Pet pull.",
            "Adds: Kill first.",
            "Adds: Spread them out - War Stomp.",
            "Adds: Taunt rotation - Sunder Armor.",
            "Mechanics: DECURSE TANKS before the rest - reduces healing received by 90%.",
            "Mechanics: Move out of Rain of Fire.",
            "Mechanics: Kick Shadow Bolt.",
        },
    },

    baron_geddon = {
        title = "Baron Geddon",
        lines = {
            "Trash - Firewalker: 1 Fire Resist/avoidance tank.",
            "Trash - Firewalker: Heal the Fireblossom target.",
            "Trash - Fireguard: 1-2 Fire Resist/avoidance tank(s).",
            "Trash - Fireguard: Fire Prison second on threat.",
            "Trash - Fireguard: Tank away from Lava Elementals - Melt Armor hits nearby targets.",
            "Trash - Lava Elemental: 2 tanks on each (assign a banisher if not enough tanks).",
            "Trash - Lava Elemental: Face away from the raid - Pyroclast Barrage stun plus big DoT.",
            "Trash - Lava Elemental: Tanks stay 90 degrees from each other.",
            "Trash - Lava Reaver: Watch for threat drops.",
            "Pre-pull: Use GFPP.",
            "Pre-pull: Mark ranged and melee for stacking.",
            "Pre-pull: Assign 2 dispellers.",
            "Pre-pull: Make sure the MT has Fire Resist aura/totem.",
            "Pre-pull: Track Living Bomb and Spreading Flames.",
            "Pre-pull: Pet pull.",
            "Mechanics: LIVING BOMB target must MOVE AWAY FROM THE RAID - explodes.",
            "Mechanics: Pre-shield and keep the Living Bomb target alive.",
            "Mechanics: Spreading Flames target must move into the ranged group and STACK - splash, shared damage when the debuff expires.",
            "Mechanics: Dispel Ignite Mana, healers before mana users - chance to silence on dispel.",
            "Mechanics: Melee out during Inferno.",
            "Mechanics: Move out of Molten Ground.",
            "Mechanics: Line of sight the Last Service adds.",
        },
    },

    shazzrah = {
        title = "Shazzrah",
        lines = {
            "Pre-pull: Use GFPP.",
            "Pre-pull: Bear MT.",
            "Mechanics: SPREAD - splash AoE Arcane Missiles.",
            "Mechanics: Mana drain hits hunters, warlocks, and dps priests.",
            "Mechanics: Decurse until the boss is oom.",
            "Mechanics: Avoid Counterspell.",
            "Mechanics: Move out of the rune.",
            "Mechanics: Watch for Polymorphs.",
            "Mechanics: Stop dps on Teleport.",
        },
    },

    golemagg = {
        title = "Golemagg",
        lines = {
            "Pre-pull: Assign 3-4 MTs, 1 tank for each dog.",
            "Pre-pull: Dog tanks must have Luffa.",
            "Pre-pull: Armor + Fire Resist totem/aura + Blood Pact in MT group.",
            "Pre-pull: Assign 1 healer to each dog tank.",
            "Pre-pull: Titan's Grip/Titans on all boss tanks.",
            "Pre-pull: Make sure MTs and melee have Flask of the Titans (FAP).",
            "Pre-pull: Track Implosion and Pyroblast.",
            "Mechanics: Move away from the Implosion target.",
            "Mechanics: Give MTs time to build threat - Hateful Strike.",
            "Mechanics: Melee must stop dps at 15 stacks of Magma Splash - reduces armor.",
            "Mechanics: Watch for Cleaves.",
            "Mechanics: Enrage at 20% - use Flask of the Titans for Warstomp, use CDs.",
        },
    },

    sulfuron = {
        title = "Sulfuron Harbinger",
        lines = {
            "Pre-pull: Buff spell power.",
            "Pre-pull: Assign 1 tank to each ad (4 total), 2 MTs, 1 pickup tank, 1-2 kickers for each ad.",
            "Pre-pull: Track War Stomp, Unbalancing Strike, and Sunder Armor.",
            "Adds: Spread them and kill one by one - Shadow Nova.",
            "Adds: Kick Dark Mending (heal).",
            "Adds: DISPEL Shadow Word: Pain and Immolate.",
            "Mechanics - Battle Stance: Chance to use Retaliation, melee don't kill yourself.",
            "Mechanics - Defensive Stance: Melee + OT move out initially to avoid War Stomp.",
            "Mechanics - Defensive Stance: He will continue to War Stomp after ~15s.",
            "Mechanics - Defensive Stance: OT gets ready to pick up if the MT gets stunned.",
            "Mechanics - Defensive Stance: Chance to use Shield Wall, save CDs.",
            "Mechanics - Defensive Stance: Sunder Armor on the MT - taunt at 3 stacks.",
            "Mechanics - Berserker Stance: Pickup tank be ready - he charges the furthest target.",
            "Mechanics - Berserker Stance: STOP DPS on charge.",
            "Mechanics - Berserker Stance: Use CDs - takes more damage.",
            "Mechanics - Berserker Stance: Mortal Strike is up - heals on attacks.",
            "Mechanics - Berserker Stance: Use CDs early.",
        },
    },

    majordomo = {
        title = "Major Domo Executus",
        lines = {
            "Pre-pull: Buff spell power.",
            "Pre-pull: Detect Magic on all adds.",
            "Pre-pull: Assign 1 mage to maintain Detect Magic throughout the fight.",
            "Pre-pull: Assign 2 MTs, 1 tank for all healer adds, 1 tank for each melee add (4 total), and up to 3 mages to polymorph healers on pull.",
            "On pull: The tank on healers will pull - all other tanks/CCers MUST BE READY TO PICK UP THEIR TARGET.",
            "Mechanics: All adds will gain Damage Shield or Magic Reflection at the same time.",
            "Mechanics: Damage Shield (purple) causes thorns damage back to melee.",
            "Mechanics: Magic Reflection (white) reflects some spell damage back to casters.",
            "Mechanics: Kill melee adds first, then healer adds.",
            "Mechanics: Look for the add with Offensive Action Order - it takes 50% more damage.",
            "Mechanics: Teleports a random target to the pit.",
            "Mechanics: Polymorphs a random target.",
            "Mechanics: Kick Dark Mending once we start killing the healer adds.",
            "Mechanics: Use CDs early.",
        },
    },

    ragnaros = {
        title = "Ragnaros",
        lines = {
            "Pre-pull: Clear the first room of UBRS for the Fire Resist buff, save 1 spellbinder.",
            "Pre-pull: Mark 1 melee for the stack.",
            "Pre-pull: Assign 3-4 MT healers - 1 druid, 1 inspiration priest, 1-2 priests/resto shamans.",
            "Pre-pull: MT group needs Blood Pact, Fire Resist aura/totem, and Armor aura/totem.",
            "Pre-pull: Stack for buffs then position everyone by group - make sure each group has Fire Resist aura/totem.",
            "Pre-pull: Use GFPP.",
            "Mechanics: AoE Fireball Volley.",
            "Mechanics: Ranged knockback on a random target.",
            "Mechanics: Melee move out before the AoE Knockback, then wait for tanks to re-establish aggro after the knockback.",
            "Mechanics: Submerge - everyone but the MTs and heals move onto the MT, start stacking before Submerge.",
            "Mechanics: Stack all Sons of Flame and AoE them down - do not CC, do not slow. Each Son alive at the end will heal Rag.",
            "Mechanics: Casters and healers stay back from the AoE Mana Drain.",
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
