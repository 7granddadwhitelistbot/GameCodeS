local Weapons
local v2 = {}
local success, Weapons2 = pcall(
    function()
        --[[
          line: 30
        ]]
        return (require(script.Parent:WaitForChild("Weapons")))
    end
)

if success then
    Weapons = Weapons2
else
    Weapons = nil
end

local success2, Config = pcall(
    function()
        --[[
          line: 40
        ]]
        return (require(script.Parent:WaitForChild("Config")))
    end
)
local everythingOwned = success2 and type(Config) == "table" and game.PlaceId == Config.STAGING_PLACE_ID
v2.EVERYTHING_OWNED = everythingOwned
v2.STARTERS = table.freeze({short_bow = true, bronze_sword = true, throwing_knives = true, bandage = true, smoke_bomb = true, sling = true, war_club = true, hide_armor = true})
v2.DEFAULT = table.freeze({size = "medium"})
v2.ITEMS = table.freeze(
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
v2.DROPS = table.freeze({table.freeze({key = "drop_golden", kind = "golden", count = 1}), table.freeze({key = "drop_golden5", kind = "golden", count = 5})})
v2.FIRST_DROP = table.freeze({key = "drop_golden_first", kind = "golden", count = 1, duration = 172800, minMatches = 1})
v2.RESTORE_MIN_STREAK = 2
v2.RESTORE_WINDOW = 86400
v2.RESTORE = table.freeze({table.freeze({key = "streak_s", max = 4}), table.freeze({key = "streak_m", max = 9}), table.freeze({key = "streak_l", max = 1e+09})})

function v2.IsAmmo(key)
    --[[
      name: IsAmmo
      line: 133
      upvalues:
        Weapons (ref, index: 1)
    ]]
    local v9 = type(key) == "string" and Weapons and type(Weapons.AMMO) == "table" and Weapons.AMMO[key]
    return type(v9) == "table" and v9.unlock == true
end

local function known(a11)
    --[[
      name: known
      line: 138
      upvalues:
        Weapons (ref,  index: 1)
        v2 (copy, index: 2)
    ]]
    if type(a11) ~= "string" then
        return false
    end
    if Weapons and type(Weapons.Get) == "function" then
        return Weapons.Get(a11) ~= nil or v2.IsAmmo(a11)
    end

    return v2.STARTERS[a11] == true or v2.ITEMS[a11] ~= nil
end

v2.IsKnown = known

function v2.IsStarter(starterKey)
    --[[
      name: IsStarter
      line: 149
      upvalues:
        v2 (copy, index: 1)
    ]]
    return type(starterKey) == "string" and v2.STARTERS[starterKey] == true
end

local function row(itemKey)
    --[[
      name: row
      line: 153
      upvalues:
        v2 (copy, index: 1)
    ]]
    if v2.IsStarter(itemKey) then
        return nil
    end

    return type(itemKey) == "string" and v2.ITEMS[itemKey] or v2.DEFAULT
end

function v2.SizeOf(itemKey)
    --[[
      name: SizeOf
      line: 161
      upvalues:
        v2 (copy, index: 1)
    ]]
    local v16

    if v2.IsStarter(itemKey) then
        v16 = nil
    else
        v16 = type(itemKey) == "string" and v2.ITEMS[itemKey] or v2.DEFAULT
    end

    if v16 then
        return v16.size
    end

    return "starter"
end

function v2.Owns(a17, starterKey)
    --[[
      name: Owns
      line: 167
      upvalues:
        v2 (copy, index: 1)
        everythingOwned (copy, index: 2)
        known (copy, index: 3)
        Weapons (ref,  index: 4)
    ]]
    if type(starterKey) ~= "string" then
        return false
    end
    if v2.STARTERS[starterKey] then
        return true
    end
    if everythingOwned and known(starterKey) then
        return true
    end
    if Weapons and type(Weapons.IsStagingOnly) == "function" and Weapons.IsStagingOnly(starterKey) then
        return true
    end

    local v19 = false

    if type(a17) == "table" then
        v19 = a17[starterKey]
    end

    return type(v19) == "table" and type(v19.level) == "number" and 1 <= v19.level
end

function v2.AllIds()
    --[[
      name: AllIds
      line: 186
      upvalues:
        Weapons (ref,  index: 1)
        v2 (copy, index: 2)
    ]]
    local v20 = {}

    if Weapons and type(Weapons.All) == "function" then
        for _, v22 in Weapons.All() do
            table.insert(v20, v22.id)
        end

        if type(Weapons.UnlockAmmo) ~= "function" then
            return v20
        end

        for _, v24 in Weapons.UnlockAmmo() do
            table.insert(v20, v24)
        end

        return v20
    end

    for v25 in v2.STARTERS do
        table.insert(v20, v25)
    end

    for v26 in v2.ITEMS do
        table.insert(v20, v26)
    end

    table.sort(v20)

    return v20
end

function v2.FirstLocked(a27, a28)
    --[[
      name: FirstLocked
      line: 209
      upvalues:
        v2 (copy, index: 1)
    ]]
    if type(a28) ~= "table" then
        return nil
    end

    if type(a28.items) == "table" then
        local item

        for itemKey = 1, 16 do
            item = a28.items[itemKey]

            if item == nil then
                break
            end

            if type(item) == "string" then
                if not v2.Owns(a27, item) then
                    return item
                end
            end
        end
    end

    if type(a28.armor) == "string" and not v2.Owns(a27, a28.armor) then
        return a28.armor
    end

    if type(a28.ammo) == "table" then
        for v31, v32 in a28.ammo do
            if type(v32) == "number" and 1 <= v32 and v2.IsAmmo(v31) and not v2.Owns(a27, v31) then
                return v31
            end
        end
    end

    return nil
end

function v2.FilterLoadout(a33, a34)
    --[[
      name: FilterLoadout
      line: 241
      upvalues:
        v2 (copy, index: 1)
        Weapons (ref,  index: 2)
    ]]
    local armor
    local items = {}

    if type(a34) == "table" and type(a34.items) == "table" then
        for itemKey = 1, 16 do
            local item = a34.items[itemKey]
            if item == nil then
                break
            end

            if type(item) == "string" and v2.Owns(a33, item) then
                table.insert(items, item)
            end
        end
    end

    if type(a34) ~= "table" or type(a34.armor) ~= "string" or not v2.Owns(a33, a34.armor) then
        armor = false
    else
        armor = a34.armor
    end

    local ammo = nil

    if type(a34) == "table" and type(a34.ammo) == "table" then
        ammo = {}
        local v40 = nil

        if Weapons and type(Weapons.AmmoNeeded) == "function" then
            v40 = Weapons.AmmoNeeded({items = items})
        end

        for v41, v42 in a34.ammo do
            if type(v41) == "string" then
                if v40 ~= nil and not v40[v41] then
                    continue
                end

                if not v2.IsAmmo(v41) or v2.Owns(a33, v41) then
                    ammo[v41] = v42
                end
            end
        end
    end

    return {items = items, armor = armor, ammo = ammo}
end

function v2.RestoreTier(a43)
    --[[
      name: RestoreTier
      line: 271
      upvalues:
        v2 (copy, index: 1)
    ]]
    for _, v45 in v2.RESTORE do
        if a43 <= v45.max then
            return v45
        end
    end

    return v2.RESTORE[#v2.RESTORE]
end

function v2.DropProduct(a46)
    --[[
      name: DropProduct
      line: 280
      upvalues:
        v2 (copy, index: 1)
    ]]
    if a46 == v2.FIRST_DROP.key then
        return v2.FIRST_DROP
    end

    for _, drop in v2.DROPS do
        if drop.key == a46 then
            return drop
        end
    end

    return nil
end

function v2.ProductKey(a49, a50)
    --[[
      name: ProductKey
      line: 292
    ]]
    if a49 == "unlock" then
        return "unlock_" .. a50
    end

    return a50
end

function v2.Cost(a51)
    --[[
      name: Cost
      line: 297
    ]]
    local success, Shards = pcall(
        function()
            --[[
              line: 298
            ]]
            return (require(script.Parent:WaitForChild("Shards")))
        end
    )
    if success then
        return (Shards.UnlockCost(a51))
    end

    return 0
end

return v2