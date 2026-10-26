local v1 = Color3.fromRGB(226, 160, 84)
local v2 = Color3.fromRGB(150, 110, 200)
local v3 = Color3.fromRGB(205, 180, 140)
local tbl_upv_1 = {}
tbl_upv_1.Fists = {swingSound = "Swing_Punch", hitDelay = 0.08, noSlash = true, hitSound = "Hit_Punch", crosshair = "Melee", swings = {"Punch_R", "Punch_L"}}
tbl_upv_1.Sword = {swingSound = "Sword_Swing", trail = 0.28, hold = "Hold_Sword", hitDelay = 0.09, equip = "Equip_Sword", block = "Sword_Guard", hitSound = "Sword_Hit", crosshair = "Melee", swings = {"Sword_Swing1", "Sword_Swing2", "Sword_Swing3"}, slashColor = v1}
tbl_upv_1.Shield = {swingSound = "Swing_Heavy", noSlash = true, shake = 0.25, hold = "Shield_Hold", hitDelay = 0.09, equip = "Equip_Heavy", block = "Shield_Block", hitSound = "Hit_Melee_Heavy", crosshair = "Melee", swings = {"Shield_Bash"}}
tbl_upv_1.Gauntlets = {lunge = "Gauntlets_Dash", noSlash = true, lungeAnimSpeed = 1, lungeSound = "Gauntlet_Dash", shake = 0.14, hold = "Gauntlets_Hold", hitDelay = 0.07, equip = "Gauntlet_Equip", swingSound = "Gauntlet_Swing", hitSound = "Gauntlet_Hit", crosshair = "Melee", swings = {"Gauntlets_Jab", "Gauntlets_Cross", "Gauntlets_Hook", "Gauntlets_Upper"}}
tbl_upv_1.Scythe = {lunge = "Scythe_Dash", slam = false, refreshSound = "Charge_Full", hold = "Scythe_Hold", equip = "Equip_Heavy", hitSound = "Scythe_Hit", lungeAnimSpeed = 1, lungeLines = true, lungeSound = "Scythe_Reap", trail = 0.4, shake = 0.3, hitDelay = 0.2, lungeSlash = true, swingSound = "Scythe_Swing", crosshair = "Melee", swings = {"Scythe_Sweep1", "Scythe_Sweep2"}, slashColor = Color3.fromRGB(190, 200, 215)}
tbl_upv_1.Katana = {swingSound = "Katana_Swing", shake = 0.16, parry = "Katana_Parry", parrySound = "Katana_Flick", trail = 0.24, hold = "Katana_Hold", hitDelay = 0.08, equip = "Katana_Draw", parryHold = "Katana_ParryHold", hitSound = "Katana_Hit", crosshair = "Melee", swings = {"Katana_Slash1", "Katana_Slash2", "Katana_Slash3", "Katana_Slash4"}, slashColor = Color3.fromRGB(150, 196, 236)}
tbl_upv_1.Hatchets = {swingSound = "Hatchet_Swing", shake = 0.16, hitDelay = 0.08, equip = "Hatchet_Catch", trail = 0.2, hold = "Hatchets_Hold", throw = "Hatchets_Throw", throwSound = "Hatchet_Throw", hitSound = "Hatchet_Hit", crosshair = "Melee", swings = {"Hatchets_ChopR", "Hatchets_ChopL", "Hatchets_ChopR", "Hatchets_Double"}, oneSwings = {"Hatchets_ChopR", "Hatchets_Backhand"}, slashColor = Color3.fromRGB(214, 170, 120)}
tbl_upv_1.Axe = {swingSound = "Axe_Swing", shake = 0.3, hitDelay = 0.2, heavySound = "Axe_Heavy", chargeSound = "Melee_Charge", heavyDelay = 0.16, trail = 0.4, hold = "Hold_Heavy", heavyCharge = "Axe_Charge", equip = "Equip_Heavy", heavySwing = "Axe_Heavy", hitSound = "Axe_Hit", crosshair = "Melee", swings = {"Axe_Swing1", "Axe_Swing2"}, slashColor = v1}
tbl_upv_1.Spear = {lunge = "Spear_Stab", noSlash = true, lungeCharge = "Spear_Charge", chargeSound = "Spear_Charge", lungeSound = "Spear_Lunge", trail = 0.25, hold = "Hold_Spear", hitDelay = 0.1, equip = "Equip_Blade", swingSound = "Spear_Stab", hitSound = "Spear_Hit", crosshair = "Melee", swings = {"Spear_Stab"}, slashColor = v1}
tbl_upv_1.Dagger = {swingSound = "Dagger_Swing", critSound = "Backstab", trail = 0.18, hold = "Hold_Sword", equip = "Equip_Blade", hitDelay = 0.06, hitSound = "Dagger_Hit", crosshair = "Melee", swings = {"Dagger_Swing1", "Dagger_Swing2"}, slashColor = v2}
tbl_upv_1.Club = {swingSound = "Club_Swing", shake = 0.35, trail = 0.35, hold = "Hold_Heavy", swingSpeed = 1.1, equip = "Equip_Heavy", hitDelay = 0.17, hitSound = "Club_Hit", crosshair = "Melee", swings = {"Axe_Swing1", "Axe_Swing2"}, slashColor = v3}
tbl_upv_1.Bow = {fullSound = "Bow_Full", fireSound = "ShortBow_Fire", draw = "Bow_Draw", drawSound = "ShortBow_Draw", aim = "Bow_Aim", hold = "Hold_Bow", worldSound = "Arrow_Thunk", equip = "Equip_Bow", fire = "Bow_Fire", bodySound = "Arrow_Flesh", crosshair = "Bow", glow = Color3.fromRGB(255, 196, 110)}
tbl_upv_1.Crossbow = {shake = 0.25, fireSound = "Crossbow_Fire", reloadSound = "Crossbow_Crank", worldSound = "Arrow_Thunk", reloadSound2 = "Crossbow_Reload", fireAnimSpeed = 1, reload = "Crossbow_Reload", kick = 2.2, emptySound = "Dry_Fire", hold = "Crossbow_Aim", reloadDoneSound = "Crossbow_Ready", equip = "Equip_Crossbow", fire = "Crossbow_Fire", bodySound = "Arrow_Flesh", crosshair = "Gun"}
tbl_upv_1.Musket = {puff = true, fireSound = "Musket_Fire", reloadSound = "Musket_Reload", worldSound = "Impact_Dirt", flash = true, reloadDoneSound = "Gun_Cock", reload = "Crossbow_Reload", shake = 0.55, kick = 11, hold = "Crossbow_Aim", emptySound = "Dry_Fire", equip = "Equip_Gun", fire = "Crossbow_Fire", bodySound = "Hit_Melee_Heavy", crosshair = "Gun"}
tbl_upv_1.Pistol = {fireSound = "Flintlock_Fire", flash = true, hold = "Pistol_Hold", equip = "Equip_Gun", puff = true, reloadSound = "Flintlock_Reload", worldSound = "Impact_Dirt", fireAnimSpeed = 1, aim = "Pistol_Aim", shake = 0.35, reloadDoneSound = "Gun_Cock", reload = "Pistol_Reload", emptySound = "Dry_Fire", kick = 7, fire = "Pistol_Fire", bodySound = "Hit_Melee_Heavy", crosshair = "Gun"}
tbl_upv_1.Blunderbuss = {puff = true, fireSound = "Blunderbuss_Fire", reloadSound = "Blunderbuss_Reload", worldSound = "Impact_Dirt", flash = true, reloadDoneSound = "Gun_Cock", reload = "Crossbow_Reload", shake = 0.7, kick = 13, hold = "Crossbow_Aim", emptySound = "Dry_Fire", equip = "Equip_Gun", fire = "Crossbow_Fire", bodySound = "Hit_Melee", crosshair = "Spread"}
tbl_upv_1.Knives = {readySound = "Knife_Ready", worldSound = "Knife_Thunk", throwAnimSpeed = 1.8, hold = "Hold_Item", throw = "Throw", throwSound = "Knife_Throw", equip = "Equip_Blade", bodySound = "Knife_Hit", crosshair = "Throw"}
tbl_upv_1.Javelin = {windupSound = "Javelin_Draw", worldSound = "Javelin_Hit", windup = "Throw_Windup", hold = "Hold_Spear", throw = "Throw", throwSound = "Javelin_Throw", equip = "Equip_Item", bodySound = "Spear_Hit", crosshair = "Throw", arc = Color3.fromRGB(255, 225, 170)}
tbl_upv_1.Sling = {worldSound = "Impact_Stone", throwAnimSpeed = 1.5, equip = "Equip_Bow", hold = "Hold_Item", throw = "Throw", throwSound = "Sling_Fire", whirlLoop = "Sling_Whirl", bodySound = "Stone_Hit", crosshair = "Throw"}
tbl_upv_1.Bomb = {windupSound = "Throw_Windup", windup = "Throw_Windup", hold = "Hold_Item", throw = "Throw", throwSound = "FireBomb_Throw", equip = "Equip_Item", fuseLoop = "FireBomb_Fuse", crosshair = "Throw", arc = Color3.fromRGB(255, 150, 60), arcSmoke = Color3.fromRGB(200, 204, 212)}
tbl_upv_1.Herbs = {label = "EATING", healSound = "Herbs_Heal", hold = "Hold_Item", doneSound = "Heal_Done", equip = "Equip_Item", use = "Use_Bandage", useSound = "Herbs_Chew", crosshair = "Use", color = Color3.fromRGB(120, 220, 110)}
tbl_upv_1.Trap = {label = "SETTING TRAP", armedSound = "Trap_Armed", snapSound = "Trap_Snap", hold = "Hold_Item", equip = "Equip_Item", use = "Use_Bandage", useSound = "Trap_Set", crosshair = "Use", color = Color3.fromRGB(215, 170, 110)}
tbl_upv_1.Horn = {equip = "Equip_Item", hold = "Hold_Item", label = "BLOWING THE HORN", use = "Use_Drink", useSound = "Equip_Item", crosshair = "Use", color = Color3.fromRGB(226, 190, 110)}
local tbl_upv_2 = {}
tbl_upv_2.longbow = {hold = "Headhunter_Aim", fireSound = "Longbow_Fire", fireAnimSpeed = 1, draw = false, fire = "Headhunter_Shoot", drawSound = "Longbow_Draw", aim = false}
tbl_upv_2.smoke_bomb = {throwSound = "Throw", fuseLoop = "FireBomb_Fuse"}
tbl_upv_2.bandage = {label = "BANDAGING", useSound = "Bandage_Wrap", healSound = "Herbs_Heal", color = Color3.fromRGB(230, 214, 180)}
tbl_upv_2.palisade = {useSound = "Equip_Heavy", label = "BUILDING", color = Color3.fromRGB(214, 180, 130)}
tbl_upv_2.harpoon = {shake = 0.3, recoil = 3, worldSound = "Harpoon_Thunk", throwSound = "Harpoon_Throw", equip = "Equip_Heavy", bodySound = "Harpoon_Hit", throwAnimSpeed = 1.05}
tbl_upv_2.healing_tonic = {useSound = "Drink", label = "EATING", color = Color3.fromRGB(110, 200, 170)}
tbl_upv_2.caltrops = {throwSound = "Throw", fuseLoop = false, windupSound = "Throw_Windup", arc = Color3.fromRGB(196, 200, 210)}
tbl_upv_2.beehive = {throwSound = "Throw", fuseLoop = "Bees_Loop", windupSound = "Throw_Windup", arc = Color3.fromRGB(236, 190, 70)}
local tbl_upv_3 = {}
local tbl_4 = {}
function tbl_4.For(a1, a2)
    --[[
      name: For
      line: 388
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        tbl_upv_3 (copy, index: 3)
    ]]
    local v4 = tbl_upv_1[a2 or "Fists"] or (tbl_upv_1.Fists)
    local v5 = a1 and (tbl_upv_2[a1])
    if not v5 then
        return v4
    end
    local v6 = a1 .. "|" .. (a2 or "")
    local v7 = tbl_upv_3[v6]
    if v7 then
        return v7
    end
    local v8 = table.clone(v4)
    for key_1, value_1 in v5 do
        if value_1 ~= false then
            v8[key_1] = value_1
        else
            v8[key_1] = nil
        end
    end
    tbl_upv_3[v6] = v8
    return v8
end
function tbl_4.Kind(a1)
    --[[
      name: Kind
      line: 411
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return tbl_upv_1[a1 or "Fists"] or (tbl_upv_1.Fists)
end
return tbl_4