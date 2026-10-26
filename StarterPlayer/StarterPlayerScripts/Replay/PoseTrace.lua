local CollectionService_upv_1 = game:GetService("CollectionService")
local Players_upv_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local Workspace_upv_1 = game:GetService("Workspace")
local tbl_1 = {}
local tbl_upv_2 = {"Root", "Waist", "Neck", "RightShoulder", "RightElbow", "LeftShoulder", "LeftElbow", "RightHip", "RightKnee", "LeftHip", "LeftKnee"}
local tbl_upv_3 = {}
local u1 = false
local u2 = nil
local u3 = setmetatable({}, {__mode = "k"})
local function jointsOf(a1)
    --[[
      name: jointsOf
      line: 23
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local tbl_4 = {}
    for _, value_1 in a1:GetDescendants() do
        if (value_1:IsA("Motor6D") or value_1:IsA("AnimationConstraint")) and table.find(tbl_upv_2, value_1.Name) then
            tbl_4[value_1.Name] = value_1
        end
    end
    return tbl_4
end
local function sample(a1)
    --[[
      name: sample
      line: 35
      upvalues:
        u3 (copy, index: 1)
        jointsOf (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
    ]]
    local v1 = u3[a1]
    if not (v1) then
        local v2 = jointsOf(a1)
        u3[a1] = v2
        v1 = v2
    end
    local v3 = table.create(#tbl_upv_2, CFrame.identity)
    for key_1, value_2 in tbl_upv_2 do
        local v4 = v1[value_2]
        if not (v4) then
            continue
        end
        if v4.Parent then
            v3[key_1] = v4.Transform
        end
    end
    return v3
end
tbl_1.Sample = sample
local function fighters()
    --[[
      name: fighters
      line: 52
      upvalues:
        CollectionService_upv_1 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
    ]]
    local tbl_5 = {}
    local tbl_6 = {}
    for _, value_3 in CollectionService_upv_1:GetTagged("Combatant") do
        if not (value_3:IsA("Model")) then
            continue
        end
        if not (tbl_6[value_3]) then
            tbl_6[value_3] = true
            table.insert(tbl_5, value_3)
        end
    end
    for _, value_4 in Players_upv_1:GetPlayers() do
        local Character_1 = value_4.Character
        if not (Character_1) then
            continue
        end
        if not (tbl_6[Character_1]) then
            tbl_6[Character_1] = true
            table.insert(tbl_5, Character_1)
        end
    end
    return tbl_5
end
function tbl_1.Start()
    --[[
      name: Start
      line: 70
      upvalues:
        u1 (ref,  index: 1)
        RunService_upv_1 (copy, index: 2)
        tbl_upv_3 (copy, index: 3)
        u2 (ref,  index: 4)
        Workspace_upv_1 (copy, index: 5)
        fighters (copy, index: 6)
        sample (copy, index: 7)
    ]]
    if (u1) or not RunService_upv_1:IsStudio() then
        return
    end
    u1 = true
    table.clear(tbl_upv_3)
    local v5 = RunService_upv_1.PreRender:Connect(
        function()
            --[[
              line: 77
              upvalues:
                Workspace_upv_1 (copy, index: 1)
                fighters (copy, index: 2)
                tbl_upv_3 (copy, index: 3)
                sample (copy, index: 4)
            ]]
            local v6 = Workspace_upv_1:GetServerTimeNow()
            for _, value_5 in fighters() do
                local v7 = value_5:GetAttribute("CombatantId")
                if type(v7) ~= "string" or v7 == "" or value_5:GetAttribute("ReplayPuppet") ~= nil then
                    continue
                end
                local v8 = tbl_upv_3[v7]
                if not (v8) then
                    v8 = {t = {}, q = {}}
                    tbl_upv_3[v7] = v8
                end
                table.insert(v8.t, v6)
                table.insert(v8.q, (sample(value_5)))
                while #v8.t > 0 do
                    if v6 - v8.t[1] > 30 then
                        table.remove(v8.t, 1)
                        table.remove(v8.q, 1)
                        continue
                    else
                        break
                    end
                end
            end
        end
    )
    u2 = v5
end
function tbl_1.Stop()
    --[[
      name: Stop
      line: 99
      upvalues:
        u1 (ref, index: 1)
        u2 (ref, index: 2)
    ]]
    u1 = false
    if not u2 then
        return
    end
    u2:Disconnect()
    u2 = nil
end
function tbl_1.Active()
    --[[
      name: Active
      line: 107
      upvalues:
        u1 (ref, index: 1)
    ]]
    return u1
end
local function angleOf(a1)
    --[[
      name: angleOf
      line: 129
    ]]
    local _, v9 = a1:ToAxisAngle()
    return (math.deg(math.abs(v9)))
end
local tbl_upv_7 = {0, 0.05, 0.1, 0.15, 0.2, 0.3}
local tbl_upv_8 = {}
function tbl_1.Reset()
    --[[
      name: Reset
      line: 140
      upvalues:
        tbl_upv_8 (copy, index: 1)
    ]]
    table.clear(tbl_upv_8)
end
local function liveAt(a1, a2)
    --[[
      name: liveAt
      line: 111
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    local v10 = tbl_upv_3[a1]
    if not v10 or #v10.t == 0 or a2 < v10.t[1] or v10.t[#v10.t] < a2 then
        return nil
    end
    local v11 = 1
    local v12 = #v10.t
    while v12 - v11 > 1 do
        local v13 = (v11 + v12) // 2
        if v10.t[v13] <= a2 then
            v11 = v13
        else
            v12 = v13
        end
    end
    if math.abs(v10.t[v11] - a2) <= math.abs(v10.t[v12] - a2) then
        return v10.q[v11]
    end
    return v10.q[v12]
end
function tbl_1.Compare(a1, a2, a3)
    --[[
      name: Compare
      line: 144
      upvalues:
        sample (copy, index: 1)
        tbl_upv_8 (copy, index: 2)
        tbl_upv_7 (copy, index: 3)
        tbl_upv_2 (copy, index: 4)
        liveAt (copy, index: 5)
    ]]
    local v14 = sample(a2)
    local v15 = tbl_upv_8[a1]
    if not (v15) then
        local tbl_9 = {}
        for key_2 in tbl_upv_7 do
            tbl_9[key_2] = {n = 0, sum = table.create(#tbl_upv_2, 0), max = table.create(#tbl_upv_2, 0), dead = table.create(#tbl_upv_2, 0)}
        end
        tbl_upv_8[a1] = tbl_9
        v15 = tbl_9
    end
    for key_3, value_6 in tbl_upv_7 do
        local v16 = liveAt(a1, a3 + value_6)
        if not (v16) then
            continue
        end
        local v17 = v15[key_3]
        v17.n = v17.n + 1
        for n_1 = 1, #tbl_upv_2 do
            local _, v18 = (v14[n_1]:Inverse() * v16[n_1]):ToAxisAngle()
            local v19 = math.deg(math.abs(v18))
            local sum_1 = v17.sum
            sum_1[n_1] = sum_1[n_1] + v19
            v17.max[n_1] = math.max(v17.max[n_1], v19)
            local v22, v20 = v14[n_1]:ToAxisAngle()
            if not (math.deg(math.abs(v20)) < 0.05) then
                continue
            end
            local v23, v21 = v16[n_1]:ToAxisAngle()
            if math.deg(math.abs(v21)) > 3 then
                local dead_1 = v17.dead
                dead_1[n_1] = dead_1[n_1] + 1
            end
        end
    end
end
function tbl_1.BestMatch(a1, a2, a3, a4)
    --[[
      name: BestMatch
      line: 174
      upvalues:
        tbl_upv_3 (copy, index: 1)
        sample (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
    ]]
    local v22 = tbl_upv_3[a1]
    if not v22 then
        return nil, nil, nil
    end
    local v23 = sample(a2)
    local v24 = nil
    local v25 = math.huge
    local v26 = nil
    local v27 = nil
    v24, v26 = v24, v26
    for key_4, value_7 in v22.t do
        if not (a3 <= value_7) or not (value_7 <= a4) then
            continue
        end
        local v28 = v22.q[key_4]
        v27 = 0
        local tbl_10 = {}
        for key_5, value_8 in tbl_upv_2 do
            local _, v29 = (v23[key_5]:Inverse() * v28[key_5]):ToAxisAngle()
            local v30 = math.deg(math.abs(v29))
            tbl_10[value_8] = math.floor((v30 * 10) + 0.5) / 10
            v27 = v27 + v30
        end
        if v27 / #tbl_upv_2 < v25 then
            v25, v24, v26 = v27 / #tbl_upv_2, value_7, tbl_10
        end
    end
    local v31
    if v24 then
        v31 = v25
    else
        v31 = nil
    end
    return v24, v31, v26
end
function tbl_1.Report()
    --[[
      name: Report
      line: 199
      upvalues:
        tbl_upv_8 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        tbl_upv_7 (copy, index: 3)
        tbl_upv_3 (copy, index: 4)
    ]]
    local tbl_11 = {}
    for key_6, value_9 in tbl_upv_8 do
        local v32 = nil
        local v33 = math.huge
        for key_7, value_10 in value_9 do
            if not (value_10.n > 0) then
                continue
            end
            local v34 = 0
            for n_2 = 1, #tbl_upv_2 do
                v34 = v34 + value_10.sum[n_2] / value_10.n
            end
            if v34 / #tbl_upv_2 < v33 then
                v33, v32 = v34 / #tbl_upv_2, key_7
            end
        end
        if not (v32) then
            continue
        end
        local v35 = value_9[v32]
        local tbl_12 = {}
        for key_8, value_11 in tbl_upv_2 do
            tbl_12[value_11] = string.format("mean %.1f max %.1f dead %d%%", v35.sum[key_8] / v35.n, v35.max[key_8], math.floor((v35.dead[key_8] * 100) / v35.n))
        end
        tbl_11[key_6] = {frames = v35.n, offset = tbl_upv_7[v32], meanDeg = v33, joints = tbl_12}
    end
    local tbl_13 = {}
    for key_9, value_12 in tbl_upv_3 do
        tbl_13[key_9] = #value_12.t
    end
    tbl_11._traced = tbl_13
    return tbl_11
end
return tbl_1