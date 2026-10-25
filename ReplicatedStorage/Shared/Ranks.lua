local tbl_upv_1 = {}
tbl_upv_1.WIN = 30
tbl_upv_1.LOSS = -30
tbl_upv_1.CLIMB_FROM = 400
tbl_upv_1.WIN_FALL = 200
tbl_upv_1.LOSS_RISE = 90
tbl_upv_1.WIN_MIN = 12
tbl_upv_1.LOSS_MAX = -60
tbl_upv_1.GATE_TOP = 4
tbl_upv_1.START = 1792195200
tbl_upv_1.PER_DAY_MAX = 150
tbl_upv_1.LADDER = table.freeze(
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
local tbl_upv_2 = {}
for key_1, value_1 in tbl_upv_1.LADDER do
    for _, value_2 in value_1.items do
        tbl_upv_2[value_2] = key_1
    end
end
local function num(a1, a2)
    --[[
      name: num
      line: 85
    ]]
    if type(a1) == "number" and a1 == a1 and a1 ~= math.huge and a1 ~= -math.huge then
        return a1
    end
    return a2
end
function tbl_upv_1.Count()
    --[[
      name: Count
      line: 89
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return #tbl_upv_1.LADDER
end
function tbl_upv_1.Get(a1)
    --[[
      name: Get
      line: 93
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v1
    if type(a1) ~= "number" or a1 ~= a1 or a1 == math.huge or a1 == -math.huge then
        v1 = 1
    else
        v1 = a1
    end
    return tbl_upv_1.LADDER[math.clamp(math.floor(v1), 1, #tbl_upv_1.LADDER)]
end
function tbl_upv_1.RankOf(a1)
    --[[
      name: RankOf
      line: 98
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v2
    if type(a1) ~= "number" or a1 ~= a1 or a1 == math.huge or a1 == -math.huge then
        v2 = 0
    else
        v2 = a1
    end
    local v3 = 1
    for key_2, value_3 in tbl_upv_1.LADDER do
        if value_3.trophies <= v2 then
            v3 = key_2
        end
    end
    return v3
end
function tbl_upv_1.Floor(a1)
    --[[
      name: Floor
      line: 109
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local Get_1 = tbl_upv_1.Get
    local v4
    if type(a1) ~= "number" or a1 ~= a1 or a1 == math.huge or a1 == -math.huge then
        v4 = 1
    else
        v4 = a1
    end
    return Get_1(math.min(math.floor(v4), tbl_upv_1.GATE_TOP)).trophies
end
function tbl_upv_1.Steps(a1)
    --[[
      name: Steps
      line: 113
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v5
    if type(a1) ~= "number" or a1 ~= a1 or a1 == math.huge or a1 == -math.huge then
        v5 = 0
    else
        v5 = a1
    end
    local v6 = math.max(0, v5 - tbl_upv_1.CLIMB_FROM)
    return math.max(tbl_upv_1.WIN_MIN, math.floor((tbl_upv_1.WIN - (v6 / tbl_upv_1.WIN_FALL)) + 0.5)), (math.max(tbl_upv_1.LOSS_MAX, -math.floor((-tbl_upv_1.LOSS + (v6 / tbl_upv_1.LOSS_RISE)) + 0.5)))
end
function tbl_upv_1.Apply(a1, a2, a3, a4)
    --[[
      name: Apply
      line: 124
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v7
    if type(a1) ~= "number" or a1 ~= a1 or a1 == math.huge or a1 == -math.huge then
        v7 = 0
    else
        v7 = a1
    end
    local v8 = math.max(0, math.floor(v7))
    if type(a2) ~= "number" or a2 ~= a2 or a2 == math.huge or a2 == -math.huge then
        v7 = 1
    else
        v7 = a2
    end
    local v9 = math.max(math.clamp(math.floor(v7), 1, #tbl_upv_1.LADDER), tbl_upv_1.RankOf(v8))
    if a3 == nil then
        return v8, 0, v9, false
    end
    local v10, v11 = tbl_upv_1.Steps(v8)
    local v12
    if type(a4) ~= "number" or a4 ~= a4 or a4 == math.huge or a4 == -math.huge then
        v12 = 1
    else
        v12 = a4
    end
    if v12 ~= 1 then
        v10, v7 = math.max(1, math.floor((v10 * v12) + 0.5)), math.floor((v11 * v12) + 0.5)
    end
    local v14
    if a3 then
        v14 = v10
    else
        v14 = v7
    end
    local v15 = v8 + v14
    v10 = math.max(v15, tbl_upv_1.Floor(v9), 0)
    local v16 = math.max(v9, tbl_upv_1.RankOf(v10))
    return v10, v10 - v8, v16, not a3 and (v15 < v10)
end
function tbl_upv_1.ItemRank(a1)
    --[[
      name: ItemRank
      line: 144
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    if type(a1) ~= "string" then
        return 1
    end
    return tbl_upv_2[a1] or 1
end
function tbl_upv_1.Allows(a1, a2)
    --[[
      name: Allows
      line: 148
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v17 = tbl_upv_1.ItemRank(a2)
    local v18
    if type(a1) ~= "number" or a1 ~= a1 or a1 == math.huge or a1 == -math.huge then
        v18 = 1
    else
        v18 = a1
    end
    local v19
    if v17 <= math.floor(v18) then
        v19 = true
    else
        v19 = false
    end
    return v19
end
function tbl_upv_1.NewItems(a1, a2)
    --[[
      name: NewItems
      line: 152
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local tbl_3 = {}
    local v20
    if type(a1) ~= "number" or a1 ~= a1 or a1 == math.huge or a1 == -math.huge then
        v20 = 1
    else
        v20 = a1
    end
    local v21 = math.floor(v20)
    local v22
    if type(a2) ~= "number" or a2 ~= a2 or a2 == math.huge or a2 == -math.huge then
        v22 = 1
    else
        v22 = a2
    end
    local v23 = math.floor(v22)
    for n_1 = math.max(1, v21 + 1), math.min(#tbl_upv_1.LADDER, v23) do
        for _, value_4 in tbl_upv_1.LADDER[n_1].items do
            table.insert(tbl_3, value_4)
        end
    end
    return tbl_3
end
function tbl_upv_1.Progress(a1)
    --[[
      name: Progress
      line: 164
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v24
    if type(a1) ~= "number" or a1 ~= a1 or a1 == math.huge or a1 == -math.huge then
        v24 = 0
    else
        v24 = a1
    end
    local v25 = math.max(0, v24)
    local v26 = tbl_upv_1.RankOf(v25)
    local v27 = tbl_upv_1.LADDER[v26]
    local v28 = tbl_upv_1.LADDER[v26 + 1]
    local v29 = v25 - v27.trophies
    if v28 then
        return v26, v29, v28.trophies - v27.trophies
    end
    return v26, v29, nil
end
function tbl_upv_1.PlausibleMax(a1)
    --[[
      name: PlausibleMax
      line: 172
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local START_1 = tbl_upv_1.START
    local v30
    if type(a1) ~= "number" or a1 ~= a1 or a1 == math.huge or a1 == -math.huge then
        v30 = START_1
    else
        v30 = a1
    end
    return (math.floor((math.max(0, (v30 - tbl_upv_1.START) / 86400) + 1) * tbl_upv_1.PER_DAY_MAX))
end
tbl_upv_1.REWARD_GOLDEN_FROM = 5
tbl_upv_1.LEAD = 0.2
function tbl_upv_1.Lead(a1, a2)
    --[[
      name: Lead
      line: 189
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v31 = math.max(0, math.floor(a1))
    return (math.max(0, math.min(math.ceil(v31 * tbl_upv_1.LEAD), (v31 - math.max(0, math.floor(a2 or 0))) - 1)))
end
function tbl_upv_1.RewardKind(a1)
    --[[
      name: RewardKind
      line: 194
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if tbl_upv_1.REWARD_GOLDEN_FROM <= a1 then
        return "golden"
    end
    return "victory"
end
return table.freeze(tbl_upv_1)