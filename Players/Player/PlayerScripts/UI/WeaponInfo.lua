local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local tbl_upv_1 = {}
tbl_upv_1.CATEGORIES = {"bow", "gun", "melee", "throwable", "utility", "healing", "armor", "ammo"}
tbl_upv_1.CATEGORY_NAMES = {ammo = "AMMO", throwable = "THROWABLES", melee = "MELEE", healing = "HEALING", armor = "ARMOR", gun = "GUNS", bow = "BOWS", utility = "UTILITY"}
tbl_upv_1.CATEGORY_SINGULAR = {ammo = "AMMO", throwable = "THROWABLE", melee = "MELEE", healing = "HEALING", armor = "ARMOR", gun = "GUN", bow = "BOW", utility = "UTILITY"}
tbl_upv_1.CATEGORY_COLORS = {bow = Color3.fromRGB(232, 170, 44), gun = Color3.fromRGB(128, 150, 176), melee = Color3.fromRGB(214, 72, 52), throwable = Color3.fromRGB(44, 176, 172), utility = Color3.fromRGB(156, 112, 206), healing = Color3.fromRGB(110, 196, 86), armor = Color3.fromRGB(196, 148, 92), ammo = Color3.fromRGB(240, 96, 48)}
local tbl_upv_2 = {}
tbl_upv_2.short_bow = {name = "Wood Bow", category = "bow", kind = "Bow", description = "Fast draw, arrows drop over distance. Reliable at any range.", points = 3, bars = {0.45, 0.8, 0.7, 0.8}}
tbl_upv_2.longbow = {name = "Headhunter", category = "bow", kind = "Bow", description = "Slow, heavy draw with a zoom. A full-draw headshot kills.", points = 5, bars = {0.85, 0.3, 1, 0.45}}
tbl_upv_2.crossbow = {name = "Crossbow", category = "bow", kind = "Crossbow", description = "Instant bolt, no draw. Reload after every shot.", points = 4, bars = {0.7, 0.4, 0.85, 0.75}}
tbl_upv_2.musket = {name = "Musket", category = "gun", kind = "Musket", description = "Thunderous single shot with a smoke puff. Long reload.", points = 5, bars = {1, 0.15, 0.95, 0.5}}
tbl_upv_2.blunderbuss = {name = "Blunderbuss", category = "gun", kind = "Blunderbuss", description = "A spray of pellets. Devastating up close, useless far away.", points = 4, bars = {0.9, 0.3, 0.25, 0.7}}
tbl_upv_2.flintlock = {name = "Flintlock", category = "gun", kind = "Pistol", description = "One-shot pistol. Finish a wounded foe, then reload.", points = 3, bars = {0.7, 0.45, 0.65, 0.9}}
tbl_upv_2.bronze_sword = {name = "Iron Sword", category = "melee", kind = "Sword", description = "Balanced three-hit combo. Hold to block.", points = 3, bars = {0.6, 0.7, 0.3, 0.8}}
tbl_upv_2.battle_axe = {name = "Battle Axe", category = "melee", kind = "Axe", description = "Heavy swings and a charged overhead that splits guards.", points = 4, bars = {0.9, 0.35, 0.3, 0.7}}
tbl_upv_2.spear = {name = "Spear", category = "melee", kind = "Spear", description = "Longest reach. Charge a lunge to close the gap.", points = 4, bars = {0.65, 0.5, 0.5, 0.75}}
tbl_upv_2.war_club = {name = "Hammer", category = "melee", kind = "Club", description = "Knocks foes back and staggers them.", points = 3, bars = {0.75, 0.45, 0.3, 0.7}}
tbl_upv_2.obsidian_dagger = {name = "Diamond Dagger", category = "melee", kind = "Dagger", description = "Lightning-fast stabs with a backstab bonus.", points = 2, bars = {0.35, 1, 0.2, 1}}
tbl_upv_2.throwing_knives = {name = "Throwing Knives", category = "throwable", kind = "Knives", description = "Fast, flat throws. Five knives per round.", points = 2, bars = {0.35, 0.95, 0.55, 0.9}}
tbl_upv_2.javelins = {name = "Javelins", category = "throwable", kind = "Javelin", description = "Heavy throws that hit hard. Three per round.", points = 2, bars = {0.8, 0.4, 0.65, 0.7}}
tbl_upv_2.sling = {name = "Sling", category = "throwable", kind = "Sling", description = "Lobbed stones that arc over cover. Twelve per round.", points = 1, bars = {0.35, 0.8, 0.7, 0.9}}
tbl_upv_2.fire_bomb = {name = "Fireball", category = "utility", kind = "Bomb", description = "Shatters into a pool of flame that burns anyone inside.", points = 2, bars = {0.6, 0.4, 0.55, 0.8}}
tbl_upv_2.smoke_bomb = {name = "Smoke Bomb", category = "utility", kind = "Bomb", description = "A thick cloud that blocks sight. Reposition, escape, revive a push.", points = 1, bars = {0, 0.5, 0.55, 1}}
tbl_upv_2.bear_trap = {name = "Snap Trap", category = "utility", kind = "Trap", description = "Set it in a chokepoint. Roots the first enemy who steps in.", points = 1, bars = {0.45, 0.3, 0.15, 0.8}}
tbl_upv_2.bandage = {name = "Bandage", category = "healing", kind = "Bandage", description = "A quick heal at once. Two per round.", points = 1, bars = {0, 0.8, 0, 0.8}}
tbl_upv_2.healing_herbs = {name = "Apple", category = "healing", kind = "Herbs", description = "Chew to heal over a few seconds. Stay out of sight.", points = 2, bars = {0, 0.5, 0, 0.7}}
tbl_upv_2.healing_tonic = {name = "Golden Apple", category = "healing", kind = "Tonic", description = "Heals to full at once, plus golden armor for a few seconds.", points = 3, bars = {0, 0.3, 0, 0.6}}
tbl_upv_2.hide_armor = {description = "Light armor: soaks a hit or two, barely slows you.", name = "Leather Armor", category = "armor", armor = 25, hotbar = false, speed = 0.97, points = 2}
tbl_upv_2.bone_armor = {description = "Medium armor: a real second health bar, a little slower.", name = "Iron Armor", category = "armor", armor = 50, hotbar = false, speed = 0.93, points = 4}
tbl_upv_2.bronze_armor = {description = "Heavy armor: shrug off a volley, but you'll feel the weight.", name = "Diamond Armor", category = "armor", armor = 80, hotbar = false, speed = 0.88, points = 6}
local tbl_upv_3 = {"DAMAGE", "SPEED", "RANGE"}
local tbl_upv_4 = {armor = "hide_armor"}
tbl_upv_4.items = {"bronze_sword", "short_bow", "bandage"}
tbl_upv_4.ammo = {arrows = 3}
local tbl_upv_5 = {}
tbl_upv_5.arrows = {name = "Arrows", id = "arrows", points = 1, order = 1, perBundle = 12}
tbl_upv_5.shot = {name = "Bullets", id = "shot", points = 1, order = 2, perBundle = 6}
local tbl_upv_6 = {crossbow = "arrows", musket = "shot", longbow = "arrows", short_bow = "arrows", blunderbuss = "shot", flintlock = "shot"}
local u1 = nil
local u2 = -math.huge
local function getRegistry()
    --[[
      name: getRegistry
      line: 97
      upvalues:
        u1 (ref,  index: 1)
        u2 (ref,  index: 2)
        ReplicatedStorage_upv_1 (copy, index: 3)
    ]]
    if u1 then
        return u1
    end
    if os.clock() - u2 < 5 then
        return nil
    end
    u2 = os.clock()
    local Weapons_1 = ReplicatedStorage_upv_1.Shared:FindFirstChild("Weapons")
    if Weapons_1 and Weapons_1:IsA("ModuleScript") then
        local success_1, v1 = pcall(require, Weapons_1)
        if success_1 and type(v1) == "table" then
            u1 = v1
        end
    end
    return u1
end
tbl_upv_1.OwnsAmmo = nil
local tbl_upv_7 = {}
local u3 = 0
local function fromRegistry(a1)
    --[[
      name: fromRegistry
      line: 115
      upvalues:
        getRegistry (copy, index: 1)
    ]]
    local v2 = getRegistry()
    if not v2 then
        return nil
    end
    local v3 = nil
    if type(v2.Get) == "function" then
        local success_2, v3 = pcall(v2.Get, a1)
        if success_2 and type(v3) == "table" then
            return v3
        end
    end
    local v4 = (type(v2.AMMO) == "table") and (v2.AMMO[a1])
    if type(v4) == "table" and v4.unlock == true then
        local tbl_8 = {isAmmo = true, tuning = 0, details = 0, category = "ammo", kind = "Ammo", hotbar = false}
        tbl_8.id = a1
        tbl_8.name = v4.name
        tbl_8.role = v4.role or "Ammo"
        tbl_8.points = v4.points
        tbl_8.description = v4.description
        tbl_8.stats = {range = 0, rate = 0, damage = 0}
        local tbl_9 = {"Bundle", tostring(v4.perBundle) .. " arrows"}
        local tbl_10 = {"Cost", tostring(v4.points) .. " points"}
        local v5 = ((type(v4.burn) ~= "table") and "-") or (tostring(v4.burn.damage) .. " \195\151 " .. tostring(v4.burn.ticks))
        tbl_8.details = {tbl_9, tbl_10, {"Burn", v5}}
        tbl_8.tuning = {}
        return tbl_8
    end
    return nil
end
function tbl_upv_1.Get(a1)
    --[[
      name: Get
      line: 190
      upvalues:
        u3 (ref,  index: 1)
        tbl_upv_7 (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
        fromRegistry (copy, index: 4)
        tbl_upv_1 (copy, index: 5)
    ]]
    if type(a1) ~= "string" then
        return nil
    end
    if os.clock() - u3 > 10 then
        table.clear(tbl_upv_7)
        u3 = os.clock()
    end
    local v6 = tbl_upv_7[a1]
    if v6 then
        return v6
    end
    local v7 = tbl_upv_2[a1]
    local v8 = fromRegistry(a1)
    if not (v8) and not (v7) then
        return nil
    end
    local tbl_11 = {}
    if v7 then
        for key_1, value_1 in v7 do
            tbl_11[key_1] = value_1
        end
    end
    if v8 then
        for key_2, value_2 in v8 do
            tbl_11[key_2] = value_2
        end
    end
    tbl_11.id = a1
    local v9
    if type(tbl_11.name) ~= "string" then
        v9 = a1:gsub("_", " ")
    else
        v9 = tbl_11.name
    end
    tbl_11.name = v9
    v9 = ((type(tbl_11.description) ~= "string") and "") or (tbl_11.description)
    tbl_11.description = v9
    if not (tbl_upv_1.CATEGORY_NAMES[tbl_11.category]) then
        tbl_11.category = (v7 and (v7.category)) or "utility"
    end
    if type(tbl_11.points) ~= "number" then
        tbl_11.points = (v7 and (v7.points)) or 1
    end
    if tbl_11.hotbar == nil then
        tbl_11.hotbar = tbl_11.category ~= "armor"
    end
    tbl_upv_7[a1] = tbl_11
    return tbl_11
end
function tbl_upv_1.Name(a1)
    --[[
      name: Name
      line: 234
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v10 = tbl_upv_1.Get(a1)
    if v10 then
        return v10.name
    elseif type(a1) ~= "string" then
        return ""
    else
        return a1
    end
end
function tbl_upv_1.Points(a1)
    --[[
      name: Points
      line: 239
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v11 = tbl_upv_1.Get(a1)
    if v11 then
        return v11.points
    end
    return 0
end
function tbl_upv_1.IsArmor(a1)
    --[[
      name: IsArmor
      line: 244
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v12 = tbl_upv_1.Get(a1)
    local v13 = false
    local v14
    if v12 == nil then
        v14 = v13
    else
        v14 = false
        if v12.category ~= "ammo" then
            v14 = true
            if v12.category ~= "armor" then
                v14 = v12.hotbar == false
            end
        end
    end
    return v14
end
function tbl_upv_1.AmmoTypes()
    --[[
      name: AmmoTypes
      line: 250
      upvalues:
        getRegistry (copy, index: 1)
        tbl_upv_5 (copy, index: 2)
    ]]
    local v15 = getRegistry()
    local tbl_12 = {}
    if v15 then
        if type(v15.AMMO) ~= "table" then
            for _, value_3 in tbl_upv_5 do
                table.insert(tbl_12, value_3)
            end
        else
            for key_3, value_4 in v15.AMMO do
                if type(value_4) == "table" then
                    local v16 = tbl_upv_5[key_3]
                    local tbl_13 = {description = 0, optional = 0, name = 0, as = 0, points = 0, order = 0, perBundle = 0}
                    tbl_13.id = key_3
                    tbl_13.name = value_4.name or ((v16 and (v16.name)) or key_3)
                    tbl_13.perBundle = value_4.perBundle or (value_4.count or (value_4.amount or ((v16 and (v16.perBundle)) or 10)))
                    tbl_13.points = value_4.points or (value_4.cost or ((v16 and (v16.points)) or 1))
                    tbl_13.order = value_4.order or ((v16 and (v16.order)) or 9)
                    tbl_13.as = value_4.as
                    tbl_13.optional = value_4.as ~= nil
                    tbl_13.description = value_4.description
                    table.insert(tbl_12, tbl_13)
                end
            end
        end
    else
        for _, value_3 in tbl_upv_5 do
            table.insert(tbl_12, value_3)
        end
    end
    table.sort(
        tbl_12,
        function(a1, a2)
            --[[
              line: 275
            ]]
            return a1.order < a2.order
        end
    )
    return tbl_12
end
function tbl_upv_1.AmmoDef(a1)
    --[[
      name: AmmoDef
      line: 281
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    for _, value_5 in tbl_upv_1.AmmoTypes() do
        if value_5.id ~= a1 then
            continue
        end
        return value_5
    end
    return nil
end
function tbl_upv_1.MaxAmmoBundles()
    --[[
      name: MaxAmmoBundles
      line: 290
      upvalues:
        getRegistry (copy, index: 1)
    ]]
    local v17 = getRegistry()
    if v17 and type(v17.MAX_AMMO_BUNDLES) == "number" then
        return v17.MAX_AMMO_BUNDLES
    end
    return 3
end
function tbl_upv_1.AmmoOf(a1)
    --[[
      name: AmmoOf
      line: 296
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_6 (copy, index: 2)
    ]]
    local v18 = tbl_upv_1.Get(a1)
    if not v18 then
        return nil
    end
    local v19 = v18.ammoType or (v18.ammo or ((type(v18.tuning) == "table") and (v18.tuning.ammoType or (v18.tuning.ammo))))
    if type(v19) == "string" and v19 ~= "" then
        return v19
    end
    return tbl_upv_6[v18.id]
end
function tbl_upv_1.AmmoNeeded(a1)
    --[[
      name: AmmoNeeded
      line: 310
      upvalues:
        getRegistry (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local tbl_14 = {}
    local v20
    if type(a1) == "table" and type(a1.items) == "table" then
        v20 = a1.items
    else
        v20 = {}
    end
    local v21 = getRegistry()
    for _, value_6 in v20 do
        local v22 = tbl_upv_1.AmmoOf(value_6)
        if not (v22) then
            continue
        end
        tbl_14[v22] = true
        if not (v21) or type(v21.AltAmmo) ~= "function" then
            continue
        end
        for v24, value_7 in v21.AltAmmo(v22) do
            local v23 = (type(v21.AMMO) == "table") and (v21.AMMO[value_7])
            local OwnsAmmo_1 = tbl_upv_1.OwnsAmmo
            if type(v23) ~= "table" or v23.unlock ~= true or not (OwnsAmmo_1) or OwnsAmmo_1(value_7) then
                tbl_14[value_7] = true
            end
        end
    end
    return tbl_14
end
function tbl_upv_1.Budget()
    --[[
      name: Budget
      line: 333
      upvalues:
        getRegistry (copy, index: 1)
    ]]
    local v24 = getRegistry()
    if v24 and type(v24.BUDGET) == "number" then
        return v24.BUDGET
    end
    return 12
end
function tbl_upv_1.MaxItems()
    --[[
      name: MaxItems
      line: 338
      upvalues:
        getRegistry (copy, index: 1)
    ]]
    local v25 = getRegistry()
    if v25 and type(v25.MAX_ITEMS) == "number" then
        return v25.MAX_ITEMS
    end
    return 6
end
local function allIds()
    --[[
      name: allIds
      line: 154
      upvalues:
        getRegistry (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
    ]]
    local tbl_upv_15 = {}
    local tbl_upv_16 = {}
    local v26 = getRegistry()
    if v26 then
        local v27 = nil
        if type(v26.All) == "function" then
            local success_3, v27 = pcall(v26.All)
            if success_3 and type(v27) == "table" then
                for _, value_8 in v27 do
                    if type(value_8) ~= "table" then
                        continue
                    end
                    local id_1 = value_8.id
                    if type(id_1) ~= "string" then
                        continue
                    end
                    if not (tbl_upv_15[id_1]) then
                        tbl_upv_15[id_1] = true
                        table.insert(tbl_upv_16, id_1)
                    end
                end
            end
        end
    end
    if v26 and type(v26.UnlockAmmo) == "function" then
        for _, value_9 in v26.UnlockAmmo() do
            if type(value_9) ~= "string" then
                continue
            end
            if not (tbl_upv_15[value_9]) then
                tbl_upv_15[value_9] = true
                table.insert(tbl_upv_16, value_9)
            end
        end
    end
    local function add_1(a1)
        --[[
          name: add
          line: 157
          upvalues:
            tbl_upv_15 (copy, index: 1)
            tbl_upv_16 (copy, index: 2)
        ]]
        if type(a1) ~= "string" or (tbl_upv_15[a1]) then
            return
        end
        tbl_upv_15[a1] = true
        table.insert(tbl_upv_16, a1)
    end
    for key_4 in tbl_upv_2 do
        if type(key_4) ~= "string" then
            continue
        end
        if not (tbl_upv_15[key_4]) then
            tbl_upv_15[key_4] = true
            table.insert(tbl_upv_16, key_4)
        end
    end
    return tbl_upv_16
end
function tbl_upv_1.ByCategory(a1)
    --[[
      name: ByCategory
      line: 344
      upvalues:
        allIds (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local tbl_17 = {}
    for _, value_10 in allIds() do
        local v28 = tbl_upv_1.Get(value_10)
        if not (v28) then
            continue
        end
        if v28.category == a1 then
            table.insert(tbl_17, v28)
        end
    end
    table.sort(
        tbl_17,
        function(a2, a3)
            --[[
              line: 352
            ]]
            if a2.points == a3.points then
                return a2.name < a3.name
            end
            return a2.points < a3.points
        end
    )
    return tbl_17
end
function tbl_upv_1.Normalize(a1)
    --[[
      name: Normalize
      line: 362
    ]]
    local tbl_18 = {armor = false}
    tbl_18.items = {}
    tbl_18.ammo = {}
    if type(a1) == "table" then
        if type(a1.ammo) == "table" then
            for key_5, value_11 in a1.ammo do
                if type(key_5) ~= "string" or type(value_11) ~= "number" then
                    continue
                end
                if value_11 > 0 then
                    tbl_18.ammo[key_5] = math.floor(value_11)
                end
            end
        end
        if type(a1.items) ~= "table" then
            for _, value_12 in {"primary", "secondary", "melee", "utility"} do
                if type(a1[value_12]) == "string" then
                    table.insert(tbl_18.items, a1[value_12])
                end
            end
        else
            for _, value_13 in a1.items do
                if type(value_13) == "string" then
                    table.insert(tbl_18.items, value_13)
                end
            end
            if type(a1.armor) == "string" and a1.armor ~= "" then
                tbl_18.armor = a1.armor
            end
        end
    end
    return tbl_18
end
function tbl_upv_1.Cost(a1)
    --[[
      name: Cost
      line: 393
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v29 = tbl_upv_1.Normalize(a1)
    local v30 = 0
    for _, value_14 in v29.items do
        v30 = v30 + tbl_upv_1.Points(value_14)
    end
    v30 = ((v29.armor) and (v30 + tbl_upv_1.Points(v29.armor))) or v30
    for key_6, value_15 in v29.ammo do
        local v31 = tbl_upv_1.AmmoDef(key_6)
        v30 = (v31 and (v30 + v31.points * value_15)) or v30
    end
    return v30
end
function tbl_upv_1.Validate(a1)
    --[[
      name: Validate
      line: 413
      upvalues:
        getRegistry (copy, index: 1)
    ]]
    local v32 = getRegistry()
    if v32 and type(v32.Validate) == "function" then
        local v33 = nil
        if type(v32.AMMO) == "table" then
            local success_4, v34, v35, v33 = pcall(v32.Validate, dropUnusedAmmo.Normalize(a1))
            if success_4 and type(v33) == "table" then
                return v34 == true, v35, dropUnusedAmmo.Normalize(v33)
            end
        end
    end
    local v36 = dropUnusedAmmo.Normalize(a1)
    local tbl_upv_19 = {armor = false}
    tbl_upv_19.items = {}
    tbl_upv_19.ammo = {}
    local tbl_20 = {}
    for _, value_16 in v36.items do
        if not (dropUnusedAmmo.Get(value_16)) or tbl_20[value_16] then
            continue
        end
        tbl_20[value_16] = true
        if dropUnusedAmmo.IsArmor(value_16) then
            if not (tbl_upv_19.armor) then
                tbl_upv_19.armor = value_16
            end
        elseif #tbl_upv_19.items < dropUnusedAmmo.MaxItems() then
            table.insert(tbl_upv_19.items, value_16)
        end
    end
    if v36.armor and dropUnusedAmmo.IsArmor(v36.armor) then
        tbl_upv_19.armor = v36.armor
    end
    for key_7, value_17 in v36.ammo do
        if dropUnusedAmmo.AmmoDef(key_7) then
            tbl_upv_19.ammo[key_7] = math.clamp(value_17, 0, dropUnusedAmmo.MaxAmmoBundles())
        end
    end
    local v37 = nil
    local function dropUnusedAmmo()
        --[[
          name: dropUnusedAmmo
          line: 447
          upvalues:
            tbl_upv_19 (copy, index: 2)
        ]]
        local v38 = tbl_upv_1.AmmoNeeded(tbl_upv_19)
        for key_8 in tbl_upv_19.ammo do
            if not (v38[key_8]) then
                tbl_upv_19.ammo[key_8] = nil
            end
        end
    end
    local v39 = dropUnusedAmmo.Cost(tbl_upv_19)
    if dropUnusedAmmo.Budget() < v39 then
        v39 = dropUnusedAmmo.AmmoNeeded(tbl_upv_19)
        for key_9 in tbl_upv_19.ammo do
            if not (v39[key_9]) then
                tbl_upv_19.ammo[key_9] = nil
            end
        end
    end
    local v34 = v37
    while true do
        v39 = dropUnusedAmmo.Cost(tbl_upv_19)
        if not (dropUnusedAmmo.Budget() < v39) or not (#tbl_upv_19.items > 0) then
            break
        end
        table.remove(tbl_upv_19.items)
        v39 = dropUnusedAmmo.AmmoNeeded(tbl_upv_19)
        for key_10 in tbl_upv_19.ammo do
            if not (v39[key_10]) then
                tbl_upv_19.ammo[key_10] = nil
            end
        end
        v34 = "Over budget"
    end
    v39 = dropUnusedAmmo.Cost(tbl_upv_19)
    if dropUnusedAmmo.Budget() < v39 then
        tbl_upv_19.armor = false
        v34 = "Over budget"
    end
    if v34 == nil then
        v39 = true
    else
        v39 = false
    end
    return v39, v34, tbl_upv_19
end
function tbl_upv_1.DefaultLoadout()
    --[[
      name: DefaultLoadout
      line: 470
      upvalues:
        getRegistry (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        tbl_upv_4 (copy, index: 3)
    ]]
    local v40 = getRegistry()
    if v40 and type(v40.DEFAULT_LOADOUT) == "table" then
        return tbl_upv_1.Normalize(v40.DEFAULT_LOADOUT)
    end
    return tbl_upv_1.Normalize(tbl_upv_4)
end
tbl_upv_1.FILTERS = {{id = "all", name = "ALL"}, {id = "weapons", name = "WEAPONS", cats = {gun = true, bow = true, melee = true}}, {id = "utility", name = "UTILITY", cats = {throwable = true, utility = true}}, {id = "healing", name = "HEALING", cats = {healing = true}}, {id = "armor", name = "ARMOR", cats = {armor = true}}}
function tbl_upv_1.AllItems()
    --[[
      name: AllItems
      line: 488
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local tbl_21 = {}
    for _, value_18 in tbl_upv_1.CATEGORIES do
        for v1, value_19 in tbl_upv_1.ByCategory(value_18) do
            table.insert(tbl_21, value_19)
        end
    end
    return tbl_21
end
function tbl_upv_1.ArmorStats(a1)
    --[[
      name: ArmorStats
      line: 499
    ]]
    local v41
    if a1 then
        v41 = a1.tuning
        if not (v41) then
            v41 = a1.stats
            local v44
            if not v41 then
                v41 = {} or {}
            end
        end
    else
        v41 = {}
    end
    local v42 = v41.armor or (v41.maxArmor or (a1.armor or 0))
    local v43 = v41.speedMult or (v41.moveSpeedMult or (v41.speed or (a1.speed or 1)))
    if type(v42) ~= "number" then
        v42 = 0
    end
    if type(v43) ~= "number" then
        v43 = 1
    end
    return v42, v43
end
local u4 = nil
local u5 = -math.huge
local function combat()
    --[[
      name: combat
      line: 518
      upvalues:
        u4 (ref,  index: 1)
        u5 (ref,  index: 2)
        ReplicatedStorage_upv_1 (copy, index: 3)
    ]]
    if not (u4) and not (os.clock() - u5 < 5) then
        u5 = os.clock()
        local Combat_1 = ReplicatedStorage_upv_1.Shared:FindFirstChild("Combat")
        if Combat_1 and Combat_1:IsA("ModuleScript") then
            local success_5, v44 = pcall(require, Combat_1)
            if success_5 and type(v44) == "table" and type(v44.RunSpeed) == "function" then
                u4 = v44
            end
        end
        return u4
    end
    return u4
end
local u6 = table.freeze({})
function tbl_upv_1.RunSpeed(a1)
    --[[
      name: RunSpeed
      line: 533
      upvalues:
        u6 (copy, index: 1)
        combat (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    if a1 and not (a1.isAmmo) and a1.category ~= "ammo" then
        local v45 = combat()
        if a1.category ~= "armor" then
            if not v45 then
                return nil, u6
            end
            local success_6, v46, v47 = pcall(v45.RunSpeed, a1.id)
            if success_6 and type(v46) == "number" then
                return v46, v47
            end
            return nil, u6
        elseif v45 then
            return v45.ArmorSpeed(a1.id), u6
        else
            local _, v48 = tbl_upv_1.ArmorStats(a1)
            return v48, u6
        end
    end
    return nil, u6
end
function tbl_upv_1.SpeedText(a1)
    --[[
      name: SpeedText
      line: 556
    ]]
    local v49 = math.floor((math.abs(a1 - 1) * 100) + 0.5)
    if v49 ~= 0 then
        return (((a1 > 1) and "+") or "\226\136\146") .. v49 .. "%"
    end
    return "Normal"
end
local function speedFrac(a1)
    --[[
      name: speedFrac
      line: 565
    ]]
    return (math.clamp((a1 - 0.8) / 0.4, 0.05, 1))
end
function tbl_upv_1.SpeedNote(a1)
    --[[
      name: SpeedNote
      line: 571
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local _, v50 = tbl_upv_1.RunSpeed(a1)
    if #v50 == 0 then
        return ""
    end
    local move_1 = tbl_upv_1.SpeedText(v50[1].mult) .. " run speed while " .. v50[1].move
    local v51 = ((v50[2]) and (move_1 .. ", " .. tbl_upv_1.SpeedText(v50[2].mult) .. " while " .. v50[2].move)) or move_1
    return v51 .. "."
end
function tbl_upv_1.Bars(a1)
    --[[
      name: Bars
      line: 586
      upvalues:
        tbl_upv_1 (copy, index: 1)
        getRegistry (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
        tbl_upv_3 (copy, index: 4)
    ]]
    local tbl_22 = {}
    if not a1 then
        return tbl_22
    end
    local v52 = tbl_upv_1.RunSpeed(a1)
    local v53
    if v52 then
        v53 = {label = "RUN SPEED"}
        v53.frac = math.clamp((v52 - 0.8) / 0.4, 0.05, 1)
        v53.value = tbl_upv_1.SpeedText(v52)
    else
        v53 = nil
    end
    if a1.category ~= "armor" then
        local v54 = getRegistry()
        if type(a1.stats) == "table" and v54 and type(v54.STAT_BARS) == "table" then
            for _, value_20 in v54.STAT_BARS do
                local v55 = (type(value_20) == "table") and (a1.stats[value_20.key])
                if type(v55) == "number" then
                    local tbl_23 = {frac = 0, label = 0}
                    tbl_23.label = string.upper(tostring(value_20.label or (value_20.key)))
                    tbl_23.frac = math.clamp(v55 / 10, 0, 1)
                    table.insert(tbl_22, tbl_23)
                end
            end
            tbl_22 = ((#tbl_22 < 2) and {}) or tbl_22
        end
        local v56 = nil
        if #tbl_22 == 0 then
            local v57 = tbl_upv_2[a1.id]
            v56 = a1.bars or (v57 and (v57.bars))
            if type(v56) == "table" then
                for key_11, value_21 in v56 do
                    if type(value_21) ~= "number" then
                        continue
                    end
                    if tbl_upv_3[key_11] then
                        table.insert(tbl_22, {label = tbl_upv_3[key_11], frac = math.clamp(value_21, 0, 1)})
                    end
                end
            end
        end
        if v53 and #tbl_22 > 0 then
            table.insert(tbl_22, v53)
        end
    else
        table.insert(tbl_22, {label = "ARMOR", frac = math.clamp(tbl_upv_1.ArmorStats(a1) / 100, 0.05, 1)})
        if v53 then
            table.insert(tbl_22, v53)
        end
        local v58 = (type(a1.tuning) == "table") and (a1.tuning.rangedReduction)
        if type(v58) == "number" and v58 > 0 then
            table.insert(tbl_22, {label = "VS RANGED", frac = math.clamp(v58 / 0.4, 0.05, 1)})
        end
    end
    return tbl_22
end
return tbl_upv_1