local v1 = {
    WIN = 30,
    LOSS = -30,
    CLIMB_FROM = 400,
    WIN_FALL = 200,
    LOSS_RISE = 90,
    WIN_MIN = 12,
    LOSS_MAX = -60,
    GATE_TOP = 4,
    START = 1792195200,
    PER_DAY_MAX = 150,
    LADDER = table.freeze(
        {
            table.freeze({id = "bronze", name = "Bronze", trophies = 0, items = table.freeze({})}),
            table.freeze({id = "silver", name = "Silver", trophies = 60, items = table.freeze({"harpoon", "beehive", "longbow"})}),
            table.freeze({id = "gold", name = "Gold", trophies = 200, items = table.freeze({"twin_hatchets", "bronze_armor", "musket"})}),
            table.freeze({id = "platinum", name = "Platinum", trophies = 400, items = table.freeze({"gauntlets", "katana"})}),
            table.freeze({id = "diamond", name = "Diamond", trophies = 700, items = table.freeze({"scythe"})}),
            table.freeze({id = "master", name = "Master", trophies = 1100, items = table.freeze({})}),
            table.freeze({id = "grandmaster", name = "Grandmaster", trophies = 1600, items = table.freeze({})}),
            table.freeze({id = "immortal", name = "Immortal", trophies = 2200, items = table.freeze({})})
        }
    )
}
local v2 = {}

for v3, v4 in v1.LADDER do
    for _, item in v4.items do
        v2[item] = v3
    end
end

local function num(a8, a9)
    --[[
      name: num
      line: 85
    ]]
    if type(a8) == "number" and a8 == a8 and a8 ~= math.huge and a8 ~= -math.huge then
        return a8
    end

    return a9
end

function v1.Count()
    --[[
      name: Count
      line: 89
      upvalues:
        v1 (copy, index: 1)
    ]]
    return #v1.LADDER
end

function v1.Get(a10)
    --[[
      name: Get
      line: 93
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v11

    if type(a10) ~= "number" or a10 ~= a10 or a10 == math.huge or a10 == -math.huge then
        v11 = 1
    else
        v11 = a10
    end

    local clampedValue = math.clamp(math.floor(v11), 1, #v1.LADDER)

    return v1.LADDER[clampedValue]
end

function v1.RankOf(a13)
    --[[
      name: RankOf
      line: 98
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v14

    if type(a13) ~= "number" or a13 ~= a13 or a13 == math.huge or a13 == -math.huge then
        v14 = 0
    else
        v14 = a13
    end

    local v15 = 1

    for v16, v17 in v1.LADDER do
        if v17.trophies <= v14 then
            v15 = v16
        end
    end

    return v15
end

function v1.Floor(a18)
    --[[
      name: Floor
      line: 109
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v19
    local get = v1.Get

    if type(a18) ~= "number" or a18 ~= a18 or a18 == math.huge or a18 == -math.huge then
        v19 = 1
    else
        v19 = a18
    end

    return get((math.min(math.floor(v19), v1.GATE_TOP))).trophies
end

function v1.Steps(a21)
    --[[
      name: Steps
      line: 113
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v22

    if type(a21) ~= "number" or a21 ~= a21 or a21 == math.huge or a21 == -math.huge then
        v22 = 0
    else
        v22 = a21
    end

    local v23 = math.max(0, v22 - v1.CLIMB_FROM)

    return math.max(v1.WIN_MIN, (math.floor((v1.WIN - (v23 / v1.WIN_FALL)) + 0.5))), (math.max(v1.LOSS_MAX, -math.floor((-v1.LOSS + (v23 / v1.LOSS_RISE)) + 0.5)))
end

function v1.Apply(a24, a25, a26, a27)
    --[[
      name: Apply
      line: 124
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v28

    if type(a24) ~= "number" or a24 ~= a24 or a24 == math.huge or a24 == -math.huge then
        v28 = 0
    else
        v28 = a24
    end

    local v29 = math.max(0, (math.floor(v28)))

    if type(a25) ~= "number" or a25 ~= a25 or a25 == math.huge or a25 == -math.huge then
        v28 = 1
    else
        v28 = a25
    end

    local v30 = math.max(math.clamp(math.floor(v28), 1, #v1.LADDER), v1.RankOf(v29))

    if a26 == nil then
        return v29, 0, v30, false
    end

    local v31, v32
    local v33
    v31, v32 = v1.Steps(v29)

    if type(a27) ~= "number" or a27 ~= a27 or a27 == math.huge or a27 == -math.huge then
        v33 = 1
    else
        v33 = a27
    end

    if v33 ~= 1 then
        v31 = math.max(1, (math.floor((v31 * v33) + 0.5)))
        v32 = math.floor((v32 * v33) + 0.5)
    end

    local v34 = if a26 then v31 else v32
    local v35 = v29 + v34
    local v36 = math.max(v35, v1.Floor(v30), 0)
    local v37 = math.max(v30, v1.RankOf(v36))
    local v38 = v36 - v29
    local v39 = not a26 and v35 < v36
    return v36, v38, v37, v39
end

function v1.ItemRank(key)
    --[[
      name: ItemRank
      line: 144
      upvalues:
        v2 (copy, index: 1)
    ]]
    if type(key) ~= "string" then
        return 1
    end

    return v2[key] or 1
end

function v1.Allows(a41, a42)
    --[[
      name: Allows
      line: 148
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v43
    local v44 = v1.ItemRank(a42)

    if type(a41) ~= "number" or a41 ~= a41 or a41 == math.huge or a41 == -math.huge then
        v43 = 1
    else
        v43 = a41
    end

    return v44 <= math.floor(v43)
end

function v1.NewItems(a45, a46)
    --[[
      name: NewItems
      line: 152
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v47
    local v48
    local v49 = {}

    if type(a45) ~= "number" or a45 ~= a45 or a45 == math.huge or a45 == -math.huge then
        v47 = 1
    else
        v47 = a45
    end

    local flooredValue = math.floor(v47)

    if type(a46) ~= "number" or a46 ~= a46 or a46 == math.huge or a46 == -math.huge then
        v48 = 1
    else
        v48 = a46
    end

    local flooredValue2 = math.floor(v48)

    for index = math.max(1, flooredValue + 1), math.min(#v1.LADDER, flooredValue2) do
        for _, item in v1.LADDER[index].items do
            table.insert(v49, item)
        end
    end

    return v49
end

function v1.Progress(a55)
    --[[
      name: Progress
      line: 164
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v56

    if type(a55) ~= "number" or a55 ~= a55 or a55 == math.huge or a55 == -math.huge then
        v56 = 0
    else
        v56 = a55
    end

    local v57 = math.max(0, v56)
    local v58 = v1.RankOf(v57)
    local v59 = v1.LADDER[v58]
    local v60 = v1.LADDER[v58 + 1]
    local v61 = v57 - v59.trophies

    if v60 then
        return v58, v61, v60.trophies - v59.trophies
    end

    return v58, v61, nil
end

function v1.PlausibleMax(a62)
    --[[
      name: PlausibleMax
      line: 172
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v63
    local start = v1.START

    if type(a62) ~= "number" or a62 ~= a62 or a62 == math.huge or a62 == -math.huge then
        v63 = start
    else
        v63 = a62
    end

    return (math.floor((math.max(0, (v63 - v1.START) / 86400) + 1) * v1.PER_DAY_MAX))
end

v1.REWARD_GOLDEN_FROM = 5
v1.LEAD = 0.2

function v1.Lead(a65: number, a66)
    --[[
      name: Lead
      line: 189
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v67 = math.max(0, (math.floor(a65)))
    return (math.max(0, (math.min(math.ceil(v67 * v1.LEAD), (v67 - math.max(0, (math.floor((a66 or 0))))) - 1))))
end

function v1.RewardKind(a68)
    --[[
      name: RewardKind
      line: 194
      upvalues:
        v1 (copy, index: 1)
    ]]
    if v1.REWARD_GOLDEN_FROM <= a68 then
        return "golden"
    end

    return "victory"
end

return table.freeze(v1)