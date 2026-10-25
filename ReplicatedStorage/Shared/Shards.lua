local tbl_upv_1 = {}
local Unlocks_upv_1 = require(script.Parent:WaitForChild("Unlocks"))
local Ranks_upv_1 = require(script.Parent:WaitForChild("Ranks"))
local success_1, _ = pcall(
    function()
        --[[
          line: 55
        ]]
        return (require(script.Parent:WaitForChild("Weapons")))
    end
)
local u1 = (success_1) or nil
tbl_upv_1.MAX_LEVEL = 5
tbl_upv_1.BONUS_PER_LEVEL = 0.02
tbl_upv_1.BONUS_CAP = 0.08
tbl_upv_1.SIZES = table.freeze({small = table.freeze({unlock = 10, upgrade = table.freeze({10, 20, 40, 80})}), medium = table.freeze({unlock = 20, upgrade = table.freeze({20, 40, 80, 160})}), large = table.freeze({unlock = 40, upgrade = table.freeze({40, 80, 160, 320})}), starter = table.freeze({unlock = 0, upgrade = table.freeze({10, 20, 40, 80})})})
tbl_upv_1.DROPS = table.freeze(
    {
        xpPerShard = 5,
        pity = 6,
        goldenChance = 0.05,
        pityFill = 8,
        order = table.freeze({"drop", "victory", "golden"}),
        kinds = table.freeze(
            {
                drop = table.freeze({min = 4, stacks = 2, name = "Drop", max = 5}),
                victory = table.freeze({min = 5, stacks = 3, name = "Victory Drop", max = 7}),
                golden = table.freeze({min = 13, stacks = 4, name = "Golden Drop", max = 17, lockedStack = true}),
                tribe1 = table.freeze({min = 4, stacks = 2, name = "Tribe Chest", max = 5}),
                tribe2 = table.freeze({min = 5, stacks = 3, name = "Tribe Chest", max = 7}),
                tribe3 = table.freeze({min = 8, stacks = 3, name = "Tribe Chest", max = 10}),
                tribe4 = table.freeze({min = 9, stacks = 4, name = "Tribe Chest", max = 11}),
                tribe5 = table.freeze({min = 13, stacks = 4, name = "Tribe Chest", max = 17, lockedStack = true})
            }
        ),
        bonus = table.freeze({min = 4, max = 6}),
        weights = table.freeze({nearUnlock = 1.25, nearAt = 0.5, locked = 1.25, carried = 2, owned = 1}),
        first = table.freeze({item = "crossbow", drops = 3})
    }
)
function tbl_upv_1.IsKnown(a1)
    --[[
      name: IsKnown
      line: 131
      upvalues:
        Unlocks_upv_1 (copy, index: 1)
    ]]
    return Unlocks_upv_1.IsKnown(a1)
end
function tbl_upv_1.AllIds()
    --[[
      name: AllIds
      line: 135
      upvalues:
        Unlocks_upv_1 (copy, index: 1)
    ]]
    return Unlocks_upv_1.AllIds()
end
function tbl_upv_1.Size(a1)
    --[[
      name: Size
      line: 139
      upvalues:
        Unlocks_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local v1 = Unlocks_upv_1.SizeOf(a1)
    if tbl_upv_1.SIZES[v1] then
        return v1
    end
    return "medium"
end
local tbl_upv_2 = {}
function tbl_upv_1.Stat(a1)
    --[[
      name: Stat
      line: 146
      upvalues:
        tbl_upv_2 (copy, index: 1)
        u1 (ref,  index: 2)
        Unlocks_upv_1 (copy, index: 3)
    ]]
    if type(a1) ~= "string" then
        return false
    end
    local v2 = tbl_upv_2[a1]
    if v2 ~= nil then
        return v2
    end
    v2 = "damage"
    local v3 = u1 and (u1.Get(a1))
    if v3 then
        local v4 = v3.tuning or {}
        if v3.category == "armor" then
            v2 = "armor"
        elseif v3.category ~= "healing" then
            if type(v4.damage) == "number" and v4.damage > 0 or type(v4.splash) == "table" and (v4.splash.damage or 0) > 0 or type(v4.bees) == "table" and (v4.bees.damage or 0) > 0 or type(v4.burn) == "table" then
                v2 = "damage"
                tbl_upv_2[a1] = v2
                return v2
            end
            v2 = false
        else
            v2 = "healing"
        end
    else
        local v5 = Unlocks_upv_1.IsAmmo(a1)
        if v5 then
            v2 = false
        end
    end
    tbl_upv_2[a1] = v2
    return v2
end
function tbl_upv_1.MaxLevel(a1)
    --[[
      name: MaxLevel
      line: 177
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if tbl_upv_1.Stat(a1) then
        return tbl_upv_1.MAX_LEVEL
    end
    return 1
end
function tbl_upv_1.UnlockCost(a1)
    --[[
      name: UnlockCost
      line: 181
      upvalues:
        Unlocks_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if Unlocks_upv_1.IsStarter(a1) then
        return 0
    end
    return tbl_upv_1.SIZES[tbl_upv_1.Size(a1)].unlock
end
function tbl_upv_1.UpgradeCost(a1, a2)
    --[[
      name: UpgradeCost
      line: 188
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if type(a2) == "number" and not (a2 < 1) and not (tbl_upv_1.MaxLevel(a1) <= a2) then
        return tbl_upv_1.SIZES[tbl_upv_1.Size(a1)].upgrade[math.floor(a2)]
    end
    return nil
end
local function defaultLevel(a1)
    --[[
      name: defaultLevel
      line: 198
      upvalues:
        Unlocks_upv_1 (copy, index: 1)
    ]]
    if Unlocks_upv_1.IsStarter(a1) then
        return 1
    end
    return 0
end
function tbl_upv_1.Level(a1, a2)
    --[[
      name: Level
      line: 202
      upvalues:
        Unlocks_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if type(a2) ~= "string" then
        return 0
    end
    local v6 = (type(a1) == "table") and (a1[a2])
    local v7
    if type(v6) == "table" and type(v6.level) == "number" then
        v7 = math.floor(v6.level)
    else
        v7 = 0
    end
    local v8 = ((Unlocks_upv_1.IsStarter(a2)) and 1) or 0
    return (math.clamp(math.max(v7, v8), 0, tbl_upv_1.MaxLevel(a2)))
end
function tbl_upv_1.ShardsOf(a1, a2)
    --[[
      name: ShardsOf
      line: 211
    ]]
    local v9 = (type(a1) == "table") and ((type(a2) == "string") and (a1[a2]))
    local v10
    if type(v9) == "table" and type(v9.shards) == "number" and v9.shards == v9.shards then
        v10 = math.floor(v9.shards)
    else
        v10 = 0
    end
    return (math.max(0, v10))
end
function tbl_upv_1.Owns(a1, a2)
    --[[
      name: Owns
      line: 217
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v11 = tbl_upv_1.Level(a1, a2) >= 1
    return v11
end
function tbl_upv_1.Progress(a1, a2)
    --[[
      name: Progress
      line: 221
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v12 = tbl_upv_1.Level(a1, a2)
    local v13 = tbl_upv_1.ShardsOf(a1, a2)
    if v12 == 0 then
        return v13, tbl_upv_1.UnlockCost(a2), "unlock"
    end
    local v14 = tbl_upv_1.UpgradeCost(a2, v12)
    if v14 then
        return v13, v14, "upgrade"
    end
    return v13, 0, "max"
end
function tbl_upv_1.CanUpgrade(a1, a2)
    --[[
      name: CanUpgrade
      line: 234
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v15, v16, v17 = tbl_upv_1.Progress(a1, a2)
    return (v17 == "upgrade") and (v16 <= v15)
end
function tbl_upv_1.ReadyCount(a1)
    --[[
      name: ReadyCount
      line: 239
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v18 = 0
    for _, value_1 in tbl_upv_1.AllIds() do
        v18 = (tbl_upv_1.CanUpgrade(a1, value_1) and (v18 + 1)) or v18
    end
    return v18
end
function tbl_upv_1.ToMax(a1, a2)
    --[[
      name: ToMax
      line: 250
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v19 = tbl_upv_1.Level(a1, a2)
    local v20 = tbl_upv_1.MaxLevel(a2)
    if v20 <= v19 then
        return 0
    end
    local v21 = ((v19 ~= 0) and 0) or (tbl_upv_1.UnlockCost(a2))
    for n_1 = math.max(v19, 1), v20 - 1 do
        v21 = v21 + (tbl_upv_1.UpgradeCost(a2, n_1) or 0)
    end
    return (math.max(0, v21 - tbl_upv_1.ShardsOf(a1, a2)))
end
function tbl_upv_1.Bonus(a1)
    --[[
      name: Bonus
      line: 263
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if type(a1) == "number" and not (a1 <= 1) then
        return math.min(tbl_upv_1.BONUS_PER_LEVEL * (math.floor(a1) - 1), tbl_upv_1.BONUS_CAP) + 1
    end
    return 1
end
function tbl_upv_1.BonusText(a1, a2)
    --[[
      name: BonusText
      line: 270
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v22 = tbl_upv_1.Stat(a1)
    if v22 then
        return (("+%*%% %*"):format(math.floor(((tbl_upv_1.Bonus(a2) - 1) * 100) + 0.5), v22))
    end
    return ""
end
function tbl_upv_1.Set(a1, a2, a3, a4)
    --[[
      name: Set
      line: 283
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Unlocks_upv_1 (copy, index: 2)
    ]]
    local v23 = math.max(0, math.floor(a3))
    local v24 = math.clamp(math.floor(a4), 0, tbl_upv_1.MaxLevel(a2))
    local v25 = ((Unlocks_upv_1.IsStarter(a2)) and 1) or 0
    v24 = math.max(v24, v25)
    if v23 == 0 then
        local v26 = ((Unlocks_upv_1.IsStarter(a2)) and 1) or 0
        if v24 == v26 then
            a1[a2] = nil
            return
        end
    end
    a1[a2] = {shards = v23, level = v24}
end
function tbl_upv_1.Upgrade(a1, a2)
    --[[
      name: Upgrade
      line: 294
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if type(a2) == "string" and tbl_upv_1.IsKnown(a2) then
        local v27 = tbl_upv_1.Level(a1, a2)
        if v27 == 0 then
            return false, "Locked", nil
        end
        local v28 = tbl_upv_1.UpgradeCost(a2, v27)
        if not v28 then
            return false, "Max level", nil
        end
        local v29 = tbl_upv_1.ShardsOf(a1, a2)
        if v29 < v28 then
            return false, "Not enough shards", nil
        end
        tbl_upv_1.Set(a1, a2, v29 - v28, v27 + 1)
        return true, nil, v27 + 1
    end
    return false, "Unknown item", nil
end
local function carriedSet(a1)
    --[[
      name: carriedSet
      line: 317
    ]]
    local tbl_3 = {}
    if type(a1) == "table" then
        if type(a1.items) == "table" then
            for n_2 = 1, 16 do
                local v30 = a1.items[n_2]
                if type(v30) ~= "string" then
                    break
                else
                    tbl_3[v30] = true
                end
            end
        end
        if type(a1.armor) == "string" then
            tbl_3[a1.armor] = true
        end
    end
    return tbl_3
end
function tbl_upv_1.Pool(a1, a2)
    --[[
      name: Pool
      line: 339
      upvalues:
        tbl_upv_1 (copy, index: 1)
        carriedSet (copy, index: 2)
        Ranks_upv_1 (copy, index: 3)
    ]]
    local weights_1 = tbl_upv_1.DROPS.weights
    local v31 = carriedSet(a2 and (a2.loadout))
    local tbl_4 = {}
    local v32 = not (a2) or type(a2.rankBest) ~= "number" or a2.rankBest
    for _, value_2 in tbl_upv_1.AllIds() do
        local v33 = tbl_upv_1.Level(a1, value_2)
        if tbl_upv_1.MaxLevel(value_2) <= v33 then
            continue
        end
        if v33 ~= 0 or not (v32) or Ranks_upv_1.Allows(v32, value_2) then
            if v33 ~= 0 then
                local tbl_5 = {locked = false, frac = 0, weight = 0}
                tbl_5.item = value_2
                tbl_5.weight = weights_1.owned * (((not (v31[value_2])) and 1) or (weights_1.carried))
                table.insert(tbl_4, tbl_5)
            else
                local v34 = math.max(1, tbl_upv_1.UnlockCost(value_2))
                local v35 = math.min(1, tbl_upv_1.ShardsOf(a1, value_2) / v34)
                local tbl_6 = {locked = true, frac = 0, weight = 0}
                tbl_6.item = value_2
                tbl_6.weight = weights_1.locked * (((not (weights_1.nearAt <= v35)) and 1) or (weights_1.nearUnlock))
                tbl_6.frac = v35
                table.insert(tbl_4, tbl_6)
            end
        end
    end
    return tbl_4
end
local function weightedPick(a1, a2, a3, a4)
    --[[
      name: weightedPick
      line: 396
    ]]
    local v36 = 0
    for _, value_3 in a1 do
        if not (a2[value_3.item]) and (value_3.locked or not (a3)) then
            v36 = v36 + value_3.weight
        end
    end
    if v36 <= 0 then
        return nil
    end
    local v37 = a4:NextNumber() * v36
    v36 = nil
    for _, value_4 in a1 do
        if a2[value_4.item] then
            continue
        end
        if value_4.locked or not (a3) then
            v37 = v37 - value_4.weight
            if not (v37 < 0) then
                v36 = value_4
                continue
            end
            return value_4
        end
    end
    return v36
end
local function forcedPick(a1, a2, a3)
    --[[
      name: forcedPick
      line: 367
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local DROPS_1 = tbl_upv_1.DROPS
    if a3.first ~= true then
        if not (DROPS_1.pity <= (tonumber(a3.sinceUnlock) or 0)) then
            return nil, 0
        end
        local v38 = nil
        local v39 = math.huge
        for _, value_5 in a2 do
            if not (value_5.locked) then
                continue
            end
            local v40 = tbl_upv_1.UnlockCost(value_5.item) - tbl_upv_1.ShardsOf(a1, value_5.item)
            if not (v38) or v38.frac < value_5.frac or value_5.frac == v38.frac and v40 < v39 then
                v38, v39 = value_5, v40
            end
        end
        if v38 then
            local v41
            if v39 <= DROPS_1.pityFill then
                return v41, v39
            end
            return v41, 0
        end
        return nil, 0
    elseif DROPS_1.first then
        for _, value_6 in a2 do
            if value_6.item ~= DROPS_1.first.item or not (value_6.locked) then
                continue
            end
            local v42 = math.max(1, DROPS_1.first.drops - (tonumber(a3.total) or 0))
            return value_6, (math.ceil((tbl_upv_1.UnlockCost(value_6.item) - tbl_upv_1.ShardsOf(a1, value_6.item)) / v42))
        end
        if not (DROPS_1.pity <= (tonumber(a3.sinceUnlock) or 0)) then
            return nil, 0
        end
        local v38 = nil
        local v39 = math.huge
        for _, value_5 in a2 do
            if not (value_5.locked) then
                continue
            end
            local v40 = tbl_upv_1.UnlockCost(value_5.item) - tbl_upv_1.ShardsOf(a1, value_5.item)
            if not (v38) or v38.frac < value_5.frac or value_5.frac == v38.frac and v40 < v39 then
                v38, v39 = value_5, v40
            end
        end
        if v38 then
            if v39 <= DROPS_1.pityFill then
                return v38, v39
            end
            return v38, 0
        end
        return nil, 0
    else
        if not (DROPS_1.pity <= (tonumber(a3.sinceUnlock) or 0)) then
            return nil, 0
        end
        local v38 = nil
        local v39 = math.huge
        for _, value_5 in a2 do
            if not (value_5.locked) then
                continue
            end
            local v40 = tbl_upv_1.UnlockCost(value_5.item) - tbl_upv_1.ShardsOf(a1, value_5.item)
            if not (v38) or v38.frac < value_5.frac or value_5.frac == v38.frac and v40 < v39 then
                v38, v39 = value_5, v40
            end
        end
        if v38 then
            if v39 <= DROPS_1.pityFill then
                return v38, v39
            end
            return v38, 0
        end
        return nil, 0
    end
end
function tbl_upv_1.Roll(a1, a2, a3, a4)
    --[[
      name: Roll
      line: 422
      upvalues:
        tbl_upv_1 (copy, index: 1)
        forcedPick (copy, index: 2)
        weightedPick (copy, index: 3)
    ]]
    local DROPS_2 = tbl_upv_1.DROPS
    local v43 = a3 or {}
    local v44 = DROPS_2.kinds[a2] or (DROPS_2.kinds.drop)
    local tbl_7 = {}
    for _ = 1, v44.stacks do
        table.insert(tbl_7, {bonus = false, n = a4:NextInteger(v44.min, v44.max)})
    end
    if v43.mvp == true then
        table.insert(tbl_7, {bonus = true, n = a4:NextInteger(DROPS_2.bonus.min, DROPS_2.bonus.max)})
    end
    for _ = 1, math.clamp(math.floor(tonumber(v43.extra) or 0), 0, 5) do
        table.insert(tbl_7, {bonus = true, n = a4:NextInteger(DROPS_2.bonus.min, DROPS_2.bonus.max)})
    end
    local v45 = tbl_upv_1.Pool(a1, v43)
    local tbl_8 = {}
    local tbl_9 = {}
    local v46 = 0
    if type(v43.lead) == "table" then
        local v47 = nil
        for _, value_7 in v43.lead do
            v47 = (type(value_7) == "table") and (value_7.item)
            if type(v47) ~= "string" or not (tbl_upv_1.IsKnown(v47)) or tbl_8[v47] then
                continue
            end
            tbl_8[v47] = true
            local v48 = math.min(math.max(0, math.floor(tonumber(value_7.shards) or 0)), tbl_upv_1.ToMax(a1, v47))
            if v48 > 0 then
                table.insert(tbl_9, {item = v47, shards = v48})
            end
        end
    end
    local v47, v49, _, v49 = nil, nil, nil, nil
    for key_1, value_8 in tbl_7 do
        v47 = nil
        v49 = value_8.n
        if key_1 == 1 then
            local v50, v51 = forcedPick(a1, v45, v43)
            if not (v50) or tbl_8[v50.item] then
                v47 = (not (v44.lockedStack)) or (weightedPick(v45, tbl_8, true, a4)) or weightedPick(v45, tbl_8, false, a4)
                if not (v47) then
                    v46 = v46 + v49 * DROPS_2.xpPerShard
                    continue
                end
                tbl_8[v47.item] = true
                local v50 = tbl_upv_1.ToMax(a1, v47.item)
                if v50 < v49 then
                    v46 = v46 + (v49 - v50) * DROPS_2.xpPerShard
                    v49 = v50
                end
                if v49 > 0 then
                    local tbl_10 = {bonus = 0}
                    tbl_10.item = v47.item
                    tbl_10.shards = v49
                    tbl_10.bonus = ((value_8.bonus) and true) or nil
                    table.insert(tbl_9, tbl_10)
                    continue
                end
            end
            v47, v49 = v50, math.max(v49, v51)
        end
        if not (v47) then
            v47 = weightedPick(v45, tbl_8, false, a4)
        end
        if not (v47) then
            v46 = v46 + v49 * DROPS_2.xpPerShard
            continue
        end
        tbl_8[v47.item] = true
        local v50 = tbl_upv_1.ToMax(a1, v47.item)
        if v50 < v49 then
            v46 = v46 + (v49 - v50) * DROPS_2.xpPerShard
            v49 = v50
        end
        if v49 > 0 then
            local tbl_10 = {bonus = 0}
            tbl_10.item = v47.item
            tbl_10.shards = v49
            tbl_10.bonus = ((value_8.bonus) and true) or nil
            table.insert(tbl_9, tbl_10)
        end
    end
    return tbl_9, v46
end
function tbl_upv_1.Apply(a1, a2)
    --[[
      name: Apply
      line: 489
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local tbl_11 = {}
    local v52, v53 = nil, nil
    local v54 = nil
    local v55 = nil
    for _, value_9 in a2 do
        local item_1 = value_9.item
        local v56 = tbl_upv_1.Level(a1, item_1)
        local v57 = tbl_upv_1.ShardsOf(a1, item_1)
        if v56 ~= 0 then
            v54 = tbl_upv_1.UpgradeCost(item_1, v56) or 0
        else
            v54 = tbl_upv_1.UnlockCost(item_1)
        end
        local v58 = v57 + math.max(0, math.floor(value_9.shards))
        v52 = v56
        v53 = false
        if v56 ~= 0 then
            v55 = v58
            tbl_upv_1.Set(a1, item_1, v55, v52)
            local tbl_12 = {bonus = 0}
            tbl_12.item = item_1
            tbl_12.shards = value_9.shards
            tbl_12.before = v57
            tbl_12.after = v58
            tbl_12.need = v54
            tbl_12.levelBefore = v56
            tbl_12.level = v52
            tbl_12.unlocked = v53
            tbl_12.ready = tbl_upv_1.CanUpgrade(a1, item_1)
            tbl_12.bonus = value_9.bonus == true
            table.insert(tbl_11, tbl_12)
            continue
        end
        if v54 <= v58 then
            v52 = 1
            v55 = v58 - v54
            v53 = true
        else
            v55 = v58
        end
        tbl_upv_1.Set(a1, item_1, v55, v52)
        local tbl_12 = {bonus = 0}
        tbl_12.item = item_1
        tbl_12.shards = value_9.shards
        tbl_12.before = v57
        tbl_12.after = v58
        tbl_12.need = v54
        tbl_12.levelBefore = v56
        tbl_12.level = v52
        tbl_12.unlocked = v53
        tbl_12.ready = tbl_upv_1.CanUpgrade(a1, item_1)
        tbl_12.bonus = value_9.bonus == true
        table.insert(tbl_11, tbl_12)
    end
    return tbl_11
end
function tbl_upv_1.KindFor(a1, a2)
    --[[
      name: KindFor
      line: 520
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if a1 then
        if a2:NextNumber() < tbl_upv_1.DROPS.goldenChance then
            return "golden", true
        end
        return "victory", false
    end
    return "drop", false
end
local function revealRank(a1)
    --[[
      name: revealRank
      line: 530
    ]]
    if a1.unlocked then
        return 3
    elseif a1.levelBefore ~= 0 then
        if a1.ready then
            return 1
        end
        return 0
    else
        return 2
    end
end
function tbl_upv_1.Drop(a1, a2, a3, a4, a5)
    --[[
      name: Drop
      line: 546
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v59 = a4 or {}
    local tbl_13 = {first = 0, total = 0, mvp = 0, rankBest = 0, extra = 0, sinceUnlock = 0, loadout = 0, lead = 0}
    local v60
    if v59.mvp == true then
        v60 = true
    else
        v60 = false
    end
    tbl_13.mvp = v60
    tbl_13.total = a2.total or 0
    tbl_13.sinceUnlock = a2.sinceUnlock or 0
    tbl_13.first = a2.first == true
    tbl_13.loadout = v59.loadout
    tbl_13.extra = v59.extra
    tbl_13.rankBest = v59.rankBest
    tbl_13.lead = v59.lead
    local v61, v62 = tbl_upv_1.Roll(a1, a3, tbl_13, a5)
    local v63 = tbl_upv_1.Apply(a1, v61)
    local tbl_upv_14 = {}
    for key_2, value_10 in v63 do
        tbl_upv_14[value_10] = key_2
    end
    table.sort(
        v63,
        function(a6, a7)
            --[[
              line: 564
              upvalues:
                tbl_upv_14 (copy, index: 1)
            ]]
            local v64 = ((a6.unlocked) and 3) or (((a6.levelBefore == 0) and 2) or (((a6.ready) and 1) or 0))
            local v65 = ((a7.unlocked) and 3) or (((a7.levelBefore == 0) and 2) or (((a7.ready) and 1) or 0))
            if v64 == v65 then
                return tbl_upv_14[a6] < tbl_upv_14[a7]
            end
            return v64 < v65
        end
    )
    local v66 = false
    v59 = v66
    for _, value_11 in v63 do
        v59 = v59 or value_11.unlocked
    end
    a2.total = (a2.total or 0) + 1
    a2.sinceUnlock = (v59 and 0) or ((a2.sinceUnlock or 0) + 1)
    local first_1 = tbl_upv_1.DROPS.first
    if a2.first == true and (not (first_1) or not (tbl_upv_1.IsKnown(first_1.item)) or tbl_upv_1.Owns(a1, first_1.item)) then
        a2.first = false
    end
    return v63, v62, v59
end
function tbl_upv_1.Context(a1)
    --[[
      name: Context
      line: 700
    ]]
    local v68
    if type(a1) == "table" and type(a1.dropStats) == "table" then
        v68 = a1.dropStats
    else
        v68 = {}
    end
    local tbl_15 = {rankBest = 0, loadout = 0, first = 0}
    tbl_15.total = tonumber(v68.total) or 0
    tbl_15.sinceUnlock = tonumber(v68.sinceUnlock) or 0
    local v69
    if v68.first == true then
        v69 = true
    else
        v69 = false
    end
    tbl_15.first = v69
    if type(a1) ~= "table" then
        v69 = nil
    else
        v69 = a1.loadout
    end
    tbl_15.loadout = v69
    if type(a1) == "table" and type(a1.rankBest) == "number" then
        v69 = a1.rankBest
    else
        v69 = nil
    end
    tbl_15.rankBest = v69
    return tbl_15
end
local function inclusion(a1, a2, a3)
    --[[
      name: inclusion
      line: 593
      upvalues:
        tbl_upv_1 (copy, index: 1)
        forcedPick (copy, index: 2)
    ]]
    local DROPS_3 = tbl_upv_1.DROPS
    local v70 = DROPS_3.kinds[a2] or (DROPS_3.kinds.drop)
    local v71 = tbl_upv_1.Pool(a1, a3)
    local stacks_1 = v70.stacks
    local v72 = ((a3.mvp ~= true) and 0) or 1
    local v73 = #v71
    local v74 = table.create(v73, 0)
    local v75 = 0
    if v73 == 0 then
        return {}, 0
    end
    local v76 = forcedPick(a1, v71, a3)
    local v77 = 0
    if v76 then
        for key_3, value_12 in v71 do
            if value_12 == v76 then
                v77 = key_3
            end
        end
    end
    v76 = false
    for _, value_13 in v71 do
        v76 = v76 or value_13.locked
    end
    local function has_1(a4, a5)
        --[[
          name: has
          line: 618
        ]]
        local v80 = math.floor(a4 / (2 ^ (a5 - 1))) % 2 == 1
        return v80
    end
    if v73 > 50 then
        local v81 = Random.new(12345)
        local v82 = 0
        local tbl_16 = {}
        for key_4, value_14 in v71 do
            tbl_16[value_14.item] = key_4
        end
        for _ = 1, 20000 do
            local v84 = false
            for v96, value_15 in tbl_upv_1.Roll(a1, a2, a3, v81) do
                local v85 = tbl_16[value_15.item]
                if v85 then
                    v74[v85] = v74[v85] + 5e-05
                    v84 = v84 or v71[v85].locked
                end
            end
            v82 = (v84 and (v82 + 1)) or v82
            local v85
        end
        v75 = v82 / 20000
    else
        local v81 = {}
        v81[0] = 1
        local v87 = nil
        for n_3 = 1, math.min(stacks_1 + v72, v73) do
            local tbl_17 = {}
            for key_5, value_16 in v81 do
                v87 = false
                if n_3 == 1 then
                    v87 = false
                    if v70.lockedStack == true then
                        v87 = v76
                    end
                end
                if n_3 ~= 1 then
                    local v88 = 0
                    local v89 = v88
                    for key_6, value_17 in v71 do
                        local v90 = math.floor(key_5 / (2 ^ (key_6 - 1))) % 2 == 1
                        if not (v90) and (value_17.locked or not (v87)) then
                            v89 = v89 + value_17.weight
                        end
                    end
                    if not (v89 > 0) then
                        continue
                    end
                    for key_7, value_18 in v71 do
                        local v91 = math.floor(key_5 / (2 ^ (key_7 - 1))) % 2 == 1
                        if not (v91) and (value_18.locked or not (v87)) then
                            local v92 = key_5 + 2 ^ (key_7 - 1)
                            tbl_17[v92] = (tbl_17[v92] or 0) + ((value_16 * value_18.weight) / v89)
                        end
                    end
                else
                    if v77 > 0 then
                        tbl_17[2 ^ (v77 - 1)] = value_16
                        continue
                    end
                    local v88 = 0
                    local v89 = v88
                    for key_6, value_17 in v71 do
                        local v90 = math.floor(key_5 / (2 ^ (key_6 - 1))) % 2 == 1
                        if not (v90) and (value_17.locked or not (v87)) then
                            v89 = v89 + value_17.weight
                        end
                    end
                    if not (v89 > 0) then
                        continue
                    end
                    for key_7, value_18 in v71 do
                        local v91 = math.floor(key_5 / (2 ^ (key_7 - 1))) % 2 == 1
                        if not (v91) and (value_18.locked or not (v87)) then
                            local v92 = key_5 + 2 ^ (key_7 - 1)
                            tbl_17[v92] = (tbl_17[v92] or 0) + ((value_16 * value_18.weight) / v89)
                        end
                    end
                end
            end
            v81 = tbl_17
        end
        for key_8, value_19 in v81 do
            local v94 = false
            for key_9, value_20 in v71 do
                local v95 = math.floor(key_8 / (2 ^ (key_9 - 1))) % 2 == 1
                if v95 then
                    v74[key_9] = v74[key_9] + value_19
                    v95 = v94 or (value_20.locked)
                    v94 = v95
                end
            end
            v75 = (v94 and (v75 + value_19)) or v75
        end
    end
    has_1 = {}
    for key_10, value_21 in v71 do
        table.insert(has_1, {item = value_21.item, chance = math.clamp(v74[key_10], 0, 1), locked = value_21.locked})
    end
    table.sort(
        has_1,
        function(a6, a7)
            --[[
              line: 689
            ]]
            if math.abs(a6.chance - a7.chance) > 1e-09 then
                return a7.chance < a6.chance
            end
            return a6.item < a7.item
        end
    )
    return has_1, (math.clamp(v75, 0, 1))
end
function tbl_upv_1.Odds(a1, a2, a3)
    --[[
      name: Odds
      line: 711
      upvalues:
        tbl_upv_1 (copy, index: 1)
        inclusion (copy, index: 2)
    ]]
    local DROPS_4 = tbl_upv_1.DROPS
    local tbl_18 = {}
    for _, value_22 in DROPS_4.order do
        local v96 = DROPS_4.kinds[value_22]
        local tbl_19 = {lockedStack = 0}
        tbl_19.kind = value_22
        tbl_19.name = v96.name
        tbl_19.stacks = v96.stacks
        tbl_19.min = v96.min
        tbl_19.max = v96.max
        tbl_19.lockedStack = v96.lockedStack == true
        table.insert(tbl_18, tbl_19)
    end
    local tbl_20 = {}
    tbl_20.kinds = tbl_18
    tbl_20.bonus = {min = DROPS_4.bonus.min, max = DROPS_4.bonus.max}
    tbl_20.goldenChance = DROPS_4.goldenChance
    tbl_20.pity = DROPS_4.pity
    if a1 ~= nil and type(a2) == "string" and DROPS_4.kinds[a2] then
        local v97, v98 = inclusion(a1, a2, a3 or {})
        tbl_20.kind = a2
        tbl_20.items = v97
        tbl_20.lockedChance = v98
    end
    return tbl_20
end
function tbl_upv_1.LevelsFor(a1, a2)
    --[[
      name: LevelsFor
      line: 736
      upvalues:
        carriedSet (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local tbl_21 = {}
    for key_11 in carriedSet(a2) do
        if tbl_upv_1.IsKnown(key_11) then
            tbl_21[key_11] = math.max(1, tbl_upv_1.Level(a1, key_11))
        end
    end
    return tbl_21
end
local u2 = nil
local function catalogue()
    --[[
      name: catalogue
      line: 750
      upvalues:
        u2 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local v99 = u2
    if v99 then
        return v99
    end
    local v100 = tbl_upv_1.AllIds()
    local tbl_22 = {}
    for key_12, value_23 in v100 do
        tbl_22[value_23] = key_12
    end
    local tbl_23 = {}
    tbl_23.ids = v100
    tbl_23.index = tbl_22
    u2 = tbl_23
    return tbl_23
end
local function base36(a1)
    --[[
      name: base36
      line: 766
    ]]
    local v101 = ""
    v101 = nil
    repeat
        local v102 = a1 % 36
        v101 = string.sub("0123456789abcdefghijklmnopqrstuvwxyz", v102 + 1, v102 + 1) .. v101
        a1 = a1 // 36
    until a1 == 0
    return v101
end
function tbl_upv_1.EncodeLevels(a1)
    --[[
      name: EncodeLevels
      line: 776
      upvalues:
        catalogue (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local v103 = catalogue()
    local tbl_24 = {}
    if type(a1) == "table" then
        for key_13, value_24 in a1 do
            local v104 = (type(key_13) == "string") and (v103.index[key_13])
            if not (v104) or type(value_24) ~= "number" or not (value_24 >= 2) then
                continue
            end
            local tbl_25 = {s = 0}
            tbl_25.i = v104
            local v105 = ""
            local v106 = v104
            repeat
                local v107 = v106 % 36
                v105 = string.sub("0123456789abcdefghijklmnopqrstuvwxyz", v107 + 1, v107 + 1) .. v105
                v106 = v106 // 36
            until v106 == 0
            tbl_25.s = ("%*=%*"):format(v105, math.clamp(math.floor(value_24), 2, tbl_upv_1.MAX_LEVEL))
            table.insert(tbl_24, tbl_25)
        end
    end
    table.sort(
        tbl_24,
        function(a2, a3)
            --[[
              line: 787
            ]]
            return a2.i < a3.i
        end
    )
    local tbl_26 = {}
    local v109 = 0
    for _, value_25 in tbl_24 do
        if (v109 + #value_25.s) + 1 > 51 then
            break
        else
            v109 = v109 + (#value_25.s + 1)
            table.insert(tbl_26, value_25.s)
        end
    end
    return table.concat(tbl_26, ",")
end
local tbl_upv_27 = {}
local u3 = 0
function tbl_upv_1.DecodeLevels(a1)
    --[[
      name: DecodeLevels
      line: 805
      upvalues:
        tbl_upv_27 (copy, index: 1)
        catalogue (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
        u3 (ref,  index: 4)
    ]]
    if type(a1) ~= "string" or a1 == "" then
        return {}
    end
    local v110 = tbl_upv_27[a1]
    if v110 then
        return v110
    end
    local v111 = catalogue()
    local tbl_28 = {}
    for key_14, value_26 in string.gmatch(a1, "(%w+)=(%d+)") do
        local num_1 = tonumber(key_14, 36)
        local v112 = num_1 and (v111.ids[num_1])
        if v112 then
            tbl_28[v112] = math.clamp(tonumber(value_26) or 1, 1, tbl_upv_1.MAX_LEVEL)
        end
    end
    table.freeze(tbl_28)
    if u3 > 256 then
        table.clear(tbl_upv_27)
        u3 = 0
    end
    tbl_upv_27[a1] = tbl_28
    u3 = u3 + 1
    return tbl_28
end
return tbl_upv_1