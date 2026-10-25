local tbl_upv_1 = {}
local success_1, u1 = pcall(
    function()
        --[[
          line: 30
        ]]
        return (require(script.Parent:WaitForChild("Weapons")))
    end
)
if not (success_1) then
    u1 = nil
end
local success_2, v1 = pcall(
    function()
        --[[
          line: 40
        ]]
        return (require(script.Parent:WaitForChild("Config")))
    end
)
local u2 = success_2 and ((type(v1) == "table") and (game.PlaceId == v1.STAGING_PLACE_ID))
tbl_upv_1.EVERYTHING_OWNED = u2
tbl_upv_1.STARTERS = table.freeze({throwing_knives = true, sling = true, bandage = true, war_club = true, hide_armor = true, short_bow = true, bronze_sword = true, smoke_bomb = true})
tbl_upv_1.DEFAULT = table.freeze({size = "medium"})
tbl_upv_1.ITEMS = table.freeze(
    {
        obsidian_dagger = {size = "small"},
        bear_trap = {size = "small"},
        healing_herbs = {size = "small"},
        javelins = {size = "small"},
        crossbow = {size = "medium"},
        spear = {size = "medium"},
        battle_axe = {size = "medium"},
        flintlock = {size = "medium"},
        blunderbuss = {size = "medium"},
        fire_bomb = {size = "medium"},
        bone_armor = {size = "medium"},
        longbow = {size = "large"},
        musket = {size = "large"},
        healing_tonic = {size = "large"},
        bronze_armor = {size = "large"},
        bolas = {size = "small"},
        harpoon = {size = "large"},
        healing_flask = {size = "medium"},
        war_horn = {size = "small"},
        shield = {size = "large"},
        palisade = {size = "medium"},
        chakram = {size = "medium"},
        fire_arrows = {size = "small"},
        caltrops = {size = "small"},
        gauntlets = {size = "medium"},
        scythe = {size = "large"},
        beehive = {size = "small"},
        twin_hatchets = {size = "medium"},
        katana = {size = "large"}
    }
)
tbl_upv_1.DROPS = table.freeze({table.freeze({kind = "golden", key = "drop_golden", count = 1}), table.freeze({kind = "golden", key = "drop_golden5", count = 5})})
tbl_upv_1.FIRST_DROP = table.freeze({minMatches = 1, key = "drop_golden_first", kind = "golden", duration = 172800, count = 1})
tbl_upv_1.RESTORE_MIN_STREAK = 2
tbl_upv_1.RESTORE_WINDOW = 86400
tbl_upv_1.RESTORE = table.freeze({table.freeze({key = "streak_s", max = 4}), table.freeze({key = "streak_m", max = 9}), table.freeze({key = "streak_l", max = 1e+09})})
function tbl_upv_1.IsAmmo(a1)
    --[[
      name: IsAmmo
      line: 133
      upvalues:
        u1 (ref, index: 1)
    ]]
    local v2 = (type(a1) == "string") and (v3 and ((type(v3.AMMO) == "table") and (v3.AMMO[a1])))
    local v4 = false
    if type(v2) == "table" then
        v4 = v2.unlock == true
    end
    return v4
end
local function known(a1)
    --[[
      name: known
      line: 138
      upvalues:
        u1 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if type(a1) ~= "string" then
        return false
    end
    if v3 and type(v3.Get) == "function" then
        local v5 = true
        if v3.Get(a1) == nil then
            v5 = tbl_upv_1.IsAmmo(a1)
        end
        return v5
    end
    local v6 = true
    if tbl_upv_1.STARTERS[a1] ~= true then
        v6 = tbl_upv_1.ITEMS[a1] ~= nil
    end
    return v6
end
tbl_upv_1.IsKnown = known
function tbl_upv_1.IsStarter(a1)
    --[[
      name: IsStarter
      line: 149
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v7 = (type(a1) == "string") and (tbl_upv_1.STARTERS[a1] == true)
    return v7
end
local function row(a1)
    --[[
      name: row
      line: 153
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if tbl_upv_1.IsStarter(a1) then
        return nil
    end
    local v8 = ((type(a1) == "string") and (tbl_upv_1.ITEMS[a1])) or (tbl_upv_1.DEFAULT)
    return v8
end
function tbl_upv_1.SizeOf(a1)
    --[[
      name: SizeOf
      line: 161
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v9 = tbl_upv_1.IsStarter(a1) or ((type(a1) == "string") and (tbl_upv_1.ITEMS[a1])) or (tbl_upv_1.DEFAULT)
    if v9 then
        return v9.size
    end
    return "starter"
end
function tbl_upv_1.Owns(a1, a2)
    --[[
      name: Owns
      line: 167
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u2 (copy, index: 2)
        known (copy, index: 3)
        u1 (ref,  index: 4)
    ]]
    if type(a2) ~= "string" then
        return false
    end
    if tbl_upv_1.STARTERS[a2] or u2 and known(a2) or v3 and type(v3.IsStagingOnly) == "function" and v3.IsStagingOnly(a2) then
        return true
    end
    local v10 = (type(a1) == "table") and (a1[a2])
    local v11 = false
    if type(v10) == "table" then
        v11 = (type(v10.level) == "number") and (v10.level >= 1)
    end
    return v11
end
function tbl_upv_1.AllIds()
    --[[
      name: AllIds
      line: 186
      upvalues:
        u1 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local tbl_2 = {}
    if v3 then
        if type(v3.All) ~= "function" then
            for key_1 in tbl_upv_1.STARTERS do
                table.insert(tbl_2, key_1)
            end
            for key_2 in tbl_upv_1.ITEMS do
                table.insert(tbl_2, key_2)
            end
            table.sort(tbl_2)
        else
            for _, value_1 in v3.All() do
                table.insert(tbl_2, value_1.id)
            end
            if type(v3.UnlockAmmo) == "function" then
                for _, value_2 in v3.UnlockAmmo() do
                    table.insert(tbl_2, value_2)
                end
            end
        end
    else
        for key_1 in tbl_upv_1.STARTERS do
            table.insert(tbl_2, key_1)
        end
        for key_2 in tbl_upv_1.ITEMS do
            table.insert(tbl_2, key_2)
        end
        table.sort(tbl_2)
    end
    return tbl_2
end
function tbl_upv_1.FirstLocked(a1, a2)
    --[[
      name: FirstLocked
      line: 209
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if type(a2) == "table" then
        if type(a2.items) == "table" then
            local v12 = nil
            for n_1 = 1, 16 do
                v12 = a2.items[n_1]
                if v12 == nil then
                    break
                end
                if type(v12) ~= "string" then
                    continue
                end
                local v13 = tbl_upv_1.Owns(a1, v12)
                if v13 then
                    continue
                end
                return v12
            end
        end
        if type(a2.armor) == "string" and not (tbl_upv_1.Owns(a1, a2.armor)) then
            return a2.armor
        end
        if type(a2.ammo) == "table" then
            for key_3, value_3 in a2.ammo do
                if type(value_3) ~= "number" or not (value_3 >= 1) or not (tbl_upv_1.IsAmmo(key_3)) or tbl_upv_1.Owns(a1, key_3) then
                    continue
                end
                return key_3
            end
        end
    end
    return nil
end
function tbl_upv_1.FilterLoadout(a1, a2)
    --[[
      name: FilterLoadout
      line: 241
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u1 (ref,  index: 2)
    ]]
    local tbl_3 = {}
    if type(a2) == "table" and type(a2.items) == "table" then
        for n_2 = 1, 16 do
            local v14 = a2.items[n_2]
            if v14 == nil then
                break
            end
            if type(v14) ~= "string" then
                continue
            end
            local v15 = tbl_upv_1.Owns(a1, v14)
            if v15 then
                table.insert(tbl_3, v14)
            end
        end
    end
    local v16
    if type(a2) == "table" and type(a2.armor) == "string" and tbl_upv_1.Owns(a1, a2.armor) then
        v16 = a2.armor
    else
        v16 = false
    end
    local v17 = nil
    if type(a2) == "table" and type(a2.ammo) == "table" then
        v17 = {}
        local v18 = nil
        if v3 and type(v3.AmmoNeeded) == "function" then
            local v19 = v3.AmmoNeeded({items = tbl_3})
            v18 = v19
        end
        for key_4, value_4 in a2.ammo do
            if type(key_4) ~= "string" then
                continue
            end
            if (v18 == nil or v18[key_4]) and (not (tbl_upv_1.IsAmmo(key_4)) or tbl_upv_1.Owns(a1, key_4)) then
                v17[key_4] = value_4
            end
        end
    end
    local tbl_4 = {}
    tbl_4.items = tbl_3
    tbl_4.armor = v16
    tbl_4.ammo = v17
    return tbl_4
end
function tbl_upv_1.RestoreTier(a1)
    --[[
      name: RestoreTier
      line: 271
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    for _, value_5 in tbl_upv_1.RESTORE do
        if not (a1 <= value_5.max) then
            continue
        end
        return value_5
    end
    return tbl_upv_1.RESTORE[#tbl_upv_1.RESTORE]
end
function tbl_upv_1.DropProduct(a1)
    --[[
      name: DropProduct
      line: 280
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if a1 ~= tbl_upv_1.FIRST_DROP.key then
        for _, value_6 in tbl_upv_1.DROPS do
            if value_6.key ~= a1 then
                continue
            end
            return value_6
        end
        return nil
    end
    return tbl_upv_1.FIRST_DROP
end
function tbl_upv_1.ProductKey(a1, a2)
    --[[
      name: ProductKey
      line: 292
    ]]
    if a1 ~= "unlock" then
        return a2
    end
    return "unlock_" .. a2
end
function tbl_upv_1.Cost(a1)
    --[[
      name: Cost
      line: 297
    ]]
    local success_3, v20 = pcall(
        function()
            --[[
              line: 298
            ]]
            return (require(script.Parent:WaitForChild("Shards")))
        end
    )
    if success_3 then
        return (v20.UnlockCost(a1))
    end
    return 0
end
return tbl_upv_1