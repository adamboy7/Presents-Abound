# Presents Abound!

A Kingdom Hearts II Final Mix mod that replaces the standard enemy drop table with presents — open them for a random synthesis material or stat boost.

## Why this exists

KH2 randomizer shuffles where enemies spawn and what the synthesis shop lets you create, but it doesn't touch what enemies actually drop. This means that even in a randomized run, farming synthesis materials still requires hunting the same specific enemies as vanilla — except now those enemies may not be where you expect them or even still be there depending on world progression. Presents Abound intervenes at the drop table level, replacing enemy drops with presents whose contents are determined at runtime using true randomness, completely independent of the seed.

The mod works with or without randomizer.

## How it works

The mod patches the enemy drop table (`00battle.bin`) so that enemies across the game have a chance to drop a Present item. When a Present is detected in the player's inventory, the Lua script immediately consumes it and awards one of the following:

**Synth materials (95% chance)** — one random item chosen from the full synthesis pool: Blazing, Frost, Lightning, Lucid, Power, Dark, Dense, Twilight, Mythril, Remembrance, Tranquility, Bright, Energy, and Serenity materials, plus Manifest Illusion, Lost Illusion, Orichalcum, and Orichalcum+.

**Rare treasure (5% chance)** — one of: Power Boost, Magic Boost, Defense Boost, or AP Boost.

If the awarded item is already at the stack cap of 99, the player receives Munny instead (25 for a synth material, 50 for a rare treasure), capped at the 999,999 maximum.

## Requirements

- Kingdom Hearts II Final Mix — PC (Steam and Epic Games, all versions) or emulator
- [KH2-Lua-Library](https://github.com/TopazTK/KH2-Lua-Library) mod installed and loaded before this mod

## Installation

1. Install `KH2FM-Mods-equations19/KH2-Lua-Library`
2. Install `adamboy7/Presents-Abound`

> `Presents Abound!` modifies `00battle.bin` using listpatch przt editing. As long as nothing else edits enemy drops it should be able to go basically anywhere in the mod list, but at or near the top is reccomended just in case.
