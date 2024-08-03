LUAGUI_NAME = "Presents Abound!"
LUAGUI_AUTH = "adamboy7"
LUAGUI_DESC = "Enemies drop presents, open them for a suprise!"
local canExecute = false

enable_Treasure = true

-- Blazing, Frost, Lightning, Lucid, Power, Dark, Dense, Twilight, Mythril, Remembrance, Tranquility, Bright, Energy, Serenity, Manifest illusion, Lost Illusion, Orichalcum, Orichalcum+
synth_Items = {0x9ACE3F, 0x9ACE40, 0x9ACE41, 0x9ACE42, 0x9ACE7C, 0x9ACE7D, 0x9ACE7E, 0x9ACE7F, 0x9ACE47, 0x9ACE48, 0x9ACE49, 0x9ACE4A, 0x9ACE4F, 0x9ACE50, 0x9ACE51, 0x9ACE52, 0x9ACE4B, 0x9ACE4C, 0x9ACE4D, 0x9ACE4E, 0x9ACE9A, 0x9ACE9B, 0x9ACE9C, 0x9ACE9D, 0x9ACE53, 0x9ACE54, 0x9ACE55, 0x9ACE56, 0x9ACE57, 0x9ACE58, 0x9ACE59, 0x9ACE5A, 0x9ACE5B, 0x9ACE5C, 0x9ACE5D, 0x9ACE5E, 0x9ACED8, 0x9ACED9, 0x9ACEDA, 0x9ACEDB, 0x9ACEDC, 0x9ACEDD, 0x9ACEDE, 0x9ACEDF, 0x9ACE5F, 0x9ACE60, 0x9ACE61, 0x9ACE62, 0x9ACE63, 0x9ACE64, 0x9ACE65, 0x9ACE66, 0x9ACE67, 0x9ACE68, 0x9ACE69, 0x9ACE6A, 0x9ACEE1, 0x9ACEE0, 0x9ACE7B, 0x9ACE6B}
-- Power Boost, Magic Boost, Defence Boost, AP Boost
rare_Treasure = {0x9ACE96, 0x9ACE97, 0x9ACE98, 0x9ACE99}
present = 0x9ACE77
money = 0x9ABC70

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
		if ReadByte(present) >= 1 then
			if enable_Treasure == true then
				-- Generate 5% chance of treasure
				treasure_Roll = math.random(1, 100)
				if treasure_Roll <= 5 then
					loot = rare_Treasure[math.random(1, #rare_Treasure)]
					if ReadByte(loot) < 99 then
						WriteByte(loot, ReadByte(loot) + 1)
					else
						if ReadInt(money) + 50 >= 999999 then
							WriteInt(money, 999999)
						else
							WriteInt(money, ReadInt(money) + 50)
						end
					end
					WriteByte(present, ReadByte(present) - 1)
					return
				end
			end
			loot = synth_Items[math.random(1, #synth_Items)]
			if ReadByte(loot) < 99 then
				WriteByte(loot, ReadByte(loot) + 1)
			else
				if ReadInt(money) + 25 >= 999999 then
					WriteInt(money, 999999)
				else
					WriteInt(money, ReadInt(money) + 25)
				end
			end
			WriteByte(present, ReadByte(present) - 1)
		end
	end
end
