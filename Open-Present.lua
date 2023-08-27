LUAGUI_NAME = "Presents Abound!"
LUAGUI_AUTH = "adamboy7"
LUAGUI_DESC = "Enemies drop presents, open them for a suprise!"
local canExecute = false

local offset = 0x56454E
enable_Treasure = true

-- Blazing, Frost, Lightning, Lucid, Power, Dark, Dense, Twilight, Mythril, Remembrance, Tranquility, Bright, Energy, Serenity, Manifest illusion, Lost Illusion, Orichalcum, Orichalcum+
synth_Items = {0x9AA6BF, 0x9AA6C0, 0x9AA6C1, 0x9AA6C2, 0x9AA6FC, 0x9AA6FD, 0x9AA6FE, 0x9AA6FF, 0x9AA6C7, 0x9AA6C8, 0x9AA6C9, 0x9AA6CA, 0x9AA6CF, 0x9AA6D0, 0x9AA6D1, 0x9AA6D2, 0x9AA6CB, 0x9AA6CC, 0x9AA6CD, 0x9AA6CE, 0x9AA71A, 0x9AA71B, 0x9AA71C, 0x9AA71D, 0x9AA6D3, 0x9AA6D4, 0x9AA6D5, 0x9AA6D6, 0x9AA6D7, 0x9AA6D8, 0x9AA6D9, 0x9AA6DA, 0x9AA6DB, 0x9AA6DC, 0x9AA6DD, 0x9AA6DE, 0x9AA758, 0x9AA759, 0x9AA75A, 0x9AA75B, 0x9AA75C, 0x9AA75D, 0x9AA75E, 0x9AA75F, 0x9AA6DF, 0x9AA6E0, 0x9AA6E1, 0x9AA6E2, 0x9AA6E3, 0x9AA6E4, 0x9AA6E5, 0x9AA6E6, 0x9AA6E7, 0x9AA6E8, 0x9AA6E9, 0x9AA6EA, 0x9AA761, 0x9AA760, 0x9AA6FB, 0x9AA6EB}
-- Power Boost, Magic Boost, Defence Boost, AP Boost
rare_Treasure = {0x9AA716, 0x9AA717, 0x9AA718, 0x9AA719}
money = 0x9A94F0

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("Presents Abound! - installed")
		canExecute = true
	else
		ConsolePrint("Presents Abound!  - failed")
		canExecute = false
	end
end

function _OnFrame()
	if canExecute == true then
		if ReadByte(0x9AA6F7 - offset) >= 1 then
			if enable_Treasure == true then
				-- Generate 5% chance of treasure
				treasure_Roll = math.random(1, 100)
				if treasure_Roll <= 5 then
					loot = rare_Treasure[math.random(1, #rare_Treasure)]
					if ReadByte(loot - offset) < 99 then
						WriteByte(loot - offset, ReadByte(loot - offset) + 1)
					else
						if ReadInt(money - offset) + 50 >= 999999 then
							WriteInt(money - offset, 999999)
						else
							WriteInt(money - offset, ReadInt(money - offset) + 50)
						end
					end
					WriteByte(0x9AA6F7 - offset, ReadByte(0x9AA6F7 - offset) - 1)
					return
				end
			end
			loot = synth_Items[math.random(1, #synth_Items)]
			if ReadByte(loot - offset) < 99 then
				WriteByte(loot - offset, ReadByte(loot - offset) + 1)
			else
				if ReadInt(money - offset) + 25 >= 999999 then
					WriteInt(money - offset, 999999)
				else
					WriteInt(money - offset, ReadInt(money - offset) + 25)
				end
			end
			WriteByte(0x9AA6F7 - offset, ReadByte(0x9AA6F7 - offset) - 1)
		end
	end
end
