LUAGUI_NAME = "Presents Abound!"
LUAGUI_AUTH = "adamboy7"
LUAGUI_DESC = "Enemies drop presents, open them for a surprise!"

local CanExecute = false

enable_Treasure = true

-- Addresses resolved in _OnInit from kh2lib
local synth_Items   = {}
local rare_Treasure = {}
local present       = nil
local money         = nil

-- Munny is not provided by kh2lib but sits at a fixed offset from the Save address.
-- Verified on Steam 1.0.0.10: exe+9ABCF0 = Save+0x2440
local MONEY_OFFSET = 0x2440

function _OnInit()
    kh2libstatus, kh2lib = pcall(require, "kh2lib")
    if not kh2libstatus then
        print("ERROR (Presents Abound!): KH2-Lua-Library mod is not installed")
        CanExecute = false
        return
    end

    RequireKH2LibraryVersion(1)

    CanExecute = kh2lib.CanExecute
    if not CanExecute then
        ConsolePrint("Presents Abound! - failed")
        return
    end

    ConsolePrint("Presents Abound! - installed")

    local Save = kh2lib.Save
    money   = Save + MONEY_OFFSET
    present = kh2lib.Present

    synth_Items = {
        kh2lib.BlazingShard,     kh2lib.BlazingStone,     kh2lib.BlazingGem,     kh2lib.BlazingCrystal,
        kh2lib.FrostShard,       kh2lib.FrostStone,       kh2lib.FrostGem,       kh2lib.FrostCrystal,
        kh2lib.LightningShard,   kh2lib.LightningStone,   kh2lib.LightningGem,   kh2lib.LightningCrystal,
        kh2lib.LucidShard,       kh2lib.LucidStone,       kh2lib.LucidGem,       kh2lib.LucidCrystal,
        kh2lib.PowerShard,       kh2lib.PowerStone,       kh2lib.PowerGem,       kh2lib.PowerCrystal,
        kh2lib.DarkShard,        kh2lib.DarkStone,        kh2lib.DarkGem,        kh2lib.DarkCrystal,
        kh2lib.DenseShard,       kh2lib.DenseStone,       kh2lib.DenseGem,       kh2lib.DenseCrystal,
        kh2lib.TwilightShard,    kh2lib.TwilightStone,    kh2lib.TwilightGem,    kh2lib.TwilightCrystal,
        kh2lib.MythrilShard,     kh2lib.MythrilStone,     kh2lib.MythrilGem,     kh2lib.MythrilCrystal,
        kh2lib.RemembranceShard, kh2lib.RemembranceStone, kh2lib.RemembranceGem, kh2lib.RemembranceCrystal,
        kh2lib.TranquilityShard, kh2lib.TranquilityStone, kh2lib.TranquilityGem, kh2lib.TranquilityCrystal,
        kh2lib.BrightShard,      kh2lib.BrightStone,      kh2lib.BrightGem,      kh2lib.BrightCrystal,
        kh2lib.EnergyShard,      kh2lib.EnergyStone,      kh2lib.EnergyGem,      kh2lib.EnergyCrystal,
        kh2lib.SerenityShard,    kh2lib.SerenityStone,    kh2lib.SerenityGem,    kh2lib.SerenityCrystal,
        kh2lib.ManifestIllusion, kh2lib.LostIllusion,     kh2lib.Orichalcum,     kh2lib.OrichalcumPlus,
    }

    rare_Treasure = {
        kh2lib.PowerBoost,
        kh2lib.MagicBoost,
        kh2lib.DefenseBoost,
        kh2lib.APBoost,
    }
end

function _OnFrame()
    if not CanExecute then return end

    if ReadByte(present) >= 1 then
        if enable_Treasure == true then
            -- 5% chance of a rare treasure
            local treasure_Roll = math.random(1, 100)
            if treasure_Roll <= 5 then
                local loot = rare_Treasure[math.random(1, #rare_Treasure)]
                if ReadByte(loot) < 99 then
                    WriteByte(loot, ReadByte(loot) + 1)
                else
                    WriteInt(money, math.min(ReadInt(money) + 50, 999999))
                end
                WriteByte(present, ReadByte(present) - 1)
                return
            end
        end

        local loot = synth_Items[math.random(1, #synth_Items)]
        if ReadByte(loot) < 99 then
            WriteByte(loot, ReadByte(loot) + 1)
        else
            WriteInt(money, math.min(ReadInt(money) + 25, 999999))
        end
        WriteByte(present, ReadByte(present) - 1)
    end
end
