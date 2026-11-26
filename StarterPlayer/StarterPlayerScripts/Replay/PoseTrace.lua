local collectionService = game:GetService("CollectionService")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local v5 = {}
local v6 = {"Root", "Waist", "Neck", "RightShoulder", "RightElbow", "LeftShoulder", "LeftElbow", "RightHip", "RightKnee", "LeftHip", "LeftKnee"}
local v7 = {}
local v8 = false
local preRenderConnection = nil

local function jointsOf(key)
    --[[
      name: jointsOf
      line: 23
      upvalues:
        v6 (copy, index: 1)
    ]]
    local v12 = {}

    for _, descendant in key:GetDescendants() do
        if descendant:IsA("Motor6D") or descendant:IsA("AnimationConstraint") then
            if table.find(v6, descendant.Name) then
                v12[descendant.Name] = descendant
            end
        end
    end

    return v12
end

local v15 = setmetatable({}, {__mode = "k"})

local function sample(key)
    --[[
      name: sample
      line: 35
      upvalues:
        v15 (copy, index: 1)
        jointsOf (copy, index: 2)
        v6 (copy, index: 3)
    ]]
    local v18 = v15[key]
    if not v18 then
        v18 = jointsOf(key)
        v15[key] = v18
    end

    local values = table.create(#v6, CFrame.identity)

    for valueKey, v21 in v6 do
        local v22 = v18[v21]

        if v22 and v22.Parent then
            values[valueKey] = v22.Transform
        end
    end

    return values
end

v5.Sample = sample

local function fighters()
    --[[
      name: fighters
      line: 52
      upvalues:
        collectionService (copy, index: 1)
        players (copy, index: 2)
    ]]
    local v24 = {}
    local v25 = {}

    for _, combatant in collectionService:GetTagged("Combatant") do
        if combatant:IsA("Model") and not v25[combatant] then
            v25[combatant] = true
            table.insert(v24, combatant)
        end
    end

    for _, player in players:GetPlayers() do
        local character = player.Character

        if character and not v25[character] then
            v25[character] = true
            table.insert(v24, character)
        end
    end

    return v24
end

function v5.Start()
    --[[
      name: Start
      line: 70
      upvalues:
        v8 (ref,  index: 1)
        runService (copy, index: 2)
        v7 (copy, index: 3)
        preRenderConnection (ref,  index: 4)
        workspace (copy, index: 5)
        fighters (copy, index: 6)
        sample (copy, index: 7)
    ]]
    if v8 or not runService:IsStudio() then
        return
    end

    v8 = true
    table.clear(v7)

    preRenderConnection = runService.PreRender:Connect(
        function()
            --[[
              line: 77
              upvalues:
                workspace (copy, index: 1)
                fighters (copy, index: 2)
                v7 (copy, index: 3)
                sample (copy, index: 4)
            ]]
            local serverTimeNow = workspace:GetServerTimeNow()

            for _, instance in fighters() do
                local combatantId = instance:GetAttribute("CombatantId")

                if type(combatantId) == "string" then
                    local v35

                    if combatantId == "" then
                        continue
                    end
                    if instance:GetAttribute("ReplayPuppet") ~= nil then
                        continue
                    end

                    if const v36 = v7[combatantId] then
                        v35 = v36
                    else
                        v35 = {t = {}, q = {}}
                        v7[combatantId] = v35
                    end

                    table.insert(v35.t, serverTimeNow)
                    table.insert(v35.q, (sample(instance)))

                    while 0 < #v35.t and 30 < serverTimeNow - v35.t[1] do
                        table.remove(v35.t, 1)
                        table.remove(v35.q, 1)
                    end
                end
            end
        end
    )
end

function v5.Stop()
    --[[
      name: Stop
      line: 99
      upvalues:
        v8 (ref, index: 1)
        preRenderConnection (ref, index: 2)
    ]]
    v8 = false

    if preRenderConnection then
        preRenderConnection:Disconnect()
        preRenderConnection = nil
    end
end

function v5.Active()
    --[[
      name: Active
      line: 107
      upvalues:
        v8 (ref, index: 1)
    ]]
    return v8
end

local function liveAt(key, a39)
    --[[
      name: liveAt
      line: 111
      upvalues:
        v7 (copy, index: 1)
    ]]
    local v40 = v7[key]

    if not v40 or #v40.t == 0 or a39 < v40.t[1] or v40.t[#v40.t] < a39 then
        return nil
    end

    local v41 = 1
    local v42 = #v40.t

    while 1 < v42 - v41 do
        local v43 = (v41 + v42) // 2

        if v40.t[v43] <= a39 then
            v41 = v43
        else
            v42 = v43
        end
    end

    if math.abs(v40.t[v41] - a39) <= math.abs(v40.t[v42] - a39) then
        return v40.q[v41]
    end

    return v40.q[v42]
end

local function angleOf(a45)
    --[[
      name: angleOf
      line: 129
    ]]
    local _, v47 = a45:ToAxisAngle()
    return (math.deg((math.abs(v47))))
end

local v48 = {0, 0.05, 0.1, 0.15, 0.2, 0.3}
local v49 = {}

function v5.Reset()
    --[[
      name: Reset
      line: 140
      upvalues:
        v49 (copy, index: 1)
    ]]
    table.clear(v49)
end

function v5.Compare(key, key2, a52)
    --[[
      name: Compare
      line: 144
      upvalues:
        sample (copy, index: 1)
        v49 (copy, index: 2)
        v48 (copy, index: 3)
        v6 (copy, index: 4)
        liveAt (copy, index: 5)
    ]]
    local v53 = sample(key2)
    local v54 = v49[key]
    if not v54 then
        v54 = {}

        for v55 in v48 do
            v54[v55] = {n = 0, sum = table.create(#v6, 0), max = table.create(#v6, 0), dead = table.create(#v6, 0)}
        end

        v49[key] = v54
    end

    for v56, v57 in v48 do
        if const v58 = liveAt(key, a52 + v57) then
            local v59 = v54[v56]
            v59.n += 1

            for index = 1, #v6 do
                local _, v62 = (v53[index]:Inverse() * v58[index]):ToAxisAngle()
                local v63 = math.deg((math.abs(v62)))
                local sum = v59.sum
                sum[index] += v63
                v59.max[index] = math.max(v59.max[index], v63)
                local v65 = v53[index]
                local _, v67 = v65:ToAxisAngle()

                if math.deg((math.abs(v67))) < 0.05 then
                    local v68 = v58[index]
                    local _, v70 = v68:ToAxisAngle()

                    if 3 < math.deg((math.abs(v70))) then
                        local dead = v59.dead
                        dead[index] += 1
                    end
                end
            end
        end
    end
end

function v5.BestMatch(key, key2, a74, a75)
    --[[
      name: BestMatch
      line: 174
      upvalues:
        v7 (copy, index: 1)
        sample (copy, index: 2)
        v6 (copy, index: 3)
    ]]
    local v76, v77
    local v78 = v7[key]
    if not v78 then
        return nil, nil, nil
    end

    local v79 = sample(key2)
    local v80 = math.huge
    v76, v77 = nil, nil

    for v81, v82 in v78.t do
        if a74 <= v82 and v82 <= a75 then
            local v83 = v78.q[v81]
            local total = 0
            local v85 = {}

            for v86, v87 in v6 do
                local _, v89 = (v79[v86]:Inverse() * v83[v86]):ToAxisAngle()
                local v90 = math.deg((math.abs(v89)))
                v85[v87] = math.floor((v90 * 10) + 0.5) / 10
                total += v90
            end

            if total / #v6 < v80 then
                v80 = total / #v6
                v76, v77 = v82, v85
            end
        end
    end

    local v91 = if v76 then v80 else nil

    return v76, v91, v77
end

function v5.Report()
    --[[
      name: Report
      line: 199
      upvalues:
        v49 (copy, index: 1)
        v6 (copy, index: 2)
        v48 (copy, index: 3)
        v7 (copy, index: 4)
    ]]
    local v92 = {}

    for v93, v94 in v49 do
        local v95
        local meanDeg = math.huge

        for v97, v98 in v94 do
            if 0 < v98.n then
                local total = 0

                for index = 1, #v6 do
                    total += v98.sum[index] / v98.n
                end

                if not (total / #v6 < meanDeg) then
                    continue
                end

                meanDeg = total / #v6
                v95 = v97
            end
        end

        if v95 then
            local v101 = v94[v95]
            local joints = {}

            for v103, v104 in v6 do
                joints[v104] = string.format("mean %.1f max %.1f dead %d%%", v101.sum[v103] / v101.n, v101.max[v103], (math.floor((v101.dead[v103] * 100) / v101.n)))
            end

            v92[v93] = {frames = v101.n, offset = v48[v95], meanDeg = meanDeg, joints = joints}
        end
    end

    local traced = {}

    for v106, v107 in v7 do
        traced[v106] = #v107.t
    end

    v92._traced = traced

    return v92
end

return v5