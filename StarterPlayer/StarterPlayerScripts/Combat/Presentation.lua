local slashColor = Color3.fromRGB(226, 160, 84)
local slashColor2 = Color3.fromRGB(150, 110, 200)
local slashColor3 = Color3.fromRGB(205, 180, 140)
local v4 = {
    Fists = {crosshair = "Melee", swingSound = "Swing_Punch", hitSound = "Hit_Punch", hitDelay = 0.08, noSlash = true, swings = {"Punch_R", "Punch_L"}},
    Sword = {crosshair = "Melee", hold = "Hold_Sword", block = "Sword_Guard", swingSound = "Sword_Swing", hitSound = "Sword_Hit", hitDelay = 0.09, equip = "Equip_Sword", trail = 0.28, swings = {"Sword_Swing1", "Sword_Swing2", "Sword_Swing3"}, slashColor = slashColor},
    Shield = {crosshair = "Melee", hold = "Shield_Hold", block = "Shield_Block", swingSound = "Swing_Heavy", hitSound = "Hit_Melee_Heavy", hitDelay = 0.09, equip = "Equip_Heavy", noSlash = true, shake = 0.25, swings = {"Shield_Bash"}},
    Gauntlets = {crosshair = "Melee", hold = "Gauntlets_Hold", lunge = "Gauntlets_Dash", lungeAnimSpeed = 1, swingSound = "Gauntlet_Swing", hitSound = "Gauntlet_Hit", lungeSound = "Gauntlet_Dash", hitDelay = 0.07, equip = "Gauntlet_Equip", noSlash = true, shake = 0.14, swings = {"Gauntlets_Jab", "Gauntlets_Cross", "Gauntlets_Hook", "Gauntlets_Upper"}},
    Scythe = {crosshair = "Melee", hold = "Scythe_Hold", lunge = "Scythe_Dash", lungeAnimSpeed = 1, lungeSound = "Scythe_Reap", lungeSlash = true, lungeLines = true, refreshSound = "Charge_Full", swingSound = "Scythe_Swing", hitSound = "Scythe_Hit", hitDelay = 0.2, equip = "Equip_Heavy", trail = 0.4, shake = 0.3, slam = false, swings = {"Scythe_Sweep1", "Scythe_Sweep2"}, slashColor = Color3.fromRGB(190, 200, 215)},
    Katana = {crosshair = "Melee", hold = "Katana_Hold", parry = "Katana_Parry", parryHold = "Katana_ParryHold", swingSound = "Katana_Swing", hitSound = "Katana_Hit", parrySound = "Katana_Flick", hitDelay = 0.08, equip = "Katana_Draw", trail = 0.24, shake = 0.16, swings = {"Katana_Slash1", "Katana_Slash2", "Katana_Slash3", "Katana_Slash4"}, slashColor = Color3.fromRGB(150, 196, 236)},
    Hatchets = {crosshair = "Melee", hold = "Hatchets_Hold", throw = "Hatchets_Throw", swingSound = "Hatchet_Swing", hitSound = "Hatchet_Hit", throwSound = "Hatchet_Throw", hitDelay = 0.08, equip = "Hatchet_Catch", trail = 0.2, shake = 0.16, swings = {"Hatchets_ChopR", "Hatchets_ChopL", "Hatchets_ChopR", "Hatchets_Double"}, oneSwings = {"Hatchets_ChopR", "Hatchets_Backhand"}, slashColor = Color3.fromRGB(214, 170, 120)},
    Axe = {crosshair = "Melee", hold = "Hold_Heavy", heavyCharge = "Axe_Charge", heavySwing = "Axe_Heavy", swingSound = "Axe_Swing", heavySound = "Axe_Heavy", chargeSound = "Melee_Charge", hitSound = "Axe_Hit", hitDelay = 0.2, heavyDelay = 0.16, equip = "Equip_Heavy", trail = 0.4, shake = 0.3, swings = {"Axe_Swing1", "Axe_Swing2"}, slashColor = slashColor},
    Spear = {crosshair = "Melee", hold = "Hold_Spear", lungeCharge = "Spear_Charge", lunge = "Spear_Stab", swingSound = "Spear_Stab", lungeSound = "Spear_Lunge", chargeSound = "Spear_Charge", hitSound = "Spear_Hit", hitDelay = 0.1, equip = "Equip_Blade", trail = 0.25, noSlash = true, swings = {"Spear_Stab"}, slashColor = slashColor},
    Dagger = {crosshair = "Melee", hold = "Hold_Sword", swingSound = "Dagger_Swing", hitSound = "Dagger_Hit", critSound = "Backstab", hitDelay = 0.06, equip = "Equip_Blade", trail = 0.18, swings = {"Dagger_Swing1", "Dagger_Swing2"}, slashColor = slashColor2},
    Club = {crosshair = "Melee", hold = "Hold_Heavy", swingSound = "Club_Swing", hitSound = "Club_Hit", hitDelay = 0.17, equip = "Equip_Heavy", trail = 0.35, shake = 0.35, swingSpeed = 1.1, swings = {"Axe_Swing1", "Axe_Swing2"}, slashColor = slashColor3},
    Bow = {crosshair = "Bow", hold = "Hold_Bow", draw = "Bow_Draw", aim = "Bow_Aim", fire = "Bow_Fire", drawSound = "ShortBow_Draw", fullSound = "Bow_Full", fireSound = "ShortBow_Fire", bodySound = "Arrow_Flesh", worldSound = "Arrow_Thunk", equip = "Equip_Bow", glow = Color3.fromRGB(255, 196, 110)},
    Crossbow = {crosshair = "Gun", hold = "Crossbow_Aim", fire = "Crossbow_Fire", fireAnimSpeed = 1, reload = "Crossbow_Reload", fireSound = "Crossbow_Fire", reloadSound = "Crossbow_Crank", reloadSound2 = "Crossbow_Reload", reloadDoneSound = "Crossbow_Ready", emptySound = "Dry_Fire", bodySound = "Arrow_Flesh", worldSound = "Arrow_Thunk", equip = "Equip_Crossbow", kick = 4.6, shake = 0.5, fovPunch = 2.2},
    Musket = {crosshair = "Gun", hold = "Crossbow_Aim", fire = "Crossbow_Fire", reload = "Crossbow_Reload", fireSound = "Musket_Fire", reloadSound = "Musket_Reload", reloadDoneSound = "Gun_Cock", emptySound = "Dry_Fire", bodySound = "Hit_Melee_Heavy", worldSound = "Impact_Dirt", equip = "Equip_Gun", kick = 11, shake = 0.55, puff = true, flash = true},
    Pistol = {crosshair = "Gun", hold = "Pistol_Hold", aim = "Pistol_Aim", fire = "Pistol_Fire", fireAnimSpeed = 1, reload = "Pistol_Reload", fireSound = "Flintlock_Fire", reloadSound = "Flintlock_Reload", reloadDoneSound = "Gun_Cock", emptySound = "Dry_Fire", bodySound = "Hit_Melee_Heavy", worldSound = "Impact_Dirt", equip = "Equip_Gun", kick = 7, shake = 0.35, puff = true, flash = true},
    Blunderbuss = {crosshair = "Spread", hold = "Crossbow_Aim", fire = "Crossbow_Fire", reload = "Crossbow_Reload", fireSound = "Blunderbuss_Fire", reloadSound = "Blunderbuss_Reload", reloadDoneSound = "Gun_Cock", emptySound = "Dry_Fire", bodySound = "Hit_Melee", worldSound = "Impact_Dirt", equip = "Equip_Gun", kick = 13, shake = 0.7, puff = true, flash = true},
    Knives = {crosshair = "Throw", hold = "Hold_Item", throw = "Throw", throwSound = "Knife_Throw", readySound = "Knife_Ready", bodySound = "Knife_Hit", worldSound = "Knife_Thunk", equip = "Equip_Blade", throwAnimSpeed = 1.8},
    Javelin = {crosshair = "Throw", hold = "Hold_Spear", windup = "Throw_Windup", throw = "Throw", windupSound = "Javelin_Draw", throwSound = "Javelin_Throw", bodySound = "Spear_Hit", worldSound = "Javelin_Hit", equip = "Equip_Item", arc = Color3.fromRGB(255, 225, 170)},
    Sling = {crosshair = "Throw", hold = "Hold_Item", throw = "Throw", throwSound = "Sling_Fire", whirlLoop = "Sling_Whirl", bodySound = "Stone_Hit", worldSound = "Impact_Stone", equip = "Equip_Bow", throwAnimSpeed = 1.5},
    Bomb = {crosshair = "Throw", hold = "Hold_Item", windup = "Throw_Windup", throw = "Throw", windupSound = "Throw_Windup", throwSound = "FireBomb_Throw", fuseLoop = "FireBomb_Fuse", equip = "Equip_Item", arc = Color3.fromRGB(255, 150, 60), arcSmoke = Color3.fromRGB(200, 204, 212)},
    Herbs = {crosshair = "Use", hold = "Hold_Item", use = "Use_Bandage", useSound = "Herbs_Chew", healSound = "Herbs_Heal", doneSound = "Heal_Done", label = "EATING", equip = "Equip_Item", color = Color3.fromRGB(120, 220, 110)},
    Trap = {crosshair = "Use", hold = "Hold_Item", use = "Use_Bandage", useSound = "Trap_Set", armedSound = "Trap_Armed", snapSound = "Trap_Snap", label = "SETTING TRAP", equip = "Equip_Item", color = Color3.fromRGB(215, 170, 110)},
    Horn = {crosshair = "Use", hold = "Hold_Item", use = "Use_Drink", useSound = "Equip_Item", label = "BLOWING THE HORN", equip = "Equip_Item", color = Color3.fromRGB(226, 190, 110)}
}
local v5 = {
    longbow = {drawSound = "Longbow_Draw", fireSound = "Longbow_Fire", hold = "Headhunter_Aim", fire = "Headhunter_Shoot", fireAnimSpeed = 1, draw = false, aim = false},
    smoke_bomb = {throwSound = "Throw", fuseLoop = "FireBomb_Fuse"},
    bandage = {useSound = "Bandage_Wrap", healSound = "Herbs_Heal", label = "BANDAGING", color = Color3.fromRGB(230, 214, 180)},
    palisade = {useSound = "Equip_Heavy", label = "BUILDING", color = Color3.fromRGB(214, 180, 130)},
    harpoon = {throwSound = "Harpoon_Throw", bodySound = "Harpoon_Hit", worldSound = "Harpoon_Thunk", equip = "Equip_Heavy", throwAnimSpeed = 1.05, recoil = 3, shake = 0.3},
    healing_tonic = {useSound = "Drink", label = "EATING", color = Color3.fromRGB(110, 200, 170)},
    caltrops = {windupSound = "Throw_Windup", throwSound = "Throw", fuseLoop = false, arc = Color3.fromRGB(196, 200, 210)},
    beehive = {windupSound = "Throw_Windup", throwSound = "Throw", fuseLoop = "Bees_Loop", arc = Color3.fromRGB(236, 190, 70)}
}
local v6 = {}

return {
    For = (function(key, a8)
        --[[
          name: For
          line: 392
          upvalues:
            v4 (copy, index: 1)
            v5 (copy, index: 2)
            v6 (copy, index: 3)
        ]]
        local v9 = v4[a8 or "Fists"] or v4.Fists
        local v10 = key and v5[key]
        if not v10 then
            return v9
        end

        local v11 = key .. "|" .. (a8 or "")

        if const v12 = v6[v11] then
            return v12
        end

        local values = table.clone(v9)

        for valueKey, v15 in v10 do
            if v15 == false then
                values[valueKey] = nil
            else
                values[valueKey] = v15
            end
        end

        v6[v11] = values

        return values
    end),
    Kind = (function(a16)
        --[[
          name: Kind
          line: 415
          upvalues:
            v4 (copy, index: 1)
        ]]
        return v4[a16 or "Fists"] or v4.Fists
    end)
}