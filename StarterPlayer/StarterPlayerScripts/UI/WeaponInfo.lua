local function ArmorStats(options)
    --[[
      name: ArmorStats
      line: 499
    ]]
    local v3
    local v4
    local v5 = false

    if options then
        v3 = options.tuning

        if not v3 then
            v3 = options.stats

            if not v3 then
                v4 = {}

                if v4 then
                    v3 = v4
                else
                    v5 = true
                end
            end
        end
    else
        v5 = true
    end

    if v5 then
        v3 = {}
    end

    local v6 = v3.armor or v3.maxArmor or options.armor or 0
    local v7 = v3.speedMult or v3.moveSpeedMult or v3.speed or options.speed or 1

    if type(v6) ~= "number" then
        v6 = 0
    end

    if type(v7) ~= "number" then
        v7 = 1
    end

    return v6, v7
end

local function Normalize(a9)
    --[[
      name: Normalize
      line: 362
    ]]
    local v10 = {armor = false, items = {}, ammo = {}}

    if type(a9) ~= "table" then
        return v10
    end

    if type(a9.ammo) == "table" then
        for v11, v12 in a9.ammo do
            if type(v11) == "string" then
                if type(v12) == "number" and 0 < v12 then
                    v10.ammo[v11] = math.floor(v12)
                end
            end
        end
    end

    if type(a9.items) ~= "table" then
        for _, v14 in {"primary", "secondary", "melee", "utility"} do
            if type(a9[v14]) == "string" then
                table.insert(v10.items, a9[v14])
            end
        end
    else
        for _, item in a9.items do
            if type(item) == "string" then
                table.insert(v10.items, item)
            end
        end

        if type(a9.armor) == "string" then
            if a9.armor ~= "" then
                v10.armor = a9.armor
                return v10
            end
        end
    end

    return v10
end

local replicatedStorage = game:GetService("ReplicatedStorage")
local v18 = {
    CATEGORIES = {"bow", "gun", "melee", "throwable", "utility", "healing", "armor", "ammo"},
    CATEGORY_NAMES = {bow = "BOWS", gun = "GUNS", melee = "MELEE", throwable = "THROWABLES", utility = "UTILITY", healing = "HEALING", armor = "ARMOR", ammo = "AMMO"},
    CATEGORY_SINGULAR = {bow = "BOW", gun = "GUN", melee = "MELEE", throwable = "THROWABLE", utility = "UTILITY", healing = "HEALING", armor = "ARMOR", ammo = "AMMO"},
    CATEGORY_COLORS = {bow = Color3.fromRGB(232, 170, 44), gun = Color3.fromRGB(128, 150, 176), melee = Color3.fromRGB(214, 72, 52), throwable = Color3.fromRGB(44, 176, 172), utility = Color3.fromRGB(156, 112, 206), healing = Color3.fromRGB(110, 196, 86), armor = Color3.fromRGB(196, 148, 92), ammo = Color3.fromRGB(240, 96, 48)}
}
local v19 = {
    short_bow = {name = "Wood Bow", category = "bow", kind = "Bow", points = 3, description = "Fast draw, arrows drop over distance. Reliable at any range.", bars = {0.45, 0.8, 0.7, 0.8}},
    longbow = {name = "Headhunter", category = "bow", kind = "Bow", points = 5, description = "Slow, heavy draw with a zoom. A full-draw headshot kills.", bars = {0.85, 0.3, 1, 0.45}},
    crossbow = {name = "Crossbow", category = "bow", kind = "Crossbow", points = 4, description = "Instant bolt, no draw. Reload after every shot.", bars = {0.7, 0.4, 0.85, 0.75}},
    musket = {name = "Musket", category = "gun", kind = "Musket", points = 5, description = "Thunderous single shot with a smoke puff. Long reload.", bars = {1, 0.15, 0.95, 0.5}},
    blunderbuss = {name = "Blunderbuss", category = "gun", kind = "Blunderbuss", points = 4, description = "A spray of pellets. Devastating up close, useless far away.", bars = {0.9, 0.3, 0.25, 0.7}},
    flintlock = {name = "Flintlock", category = "gun", kind = "Pistol", points = 3, description = "One-shot pistol. Finish a wounded foe, then reload.", bars = {0.7, 0.45, 0.65, 0.9}},
    bronze_sword = {name = "Iron Sword", category = "melee", kind = "Sword", points = 3, description = "Balanced three-hit combo. Hold to block.", bars = {0.6, 0.7, 0.3, 0.8}},
    battle_axe = {name = "Battle Axe", category = "melee", kind = "Axe", points = 4, description = "Heavy swings and a charged overhead that splits guards.", bars = {0.9, 0.35, 0.3, 0.7}},
    spear = {name = "Spear", category = "melee", kind = "Spear", points = 4, description = "Longest reach. Charge a lunge to close the gap.", bars = {0.65, 0.5, 0.5, 0.75}},
    war_club = {name = "Hammer", category = "melee", kind = "Club", points = 3, description = "Knocks foes back and staggers them.", bars = {0.75, 0.45, 0.3, 0.7}},
    obsidian_dagger = {name = "Diamond Dagger", category = "melee", kind = "Dagger", points = 2, description = "Lightning-fast stabs with a backstab bonus.", bars = {0.35, 1, 0.2, 1}},
    throwing_knives = {name = "Throwing Knives", category = "throwable", kind = "Knives", points = 2, description = "Fast, flat throws. Five knives per round.", bars = {0.35, 0.95, 0.55, 0.9}},
    javelins = {name = "Javelins", category = "throwable", kind = "Javelin", points = 2, description = "Heavy throws that hit hard. Three per round.", bars = {0.8, 0.4, 0.65, 0.7}},
    sling = {name = "Sling", category = "throwable", kind = "Sling", points = 1, description = "Lobbed stones that arc over cover. Twelve per round.", bars = {0.35, 0.8, 0.7, 0.9}},
    fire_bomb = {name = "Fireball", category = "utility", kind = "Bomb", points = 2, description = "Shatters into a pool of flame that burns anyone inside.", bars = {0.6, 0.4, 0.55, 0.8}},
    smoke_bomb = {name = "Smoke Bomb", category = "utility", kind = "Bomb", points = 1, description = "A thick cloud that blocks sight. Reposition, escape, revive a push.", bars = {0, 0.5, 0.55, 1}},
    bear_trap = {name = "Snap Trap", category = "utility", kind = "Trap", points = 1, description = "Set it in a chokepoint. Roots the first enemy who steps in.", bars = {0.45, 0.3, 0.15, 0.8}},
    bandage = {name = "Bandage", category = "healing", kind = "Bandage", points = 1, description = "A quick heal at once. Two per round.", bars = {0, 0.8, 0, 0.8}},
    healing_herbs = {name = "Apple", category = "healing", kind = "Herbs", points = 2, description = "Chew to heal over a few seconds. Stay out of sight.", bars = {0, 0.5, 0, 0.7}},
    healing_tonic = {name = "Golden Apple", category = "healing", kind = "Tonic", points = 3, description = "Heals to full at once, plus golden armor for a few seconds.", bars = {0, 0.3, 0, 0.6}},
    hide_armor = {name = "Leather Armor", category = "armor", hotbar = false, points = 2, armor = 25, speed = 0.97, description = "Light armor: soaks a hit or two, barely slows you."},
    bone_armor = {name = "Iron Armor", category = "armor", hotbar = false, points = 4, armor = 50, speed = 0.93, description = "Medium armor: a real second health bar, a little slower."},
    bronze_armor = {name = "Diamond Armor", category = "armor", hotbar = false, points = 6, armor = 80, speed = 0.88, description = "Heavy armor: shrug off a volley, but you'll feel the weight."}
}
local v20 = {"DAMAGE", "SPEED", "RANGE"}
local v21 = {armor = "hide_armor", items = {"bronze_sword", "short_bow", "bandage"}, ammo = {arrows = 3}}
local v22 = {arrows = {id = "arrows", name = "Arrows", perBundle = 12, points = 1, order = 1}, shot = {id = "shot", name = "Bullets", perBundle = 5, points = 1, order = 2}}
local v23 = {short_bow = "arrows", longbow = "arrows", crossbow = "arrows", musket = "shot", flintlock = "shot", blunderbuss = "shot"}
local result = nil
local timestamp = -math.huge

local function getRegistry()
    --[[
      name: getRegistry
      line: 97
      upvalues:
        result (ref,  index: 1)
        timestamp (ref,  index: 2)
        replicatedStorage (copy, index: 3)
    ]]
    if not result then
        if os.clock() - timestamp < 5 then
            return nil
        end

        timestamp = os.clock()
        local weapons = replicatedStorage.Shared:FindFirstChild("Weapons")

        if weapons and weapons:IsA("ModuleScript") then
            local success, result2 = pcall(require, weapons)

            if success and type(result2) == "table" then
                result = result2
            end
        end
    end

    return result
end

local function fromRegistry(id)
    --[[
      name: fromRegistry
      line: 115
      upvalues:
        getRegistry (copy, index: 1)
    ]]
    local registry = getRegistry()
    if not registry then
        return nil
    end

    if type(registry.Get) == "function" then
        local success, result = pcall(registry.Get, id)

        if success and type(result) == "table" then
            return result
        end
    end

    local v35 = type(registry.AMMO) == "table" and registry.AMMO[id]

    if type(v35) ~= "table" or v35.unlock ~= true then
        return nil
    end

    local v36
    local v37 = {category = "ammo", kind = "Ammo", hotbar = false, isAmmo = true, id = id, name = v35.name, role = v35.role
        or "Ammo", points = v35.points, description = v35.description, stats = {damage = 0, rate = 0, range = 0}}
    local v38 = {"Bundle", tostring(v35.perBundle) .. " arrows"}
    local v39 = {"Cost", tostring(v35.points) .. " points"}

    if type(v35.burn) ~= "table" then
        v36 = "-"
    else
        v36 = tostring(v35.burn.damage) .. " × " .. tostring(v35.burn.ticks)
    end

    v37.details = {v38, v39, {"Burn", v36}}
    v37.tuning = {}

    return v37
end

v18.OwnsAmmo = nil

local function allIds()
    --[[
      name: allIds
      line: 154
      upvalues:
        getRegistry (copy, index: 1)
        v19 (copy, index: 2)
    ]]
    local v41 = {}
    local v42 = {}

    local function add(key)
        --[[
          name: add
          line: 157
          upvalues:
            v41 (copy, index: 1)
            v42 (copy, index: 2)
        ]]
        if type(key) == "string" and not v41[key] then
            v41[key] = true
            table.insert(v42, key)
        end
    end

    local registry = getRegistry()

    if registry and type(registry.All) == "function" then
        local success, result = pcall(registry.All)

        if success and type(result) == "table" then
            for _, v49 in result do
                if type(v49) == "table" then
                    local id = v49.id

                    if type(id) == "string" and not v41[id] then
                        v41[id] = true
                        table.insert(v42, id)
                    end
                end
            end
        end
    end

    if registry and type(registry.UnlockAmmo) == "function" then
        for _, v52 in registry.UnlockAmmo() do
            if type(v52) == "string" and not v41[v52] then
                v41[v52] = true
                table.insert(v42, v52)
            end
        end
    end

    for v53 in v19 do
        if type(v53) == "string" and not v41[v53] then
            v41[v53] = true
            table.insert(v42, v53)
        end
    end

    return v42
end

local v54 = {}
local timestamp2 = 0

function v18.Get(id)
    --[[
      name: Get
      line: 190
      upvalues:
        timestamp2 (ref,  index: 1)
        v54 (copy, index: 2)
        v19 (copy, index: 3)
        fromRegistry (copy, index: 4)
        v18 (copy, index: 5)
    ]]
    if type(id) ~= "string" then
        return nil
    end

    local v57
    local description

    if 10 < os.clock() - timestamp2 then
        table.clear(v54)
        timestamp2 = os.clock()
    end

    if const v59 = v54[id] then
        return v59
    end

    local v60 = v19[id]
    local v61 = fromRegistry(id)

    if not v61 and not v60 then
        return nil
    end

    local v62 = {}

    if v60 then
        for v63, v64 in v60 do
            v62[v63] = v64
        end
    end

    if v61 then
        for v65, v66 in v61 do
            v62[v65] = v66
        end
    end

    v62.id = id

    if type(v62.name) ~= "string" then
        v57 = id:gsub("_", " ")
    else
        v57 = v62.name
    end

    v62.name = v57

    if type(v62.description) ~= "string" then
        description = ""
    else
        description = v62.description
    end

    v62.description = description

    if not v18.CATEGORY_NAMES[v62.category] then
        v62.category = v60 and v60.category or "utility"
    end

    if type(v62.points) ~= "number" then
        v62.points = v60 and v60.points or 1
    end

    if v62.hotbar == nil then
        v62.hotbar = v62.category ~= "armor"
    end

    v54[id] = v62

    return v62
end

function v18.Name(a67)
    --[[
      name: Name
      line: 234
      upvalues:
        v18 (copy, index: 1)
    ]]
    return if const v68 = v18.Get(a67) then v68.name elseif type(a67) ~= "string" then "" else a67
end

function v18.Points(a69)
    --[[
      name: Points
      line: 239
      upvalues:
        v18 (copy, index: 1)
    ]]
    return if const v70 = v18.Get(a69) then v70.points else 0
end

function v18.IsArmor(a71)
    --[[
      name: IsArmor
      line: 244
      upvalues:
        v18 (copy, index: 1)
    ]]
    local v72 = v18.Get(a71)
    return v72 ~= nil and v72.category ~= "ammo" and (v72.category == "armor" or v72.hotbar == false)
end

function v18.AmmoTypes()
    --[[
      name: AmmoTypes
      line: 250
      upvalues:
        getRegistry (copy, index: 1)
        v22 (copy, index: 2)
    ]]
    local registry = getRegistry()
    local v74 = {}

    if registry then
        if type(registry.AMMO) ~= "table" then
            for _, v76 in v22 do
                table.insert(v74, v76)
            end
        else
            for id, v78 in registry.AMMO do
                if type(v78) == "table" then
                    local v79
                    local v80
                    local v81
                    local v82 = v22[id]
                    local v83 = {id = id}
                    v79 = if const name = v78.name then name else v82 and v82.name or id
                    v83.name = v79
                    v80 = if const perBundle = v78.perBundle then perBundle elseif const count = v78.count then count else v78.amount
                        or v82 and v82.perBundle
                        or 10
                    v83.perBundle = v80
                    v81 = if const points = v78.points then points else v78.cost or v82 and v82.points or 1
                    v83.points = v81
                    v83.order = v78.order or v82 and v82.order or 9
                    v83.as = v78.as
                    v83.optional = v78.as ~= nil
                    v83.description = v78.description
                    table.insert(v74, v83)
                end
            end
        end
    else
        for _, v76 in v22 do
            table.insert(v74, v76)
        end
    end

    table.sort(
        v74,
        function(left, right)
            --[[
              line: 275
            ]]
            return left.order < right.order
        end
    )

    return v74
end

function v18.AmmoDef(a90)
    --[[
      name: AmmoDef
      line: 281
      upvalues:
        v18 (copy, index: 1)
    ]]
    for _, v92 in v18.AmmoTypes() do
        if v92.id == a90 then
            return v92
        end
    end

    return nil
end

function v18.MaxAmmoBundles()
    --[[
      name: MaxAmmoBundles
      line: 290
      upvalues:
        getRegistry (copy, index: 1)
    ]]
    local registry = getRegistry()

    if registry and type(registry.MAX_AMMO_BUNDLES) == "number" then
        return registry.MAX_AMMO_BUNDLES
    end

    return 3
end

function v18.AmmoOf(a94)
    --[[
      name: AmmoOf
      line: 296
      upvalues:
        v18 (copy, index: 1)
        v23 (copy, index: 2)
    ]]
    local v95 = v18.Get(a94)
    if not v95 then
        return nil
    end

    local v96 = v95.ammoType
        or v95.ammo
        or type(v95.tuning) == "table" and (v95.tuning.ammoType or v95.tuning.ammo)

    if type(v96) == "string" then
        if v96 ~= "" then
            return v96
        end
    end

    return v23[v95.id]
end

function v18.AmmoNeeded(a97)
    --[[
      name: AmmoNeeded
      line: 310
      upvalues:
        getRegistry (copy, index: 1)
        v18 (copy, index: 2)
    ]]
    local v98
    local v99 = {}

    if type(a97) ~= "table" or type(a97.items) ~= "table" then
        v98 = {}
    else
        v98 = a97.items
    end

    local registry = getRegistry()

    for _, v102 in v98 do
        if const v103 = v18.AmmoOf(v102) then
            v99[v103] = true

            if registry and type(registry.AltAmmo) == "function" then
                for _, v105 in registry.AltAmmo(v103) do
                    local v106 = type(registry.AMMO) == "table" and registry.AMMO[v105]
                    local ownsAmmo = v18.OwnsAmmo

                    if type(v106) ~= "table" or v106.unlock ~= true or not ownsAmmo or ownsAmmo(v105) then
                        v99[v105] = true
                    end
                end
            end
        end
    end

    return v99
end

function v18.Budget()
    --[[
      name: Budget
      line: 333
      upvalues:
        getRegistry (copy, index: 1)
    ]]
    local registry = getRegistry()

    if registry and type(registry.BUDGET) == "number" then
        return registry.BUDGET
    end

    return 12
end

function v18.MaxItems()
    --[[
      name: MaxItems
      line: 338
      upvalues:
        getRegistry (copy, index: 1)
    ]]
    local registry = getRegistry()

    if registry and type(registry.MAX_ITEMS) == "number" then
        return registry.MAX_ITEMS
    end

    return 6
end

function v18.ByCategory(a110)
    --[[
      name: ByCategory
      line: 344
      upvalues:
        allIds (copy, index: 1)
        v18 (copy, index: 2)
    ]]
    local v111 = {}

    for _, v113 in allIds() do
        local v114 = v18.Get(v113)

        if v114 and v114.category == a110 then
            table.insert(v111, v114)
        end
    end

    table.sort(
        v111,
        function(left, right)
            --[[
              line: 352
            ]]
            if left.points ~= right.points then
                return left.points < right.points
            end

            return left.name < right.name
        end
    )

    return v111
end

v18.Normalize = Normalize

function v18.Cost(a117)
    --[[
      name: Cost
      line: 393
      upvalues:
        v18 (copy, index: 1)
    ]]
    local v118 = v18.Normalize(a117)
    local v119 = 0

    for _, item in v118.items do
        v119 += v18.Points(item)
    end

    if v118.armor then
        v119 += v18.Points(v118.armor)
    end

    for v122, v123 in v118.ammo do
        if const v124 = v18.AmmoDef(v122) then
            v119 += v124.points * v123
        end
    end

    return v119
end

function v18.Validate(a125)
    --[[
      name: Validate
      line: 413
      upvalues:
        getRegistry (copy, index: 1)
        v18 (copy, index: 2)
    ]]
    local v126
    local registry = getRegistry()

    if registry and type(registry.Validate) == "function" and type(registry.AMMO) == "table" then
        local success, result, v130, v131 = pcall(registry.Validate, v18.Normalize(a125))

        if success and type(v131) == "table" then
            return result == true, v130, v18.Normalize(v131)
        end
    end

    local v132 = v18.Normalize(a125)
    local v133 = {armor = false, items = {}, ammo = {}}
    local v134 = {}

    for _, armor in v132.items do
        if v18.Get(armor) then
            if v134[armor] then
                continue
            end

            v134[armor] = true

            if v18.IsArmor(armor) then
                if not v133.armor then
                    v133.armor = armor
                end
            elseif #v133.items < v18.MaxItems() then
                table.insert(v133.items, armor)
            end
        end
    end

    if v132.armor and v18.IsArmor(v132.armor) then
        v133.armor = v132.armor
    end

    for v137, v138 in v132.ammo do
        if v18.AmmoDef(v137) then
            v133.ammo[v137] = math.clamp(v138, 0, (v18.MaxAmmoBundles()))
        end
    end

    local v139 = nil

    local function dropUnusedAmmo()
        --[[
          name: dropUnusedAmmo
          line: 447
          upvalues:
            v18 (copy, index: 1)
            v133 (copy, index: 2)
        ]]
        local v141 = v18.AmmoNeeded(v133)

        for v142 in v133.ammo do
            if not v141[v142] then
                v133.ammo[v142] = nil
            end
        end
    end

    local v143 = v18.Cost(v133)

    if v18.Budget() < v143 then
        local v144 = v18.AmmoNeeded(v133)

        for v145 in v133.ammo do
            if not v144[v145] then
                v133.ammo[v145] = nil
            end
        end

        v126 = v139
    else
        v126 = v139
    end

    while true do
        local v146 = v18.Cost(v133)

        if not (v18.Budget() < v146) then
            break
        end
        if not (0 < #v133.items) then
            break
        end

        table.remove(v133.items)
        local v147 = v18.AmmoNeeded(v133)

        for v148 in v133.ammo do
            if not v147[v148] then
                v133.ammo[v148] = nil
            end
        end

        v126 = "Over budget"
    end

    local v149 = v18.Cost(v133)

    if v18.Budget() < v149 then
        v133.armor = false
        v126 = "Over budget"
    end

    return v126 == nil, v126, v133
end

function v18.DefaultLoadout()
    --[[
      name: DefaultLoadout
      line: 470
      upvalues:
        getRegistry (copy, index: 1)
        v18 (copy, index: 2)
        v21 (copy, index: 3)
    ]]
    local registry = getRegistry()

    if registry and type(registry.DEFAULT_LOADOUT) == "table" then
        return v18.Normalize(registry.DEFAULT_LOADOUT)
    end

    return v18.Normalize(v21)
end

v18.FILTERS = {{id = "all", name = "ALL", cats = nil}, {id = "weapons", name = "WEAPONS", cats = {bow = true, gun = true, melee = true}}, {id = "utility", name = "UTILITY", cats = {throwable = true, utility = true}}, {id = "healing", name = "HEALING", cats = {healing = true}}, {id = "armor", name = "ARMOR", cats = {armor = true}}}

function v18.AllItems()
    --[[
      name: AllItems
      line: 488
      upvalues:
        v18 (copy, index: 1)
    ]]
    local v151 = {}

    for _, category in v18.CATEGORIES do
        for _, v155 in v18.ByCategory(category) do
            table.insert(v151, v155)
        end
    end

    return v151
end

v18.ArmorStats = ArmorStats
local result2 = nil
local timestamp3 = -math.huge

local function combat()
    --[[
      name: combat
      line: 518
      upvalues:
        result2 (ref,  index: 1)
        timestamp3 (ref,  index: 2)
        replicatedStorage (copy, index: 3)
    ]]
    if not result2 and not (os.clock() - timestamp3 < 5) then
        timestamp3 = os.clock()
        local combat = replicatedStorage.Shared:FindFirstChild("Combat")

        if combat and combat:IsA("ModuleScript") then
            local success, result = pcall(require, combat)

            if success and type(result) == "table" and type(result.RunSpeed) == "function" then
                result2 = result
            end
        end
    end

    return result2
end

local v162 = table.freeze({})

function v18.RunSpeed(a163)
    --[[
      name: RunSpeed
      line: 533
      upvalues:
        v162 (copy, index: 1)
        combat (copy, index: 2)
        v18 (copy, index: 3)
    ]]
    if not a163 or a163.isAmmo or a163.category == "ammo" then
        return nil, v162
    end

    local v164 = combat()

    if a163.category == "armor" then
        if v164 then
            return v164.ArmorSpeed(a163.id), v162
        end

        local _, v166 = v18.ArmorStats(a163)

        return v166, v162
    end

    if not v164 then
        return nil, v162
    end

    local success, result, v169 = pcall(v164.RunSpeed, a163.id)

    if success and type(result) == "number" then
        return result, v169
    end

    return nil, v162
end

function v18.SpeedText(a170)
    --[[
      name: SpeedText
      line: 556
    ]]
    local flooredValue = math.floor((math.abs(a170 - 1) * 100) + 0.5)

    if flooredValue == 0 then
        return "Normal"
    end

    local v172 = not (1 < a170) and "−" or "+"

    return v172 .. flooredValue .. "%"
end

local function speedFrac(a174)
    --[[
      name: speedFrac
      line: 565
    ]]
    return (math.clamp((a174 - 0.8) / 0.4, 0.05, 1))
end

function v18.SpeedNote(a175)
    --[[
      name: SpeedNote
      line: 571
      upvalues:
        v18 (copy, index: 1)
    ]]
    local _, v177 = v18.RunSpeed(a175)

    if #v177 == 0 then
        return ""
    end

    local v178 = v18.SpeedText(v177[1].mult) .. " run speed while " .. v177[1].move

    if v177[2] then
        v178 ..= ", " .. v18.SpeedText(v177[2].mult) .. " while " .. v177[2].move
    end

    return v178 .. "."
end

function v18.Bars(a179)
    --[[
      name: Bars
      line: 586
      upvalues:
        v18 (copy, index: 1)
        getRegistry (copy, index: 2)
        v19 (copy, index: 3)
        v20 (copy, index: 4)
    ]]
    local v180 = {}

    if not a179 then
        return v180
    end

    local v182 = if const v181 = v18.RunSpeed(a179) then {label = "RUN SPEED", frac = math.clamp((v181 - 0.8) / 0.4, 0.05, 1), value = v18.SpeedText(v181)} else nil

    if a179.category == "armor" then
        table.insert(v180, {label = "ARMOR", frac = math.clamp(v18.ArmorStats(a179) / 100, 0.05, 1)})

        if v182 then
            table.insert(v180, v182)
        end

        local rangedReduction = type(a179.tuning) == "table" and a179.tuning.rangedReduction

        if type(rangedReduction) == "number" and 0 < rangedReduction then
            local v184 = {label = "VS RANGED", frac = math.clamp(rangedReduction / 0.4, 0.05, 1)}
            table.insert(v180, v184)
        end

        return v180
    end

    local v185
    local registry = getRegistry()

    if type(a179.stats) ~= "table" then
        v185 = v180
    elseif registry then
        if type(registry.STAT_BARS) ~= "table" then
            v185 = v180
        else
            for _, statBar in registry.STAT_BARS do
                local v189
                local v190 = false

                if type(statBar) == "table" then
                    v189 = a179.stats[statBar.key]
                else
                    v189 = v190
                end

                if type(v189) == "number" then
                    local v191 = {}
                    local stringUpper = string.upper
                    local v193 = statBar.label or statBar.key
                    v191.label = stringUpper((tostring(v193)))
                    v191.frac = math.clamp(v189 / 10, 0, 1)
                    table.insert(v180, v191)
                end
            end

            v185 = #v180 < 2 and {} or v180
        end
    else
        v185 = v180
    end

    if #v185 == 0 then
        local v194 = v19[a179.id]
        local bars = a179.bars or v194 and v194.bars

        if type(bars) == "table" then
            for v196, bar in bars do
                if type(bar) == "number" and v20[v196] then
                    table.insert(v185, {label = v20[v196], frac = math.clamp(bar, 0, 1)})
                end
            end
        end
    end

    if v182 and 0 < #v185 then
        table.insert(v185, v182)
    end

    return v185
end

return v18