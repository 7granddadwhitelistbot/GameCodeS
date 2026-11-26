local Weapons

local function Context(a3)
    --[[
      name: Context
      line: 700
    ]]
    local v4
    local loadout
    local rankBest

    if type(a3) ~= "table" or type(a3.dropStats) ~= "table" then
        v4 = {}
    else
        v4 = a3.dropStats
    end

    local v7 = {total = tonumber(v4.total) or 0, sinceUnlock = tonumber(v4.sinceUnlock) or 0, first = v4.first == true}

    if type(a3) ~= "table" then
        loadout = nil
    else
        loadout = a3.loadout
    end

    v7.loadout = loadout

    if type(a3) == "table" and type(a3.rankBest) == "number" then
        rankBest = a3.rankBest
    else
        rankBest = nil
    end

    v7.rankBest = rankBest

    return v7
end

local v8 = {}
local Unlocks = require(script.Parent:WaitForChild("Unlocks"))
local Ranks = require(script.Parent:WaitForChild("Ranks"))
local success, Weapons2 = pcall(
    function()
        --[[
          line: 55
        ]]
        return (require(script.Parent:WaitForChild("Weapons")))
    end
)

if success then
    Weapons = Weapons2
else
    Weapons = nil
end

v8.MAX_LEVEL = 5
v8.BONUS_PER_LEVEL = 0.02
v8.BONUS_CAP = 0.08
v8.SIZES = table.freeze({small = table.freeze({unlock = 10, upgrade = table.freeze({10, 20, 40, 80})}), medium = table.freeze({unlock = 20, upgrade = table.freeze({20, 40, 80, 160})}), large = table.freeze({unlock = 40, upgrade = table.freeze({40, 80, 160, 320})}), starter = table.freeze({unlock = 0, upgrade = table.freeze({10, 20, 40, 80})})})
v8.DROPS = table.freeze(
    {
        goldenChance = 0.05,
        pity = 6,
        pityFill = 8,
        xpPerShard = 5,
        order = table.freeze({"drop", "victory", "golden"}),
        kinds = table.freeze(
            {
                drop = table.freeze({name = "Drop", stacks = 2, min = 4, max = 5}),
                victory = table.freeze({name = "Victory Drop", stacks = 3, min = 5, max = 7}),
                golden = table.freeze({name = "Golden Drop", stacks = 4, min = 13, max = 17, lockedStack = true}),
                tribe1 = table.freeze({name = "Tribe Chest", stacks = 2, min = 4, max = 5}),
                tribe2 = table.freeze({name = "Tribe Chest", stacks = 3, min = 5, max = 7}),
                tribe3 = table.freeze({name = "Tribe Chest", stacks = 3, min = 8, max = 10}),
                tribe4 = table.freeze({name = "Tribe Chest", stacks = 4, min = 9, max = 11}),
                tribe5 = table.freeze({name = "Tribe Chest", stacks = 4, min = 13, max = 17, lockedStack = true})
            }
        ),
        bonus = table.freeze({min = 4, max = 6}),
        weights = table.freeze({locked = 1.25, owned = 1, nearUnlock = 1.25, nearAt = 0.5, carried = 2}),
        first = table.freeze({item = "crossbow", drops = 3})
    }
)

function v8.IsKnown(a13)
    --[[
      name: IsKnown
      line: 131
      upvalues:
        Unlocks (copy, index: 1)
    ]]
    return Unlocks.IsKnown(a13)
end

function v8.AllIds()
    --[[
      name: AllIds
      line: 135
      upvalues:
        Unlocks (copy, index: 1)
    ]]
    return Unlocks.AllIds()
end

function v8.Size(a14)
    --[[
      name: Size
      line: 139
      upvalues:
        Unlocks (copy, index: 1)
        v8 (copy, index: 2)
    ]]
    local sizeKey = Unlocks.SizeOf(a14)

    if v8.SIZES[sizeKey] then
        return sizeKey
    end

    return "medium"
end

local v16 = {}

function v8.Stat(key)
    --[[
      name: Stat
      line: 146
      upvalues:
        v16 (copy, index: 1)
        Weapons (ref,  index: 2)
        Unlocks (copy, index: 3)
    ]]
    if type(key) ~= "string" then
        return false
    end

    local v18 = v16[key]
    if v18 ~= nil then
        return v18
    end

    local v19 = "damage"

    if const v20 = Weapons and Weapons.Get(key) then
        local v21 = v20.tuning or {}

        if v20.category == "armor" then
            v19 = "armor"
        elseif v20.category == "healing" then
            v19 = "healing"
        elseif type(v21.damage) == "number" and 0 < v21.damage then
            v19 = "damage"
        elseif type(v21.splash) ~= "table" or not (0 < (v21.splash.damage or 0)) then
            if type(v21.bees) == "table" and 0 < (v21.bees.damage or 0) or type(v21.burn) == "table" then
                v19 = "damage"
            else
                v19 = false
            end
        else
            v19 = "damage"
        end
    elseif Unlocks.IsAmmo(key) then
        v19 = false
    end

    v16[key] = v19

    return v19
end

function v8.MaxLevel(a22)
    --[[
      name: MaxLevel
      line: 177
      upvalues:
        v8 (copy, index: 1)
    ]]
    if v8.Stat(a22) then
        return v8.MAX_LEVEL
    end

    return 1
end

function v8.UnlockCost(a23)
    --[[
      name: UnlockCost
      line: 181
      upvalues:
        Unlocks (copy, index: 1)
        v8 (copy, index: 2)
    ]]
    if Unlocks.IsStarter(a23) then
        return 0
    end

    return v8.SIZES[v8.Size(a23)].unlock
end

function v8.UpgradeCost(a24, a25: number)
    --[[
      name: UpgradeCost
      line: 188
      upvalues:
        v8 (copy, index: 1)
    ]]
    if type(a25) == "number" and not (a25 < 1) and not (v8.MaxLevel(a24) <= a25) then
        return v8.SIZES[v8.Size(a24)].upgrade[math.floor(a25)]
    end

    return nil
end

local function defaultLevel(a27)
    --[[
      name: defaultLevel
      line: 198
      upvalues:
        Unlocks (copy, index: 1)
    ]]
    if Unlocks.IsStarter(a27) then
        return 1
    end

    return 0
end

function v8.Level(a28, key)
    --[[
      name: Level
      line: 202
      upvalues:
        Unlocks (copy, index: 1)
        v8 (copy, index: 2)
    ]]
    if type(key) ~= "string" then
        return 0
    end

    local flooredValue
    local v31 = type(a28) == "table" and a28[key]

    if type(v31) ~= "table" or type(v31.level) ~= "number" then
        flooredValue = 0
    else
        flooredValue = math.floor(v31.level)
    end

    local v32 = Unlocks.IsStarter(key) and 1 or 0

    return (math.clamp(math.max(flooredValue, v32), 0, v8.MaxLevel(key)))
end

function v8.ShardsOf(a33, key)
    --[[
      name: ShardsOf
      line: 211
    ]]
    local flooredValue
    local v36 = type(a33) == "table" and type(key) == "string" and a33[key]

    if type(v36) ~= "table" or type(v36.shards) ~= "number" or v36.shards ~= v36.shards then
        flooredValue = 0
    else
        flooredValue = math.floor(v36.shards)
    end

    return (math.max(0, flooredValue))
end

function v8.Owns(a37, a38)
    --[[
      name: Owns
      line: 217
      upvalues:
        v8 (copy, index: 1)
    ]]
    return 1 <= v8.Level(a37, a38)
end

function v8.Progress(a39, a40)
    --[[
      name: Progress
      line: 221
      upvalues:
        v8 (copy, index: 1)
    ]]
    local v41 = v8.Level(a39, a40)
    local v42 = v8.ShardsOf(a39, a40)

    if v41 == 0 then
        return v42, v8.UnlockCost(a40), "unlock"
    end

    local v43 = v8.UpgradeCost(a40, v41)
    if not v43 then
        return v42, 0, "max"
    end

    return v42, v43, "upgrade"
end

function v8.CanUpgrade(a44, a45)
    --[[
      name: CanUpgrade
      line: 234
      upvalues:
        v8 (copy, index: 1)
    ]]
    local v46, v47, v48 = v8.Progress(a44, a45)
    return (v48 == "upgrade") and (v47 <= v46)
end

function v8.ReadyCount(a49)
    --[[
      name: ReadyCount
      line: 239
      upvalues:
        v8 (copy, index: 1)
    ]]
    local count = 0

    for _, v52 in v8.AllIds() do
        if v8.CanUpgrade(a49, v52) then
            count += 1
        end
    end

    return count
end

function v8.ToMax(a53, a54)
    --[[
      name: ToMax
      line: 250
      upvalues:
        v8 (copy, index: 1)
    ]]
    local v55 = v8.Level(a53, a54)
    local v56 = v8.MaxLevel(a54)

    if v56 <= v55 then
        return 0
    end

    local v57 = v55 ~= 0 and 0 or v8.UnlockCost(a54)

    for index = math.max(v55, 1), v56 - 1 do
        v57 += v8.UpgradeCost(a54, index) or 0
    end

    return (math.max(0, v57 - v8.ShardsOf(a53, a54)))
end

function v8.Bonus(a59: number)
    --[[
      name: Bonus
      line: 263
      upvalues:
        v8 (copy, index: 1)
    ]]
    if type(a59) == "number" and not (a59 <= 1) then
        return math.min(v8.BONUS_PER_LEVEL * (math.floor(a59) - 1), v8.BONUS_CAP) + 1
    end

    return 1
end

function v8.BonusText(a60, a61)
    --[[
      name: BonusText
      line: 270
      upvalues:
        v8 (copy, index: 1)
    ]]
    return if const v62 = v8.Stat(a60) then (`+{math.floor(((v8.Bonus(a61) - 1) * 100) + 0.5)}% {v62}`) else ""
end

function v8.Set(a63, key, a65: number, a66)
    --[[
      name: Set
      line: 283
      upvalues:
        v8 (copy, index: 1)
        Unlocks (copy, index: 2)
    ]]
    local v67
    local shards = math.max(0, (math.floor(a65)))
    a66 = math.clamp(math.floor(a66), 0, v8.MaxLevel(key))

    if Unlocks.IsStarter(key) then
        v67 = 1
    else
        v67 = 0
    end

    local level = math.max(a66, v67)

    if shards == 0 then
        local v70 = Unlocks.IsStarter(key) and 1 or 0

        if level == v70 then
            a63[key] = nil
            return
        end
    end

    a63[key] = {shards = shards, level = level}
end

function v8.Upgrade(a71, a72)
    --[[
      name: Upgrade
      line: 294
      upvalues:
        v8 (copy, index: 1)
    ]]
    if type(a72) ~= "string" or not v8.IsKnown(a72) then
        return false, "Unknown item", nil
    end

    local v73 = v8.Level(a71, a72)

    if v73 == 0 then
        return false, "Locked", nil
    end

    local v74 = v8.UpgradeCost(a72, v73)
    if not v74 then
        return false, "Max level", nil
    end

    local v75 = v8.ShardsOf(a71, a72)

    if v75 < v74 then
        return false, "Not enough shards", nil
    end

    v8.Set(a71, a72, v75 - v74, v73 + 1)

    return true, nil, v73 + 1
end

local function carriedSet(a77)
    --[[
      name: carriedSet
      line: 317
    ]]
    local v78 = {}

    if type(a77) == "table" then
        if type(a77.items) == "table" then
            for itemKey = 1, 16 do
                local item = a77.items[itemKey]

                if type(item) ~= "string" then
                    break
                end

                v78[item] = true
            end
        end

        if type(a77.armor) == "string" then
            v78[a77.armor] = true
        end
    end

    return v78
end

function v8.Pool(a81, a82)
    --[[
      name: Pool
      line: 339
      upvalues:
        v8 (copy, index: 1)
        carriedSet (copy, index: 2)
        Ranks (copy, index: 3)
    ]]
    local rankBest
    local weights = v8.DROPS.weights
    local v85 = carriedSet((a82 and a82.loadout))
    local v86 = {}

    if a82 and type(a82.rankBest) == "number" then
        rankBest = a82.rankBest
    else
        rankBest = nil
    end

    for _, item in v8.AllIds() do
        local v89 = v8.Level(a81, item)

        if not (v8.MaxLevel(item) <= v89) then
            if v89 ~= 0 or not rankBest or Ranks.Allows(rankBest, item) then
                if v89 == 0 then
                    local nearUnlock
                    local v91 = math.max(1, v8.UnlockCost(item))
                    local frac = math.min(1, v8.ShardsOf(a81, item) / v91)
                    local v93 = {locked = true, item = item}
                    local locked = weights.locked

                    if weights.nearAt <= frac then
                        nearUnlock = weights.nearUnlock
                    else
                        nearUnlock = 1
                    end

                    v93.weight = locked * nearUnlock
                    v93.frac = frac
                    table.insert(v86, v93)
                else
                    local v95 = {locked = false, frac = 0, item = item}
                    local owned = weights.owned
                    local v97 = not v85[item] and 1 or weights.carried
                    v95.weight = owned * v97
                    table.insert(v86, v95)
                end
            end
        end
    end

    return v86
end

local function forcedPick(a99, a100, a101)
    --[[
      name: forcedPick
      line: 367
      upvalues:
        v8 (copy, index: 1)
    ]]
    local drops = v8.DROPS

    if a101.first == true and drops.first then
        for _, v104 in a100 do
            if v104.item == drops.first.item and v104.locked then
                local v105 = math.max(1, drops.first.drops - (tonumber(a101.total) or 0))
                return v104, (math.ceil((v8.UnlockCost(v104.item) - v8.ShardsOf(a99, v104.item)) / v105))
            end
        end
    end

    local number = tonumber(a101.sinceUnlock) or 0

    if drops.pity <= number then
        local v107
        local v108 = math.huge

        for _, v110 in a100 do
            if v110.locked then
                local v111 = v8.UnlockCost(v110.item) - v8.ShardsOf(a99, v110.item)

                if v107 then
                    local frac = v110.frac

                    if not (v107.frac < frac) then
                        if v110.frac ~= v107.frac then
                            continue
                        end
                        if not (v111 < v108) then
                            continue
                        end
                    end
                end

                v107, v108 = v110, v111
            end
        end

        if v107 then
            if v108 <= drops.pityFill then
                return v107, v108
            end

            return v107, 0
        end
    end

    return nil, 0
end

local function weightedPick(a114, a115, a116: boolean, a117)
    --[[
      name: weightedPick
      line: 396
    ]]
    local v118
    local total = 0

    for _, v121 in a114 do
        if not a115[v121.item] then
            if v121.locked or not a116 then
                total += v121.weight
            end
        end
    end

    if total <= 0 then
        return nil
    end

    local v122 = a117:NextNumber() * total
    v118 = nil

    for _, v124 in a114 do
        if not a115[v124.item] then
            if not v124.locked and a116 then
                continue
            end

            v122 -= v124.weight

            if v122 < 0 then
                return v124
            end

            v118 = v124
        end
    end

    return v118
end

function v8.Roll(a125, kindKey, options, a128)
    --[[
      name: Roll
      line: 422
      upvalues:
        v8 (copy, index: 1)
        forcedPick (copy, index: 2)
        weightedPick (copy, index: 3)
    ]]
    local drops = v8.DROPS
    local v130 = options or {}
    local v131 = drops.kinds[kindKey] or drops.kinds.drop
    local v132 = {}

    for _ = 1, v131.stacks do
        table.insert(v132, {bonus = false, n = a128:NextInteger(v131.min, v131.max)})
    end

    if v130.mvp == true then
        table.insert(v132, {bonus = true, n = a128:NextInteger(drops.bonus.min, drops.bonus.max)})
    end

    for _ = 1, math.clamp(math.floor((tonumber(v130.extra) or 0)), 0, 5) do
        table.insert(v132, {bonus = true, n = a128:NextInteger(drops.bonus.min, drops.bonus.max)})
    end

    local v135 = v8.Pool(a125, v130)
    local v136 = {}
    local v137 = {}
    local total = 0

    if type(v130.lead) == "table" then
        for _, v140 in v130.lead do
            local _ = type(v140) == "table" and v140.item
            local item

            if type(item) == "string" then
                if not v8.IsKnown(item) then
                    continue
                end
                if v136[item] then
                    continue
                end

                v136[item] = true
                local shards = math.min(math.max(0, (math.floor((tonumber(v140.shards) or 0)))), v8.ToMax(a125, item))

                if not (0 < shards) then
                    continue
                end

                table.insert(v137, {item = item, shards = shards})
            end
        end
    end

    local v144

    for v145, v146 in v132 do
        local v147
        local v148 = nil
        local n = v146.n

        if v145 == 1 then
            local v150
            v144, v150 = forcedPick(a125, v135, v130)

            if v144 and not v136[v144.item] then
                v147 = math.max(n, v150)
                v148 = v144
            elseif v131.lockedStack then
                v148 = weightedPick(v135, v136, true, a128)
                v147 = n
            else
                v147 = n
            end
        else
            v147 = n
        end

        v148 = v148 or weightedPick(v135, v136, false, a128)

        if v148 then
            v136[v148.item] = true
            local v151 = v8.ToMax(a125, v148.item)

            if v151 < v147 then
                total += (v147 - v151) * drops.xpPerShard
                v147 = v151
            end

            if 0 < v147 then
                local bonus
                local v153 = {item = v148.item, shards = v147}

                if v146.bonus then
                    bonus = true
                else
                    bonus = nil
                end

                v153.bonus = bonus
                table.insert(v137, v153)
            end
        else
            total += v147 * drops.xpPerShard
        end
    end

    return v137, total
end

function v8.Apply(a154, a155)
    --[[
      name: Apply
      line: 489
      upvalues:
        v8 (copy, index: 1)
    ]]
    local v156 = {}

    for _, v158 in a155 do
        local level, v160
        local item = v158.item
        local levelBefore = v8.Level(a154, item)
        local before = v8.ShardsOf(a154, item)
        local need = if levelBefore == 0 then v8.UnlockCost(item) else v8.UpgradeCost(item, levelBefore) or 0
        local after = before + math.max(0, (math.floor(v158.shards)))
        local unlocked = false

        if levelBefore == 0 and need <= after then
            level = 1
            v160 = after - need
            unlocked = true
        else
            v160, level = after, levelBefore
        end

        v8.Set(a154, item, v160, level)
        local v167 = {item = item, shards = v158.shards, before = before, after = after, need = need, levelBefore = levelBefore, level = level, unlocked = unlocked, ready = v8.CanUpgrade(a154, item), bonus = v158.bonus == true}
        table.insert(v156, v167)
    end

    return v156
end

function v8.KindFor(a168, a169)
    --[[
      name: KindFor
      line: 520
      upvalues:
        v8 (copy, index: 1)
    ]]
    if not a168 then
        return "drop", false
    end

    local v170 = a169:NextNumber()

    if v170 < v8.DROPS.goldenChance then
        return "golden", true
    end

    return "victory", false
end

local function revealRank(a172)
    --[[
      name: revealRank
      line: 530
    ]]
    if a172.unlocked then
        return 3
    end
    if a172.levelBefore == 0 then
        return 2
    end
    if a172.ready then
        return 1
    end

    return 0
end

function v8.Drop(a173, options, a175, options2, a177)
    --[[
      name: Drop
      line: 546
      upvalues:
        v8 (copy, index: 1)
    ]]
    local v178 = options2 or {}
    local v179 = {mvp = v178.mvp == true, total = options.total or 0, sinceUnlock = options.sinceUnlock or 0, first = options.first == true, loadout = v178.loadout, extra = v178.extra, rankBest = v178.rankBest, lead = v178.lead}
    local v180, v181 = v8.Roll(a173, a175, v179, a177)
    local v182 = v8.Apply(a173, v180)
    local v183 = {}

    for v184, v185 in v182 do
        v183[v185] = v184
    end

    table.sort(
        v182,
        function(left, right)
            --[[
              line: 564
              upvalues:
                v183 (copy, index: 1)
            ]]
            local v188 = left.unlocked and 3 or left.levelBefore ~= 0 and (left.ready and 1 or 0) or 2
            local v189 = right.unlocked and 3 or right.levelBefore ~= 0 and (right.ready and 1 or 0) or 2

            if v188 ~= v189 then
                return v188 < v189
            end

            return v183[left] < v183[right]
        end
    )

    local unlocked = false

    for _, v192 in v182 do
        local unlocked2 = unlocked or v192.unlocked
        unlocked = unlocked2
    end

    options.total = (options.total or 0) + 1
    options.sinceUnlock = unlocked and 0 or (options.sinceUnlock or 0) + 1
    local first = v8.DROPS.first

    if options.first == true and (not first or not v8.IsKnown(first.item) or v8.Owns(a173, first.item)) then
        options.first = false
    end

    return v182, v181, unlocked
end

local function inclusion(a196, kindKey, a198)
    --[[
      name: inclusion
      line: 593
      upvalues:
        v8 (copy, index: 1)
        forcedPick (copy, index: 2)
    ]]
    local has, v200
    local drops = v8.DROPS
    local v202 = drops.kinds[kindKey] or drops.kinds.drop
    local v203 = v8.Pool(a196, a198)
    local stacks = v202.stacks
    local v205 = a198.mvp ~= true and 0 or 1
    local v206 = stacks + v205
    local size = #v203
    local values = table.create(size, 0)
    local v209 = 0

    if size == 0 then
        return {}, 0
    end

    local v210 = v203
    local v211 = forcedPick(a196, v210, a198)
    local v212 = 0

    if v211 then
        local v213 = v203

        for v214, v215 in v213 do
            if v215 == v211 then
                v212 = v214
            end
        end
    end

    local v216 = false
    local v217 = v203
    v200 = v216

    for _, v219 in v217 do
        local v220 = v200 or v219.locked
        v200 = v220
    end

    has = function(a221, a222)
        --[[
          name: has
          line: 618
        ]]
        return math.floor(a221 / (2 ^ (function(...) return ... end)(((a222 - 1))))) % 2 == 1
    end

    if not (50 < size) then
        local v223 = {[0] = 1}

        for index = 1, math.min(v206, size) do
            local v225 = {}
            local v226, v227

            for v226, v227 in v223 do
                local v228 = index == 1 and v202.lockedStack == true and v200

                if index ~= 1 or not (0 < v212) then
                    local v229
                    local v230 = 0
                    v229 = v230

                    for v231, v232 in v203 do
                        if not has(v226, v231) then
                            if v232.locked or not v228 then
                                v229 += v232.weight
                            end
                        end
                    end

                    if 0 < v229 then
                        for v233, v234 in v203 do
                            local v235, v236
                            local v237 = false

                            if not has(v226, v233) then
                                if v234.locked then
                                    v235, v236 = v233, v234
                                    v237 = true
                                elseif not v228 then
                                    v235, v236 = v233, v234
                                    v237 = true
                                end
                            end

                            if v237 then
                                local v238 = v226 + 2 ^ (function(...) return ... end)(((v235 - 1)))
                                local v239 = v225[v238] or 0
                                v225[v238] = v239 + ((v227 * v236.weight) / v229)
                            end
                        end
                    end
                else
                    v225[2 ^ (function(...) return ... end)(((v212 - 1)))] = v227
                end
            end

            v223 = v225
        end

        for v240, v241 in v223 do
            local locked = false

            for valueKey, v244 in v203 do
                if has(v240, valueKey) then
                    values[valueKey] += v241
                    local locked2 = locked or v244.locked
                    locked = locked2
                end
            end

            if locked then
                v209 += v241
            end
        end
    else
        local random = Random.new(12345)
        local count = 0
        local v248 = {}

        for v249, v250 in v203 do
            v248[v250.item] = v249
        end

        for _ = 1, 20000 do
            local v252 = v8.Roll(a196, kindKey, a198, random)
            local locked = false

            for _, v255 in v252 do
                if const valueKey = v248[v255.item] then
                    values[valueKey] += 5e-05
                    local locked3 = locked or v203[valueKey].locked
                    locked = locked3
                end
            end

            if locked then
                count += 1
            end
        end

        v209 = count / 20000
    end

    local v258 = {}

    for valueKey, v260 in v203 do
        table.insert(v258, {item = v260.item, chance = math.clamp(values[valueKey], 0, 1), locked = v260.locked})
    end

    table.sort(
        v258,
        function(left, right)
            --[[
              line: 689
            ]]
            if not (1e-09 < math.abs(left.chance - right.chance)) then
                return left.item < right.item
            end

            local chance = left.chance

            return right.chance < chance
        end
    )

    return v258, (math.clamp(v209, 0, 1))
end

v8.Context = Context

function v8.Odds(a264, kind, a266)
    --[[
      name: Odds
      line: 711
      upvalues:
        v8 (copy, index: 1)
        inclusion (copy, index: 2)
    ]]
    local drops = v8.DROPS
    local kinds = {}

    for _, v270 in drops.order do
        local kind2 = drops.kinds[v270]
        table.insert(kinds, {kind = v270, name = kind2.name, stacks = kind2.stacks, min = kind2.min, max = kind2.max, lockedStack = kind2.lockedStack == true})
    end

    local v272 = {kinds = kinds, bonus = {min = drops.bonus.min, max = drops.bonus.max}, goldenChance = drops.goldenChance, pity = drops.pity}

    if a264 ~= nil and type(kind) == "string" and drops.kinds[kind] then
        local v273 = a266 or {}
        local items, lockedChance = inclusion(a264, kind, v273)
        v272.kind = kind
        v272.items = items
        v272.lockedChance = lockedChance
    end

    return v272
end

function v8.LevelsFor(a276, a277)
    --[[
      name: LevelsFor
      line: 736
      upvalues:
        carriedSet (copy, index: 1)
        v8 (copy, index: 2)
    ]]
    local v278 = {}

    for v279 in carriedSet(a277) do
        if v8.IsKnown(v279) then
            v278[v279] = math.max(1, v8.Level(a276, v279))
        end
    end

    return v278
end

local v280 = nil

local function catalogue()
    --[[
      name: catalogue
      line: 750
      upvalues:
        v280 (ref,  index: 1)
        v8 (copy, index: 2)
    ]]
    if const v282 = v280 then
        return v282
    end

    local ids = v8.AllIds()
    local index = {}

    for v285, v286 in ids do
        index[v286] = v285
    end

    local v287 = {ids = ids, index = index}
    v280 = v287

    return v287
end

local function base36(a289)
    --[[
      name: base36
      line: 766
    ]]
    local v290
    local v291 = ""
    v290 = a289

    repeat
        local v292 = v290 % 36
        v291 = string.sub("0123456789abcdefghijklmnopqrstuvwxyz", v292 + 1, v292 + 1) .. v291
        v290 //= 36
    until v290 == 0

    return v291
end

function v8.EncodeLevels(a293)
    --[[
      name: EncodeLevels
      line: 776
      upvalues:
        catalogue (copy, index: 1)
        v8 (copy, index: 2)
    ]]
    local v294 = catalogue()
    local v295 = {}

    if type(a293) == "table" then
        for v296, v297 in a293 do
            local i
            local v299 = false

            if type(v296) == "string" then
                i = v294.index[v296]
            else
                i = v299
            end

            if i then
                if type(v297) == "number" and 2 <= v297 then
                    local v300
                    local v301 = {s = nil, i = i}
                    local v302 = ""
                    v300 = v299

                    repeat
                        local v303 = v300 % 36
                        v302 = string.sub("0123456789abcdefghijklmnopqrstuvwxyz", v303 + 1, v303 + 1) .. v302
                        v300 //= 36
                    until v300 == 0

                    v301.s = `{v302}={(math.clamp(math.floor(v297), 2, v8.MAX_LEVEL))}`
                    table.insert(v295, v301)
                end
            end
        end
    end

    table.sort(
        v295,
        function(left, right)
            --[[
              line: 787
            ]]
            return left.i < right.i
        end
    )
    local parts = {}
    local v307 = 0
    local v308 = v307

    for _, v310 in v295 do
        if 51 < (v308 + #v310.s) + 1 then
            break
        end

        v308 += #v310.s + 1
        table.insert(parts, v310.s)
    end

    return table.concat(parts, ",")
end

local v311 = {}
local v312 = 0

function v8.DecodeLevels(text: string)
    --[[
      name: DecodeLevels
      line: 805
      upvalues:
        v311 (copy, index: 1)
        catalogue (copy, index: 2)
        v8 (copy, index: 3)
        v312 (ref,  index: 4)
    ]]
    if type(text) ~= "string" or text == "" then
        return {}
    elseif const v314 = v311[text] then
        return v314
    end

    local v315 = catalogue()
    local v316 = {}

    for v317, v318 in string.gmatch(text, "(%w+)=(%d+)") do
        local number = tonumber(v317, 36)

        if const v320 = number and v315.ids[number] then
            v316[v320] = math.clamp((tonumber(v318) or 1), 1, v8.MAX_LEVEL)
        end
    end

    table.freeze(v316)

    if 256 < v312 then
        table.clear(v311)
        v312 = 0
    end

    v311[text] = v316
    v312 += 1

    return v316
end

return v8