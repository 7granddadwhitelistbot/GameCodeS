local CollectionService_upv_1 = game:GetService("CollectionService")
local Players_1 = game:GetService("Players")
local Workspace_upv_1 = game:GetService("Workspace")
local Fighters_upv_1 = require(script.Parent:WaitForChild("Fighters"))
local tbl_1 = {}
tbl_1.DECOR_FADE = 0.75
tbl_1.ALLY_FADE = 0.7
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local tbl_upv_2 = {}
local tbl_upv_3 = {}
local u1 = 0
local tbl_upv_4 = {}
local tbl_upv_5 = {}
local u2 = 0
local u3 = false
local function cellKey(a1, a2, a3)
    --[[
      name: cellKey
      line: 72
    ]]
    return a1 .. "," .. a2 .. "," .. a3
end
local function isDecor(a1)
    --[[
      name: isDecor
      line: 49
    ]]
    if not a1:IsA("BasePart") or not a1.Anchored or a1.Transparency >= 0.95 or not (a1:HasTag("Foliage")) and (a1.CanCollide or a1.CanQuery) then
        return false
    end
    local v1 = a1.Size
    if math.max(v1.X, v1.Y, v1.Z) < 1 then
        return false
    end
    v1 = a1:FindFirstAncestorWhichIsA("Model")
    while v1 do
        if v1:HasTag("BearTrap") or v1:FindFirstChildOfClass("Humanoid") then
            return false
        end
        v1 = v1:FindFirstAncestorWhichIsA("Model")
    end
    return true
end
local function addDecor(a1)
    --[[
      name: addDecor
      line: 76
      upvalues:
        tbl_upv_3 (copy, index: 1)
        isDecor (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
        u1 (ref,  index: 4)
    ]]
    if tbl_upv_3[a1] or not isDecor(a1) then
        return
    end
    local CFrame_1 = a1.CFrame
    local v2 = a1.Size / 2
    local v3 = CFrame_1.RightVector * v2.X
    local v4 = CFrame_1.UpVector * v2.Y
    local tbl_6 = CFrame_1.LookVector * v2.Z
    local v5 = Vector3.new((math.abs(v3.X) + math.abs(v4.X)) + math.abs(tbl_6.X), (math.abs(v3.Y) + math.abs(v4.Y)) + math.abs(tbl_6.Y), (math.abs(v3.Z) + math.abs(v4.Z)) + math.abs(tbl_6.Z))
    local v6 = (CFrame_1.Position - v5) / 16
    local v7 = (CFrame_1.Position + v5) / 16
    local v8 = math.floor(v6.X)
    local v9 = math.floor(v6.Y)
    local v10 = math.floor(v6.Z)
    local v11 = math.floor(v7.X)
    local v12 = math.floor(v7.Y)
    local v13 = math.floor(v7.Z)
    if (((v11 - v8) + 1) * (v12 - v9 + 1)) * (v13 - v10 + 1) > 64 then
        return
    end
    v7 = {}
    v7 = nil
    for n_1 = v8, v11 do
        v7 = nil
        for n_2 = v9, v12 do
            v7 = nil
            for n_3 = v10, v13 do
                v6 = n_1 .. "," .. n_2 .. "," .. n_3
                tbl_6 = tbl_upv_2[v6]
                if not (tbl_6) then
                    tbl_6 = {}
                    tbl_upv_2[v6] = tbl_6
                end
                tbl_6[a1] = true
                table.insert(v7, v6)
            end
        end
    end
    tbl_upv_3[a1] = {part = a1, cells = v7}
    u1 = u1 + 1
end
local function removeDecor(a1)
    --[[
      name: removeDecor
      line: 115
      upvalues:
        tbl_upv_3 (copy, index: 1)
        u1 (ref,  index: 2)
        tbl_upv_2 (copy, index: 3)
        tbl_upv_4 (copy, index: 4)
    ]]
    local v14 = tbl_upv_3[a1]
    if not v14 then
        return
    end
    tbl_upv_3[v14.part] = nil
    u1 = u1 - 1
    for _, value_1 in v14.cells do
        local v15 = tbl_upv_2[value_1]
        if not (v15) then
            continue
        end
        v15[v14.part] = nil
        if next(v15) == nil then
            tbl_upv_2[value_1] = nil
        end
    end
    if tbl_upv_4[v14.part] then
        tbl_upv_4[v14.part] = nil
        v14.part.LocalTransparencyModifier = 0
    end
end
local function watchDecorRoot(a1)
    --[[
      name: watchDecorRoot
      line: 137
      upvalues:
        addDecor (copy, index: 1)
        removeDecor (copy, index: 2)
    ]]
    for _, value_2 in a1:GetDescendants() do
        addDecor(value_2)
    end
    a1.DescendantAdded:Connect(addDecor)
    a1.DescendantRemoving:Connect(removeDecor)
end
local function startDecorWatch()
    --[[
      name: startDecorWatch
      line: 145
      upvalues:
        u3 (ref,  index: 1)
        Workspace_upv_1 (copy, index: 2)
        watchDecorRoot (copy, index: 3)
        CollectionService_upv_1 (copy, index: 4)
        addDecor (copy, index: 5)
        removeDecor (copy, index: 6)
    ]]
    if u3 then
        return
    end
    u3 = true
    for _, value_3 in {"Arenas", "Lobby"} do
        local v16 = Workspace_upv_1:FindFirstChild(value_3)
        if v16 then
            watchDecorRoot(v16)
        end
    end
    Workspace_upv_1.ChildAdded:Connect(
        function(a1)
            --[[
              line: 156
              upvalues:
                watchDecorRoot (copy, index: 1)
            ]]
            if a1.Name ~= "Arenas" and a1.Name ~= "Lobby" then
                return
            end
            watchDecorRoot(a1)
        end
    )
    CollectionService_upv_1:GetInstanceAddedSignal("Foliage"):Connect(addDecor)
    CollectionService_upv_1:GetInstanceRemovedSignal("Foliage"):Connect(removeDecor)
    for _, value_4 in CollectionService_upv_1:GetTagged("Foliage") do
        addDecor(value_4)
    end
end
local function boxDistance(a1, a2)
    --[[
      name: boxDistance
      line: 170
    ]]
    local v17 = a1.CFrame:PointToObjectSpace(a2)
    local v18 = a1.Size / 2
    local v19 = math.max(math.abs(v17.X) - v18.X, 0)
    local v20 = math.max(math.abs(v17.Y) - v18.Y, 0)
    local v21 = math.max(math.abs(v17.Z) - v18.Z, 0)
    return (math.sqrt(((v19 * v19) + (v20 * v20)) + (v21 * v21)))
end
function tbl_1.ClearDecor()
    --[[
      name: ClearDecor
      line: 197
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    for key_1 in tbl_upv_4 do
        if key_1.Parent then
            key_1.LocalTransparencyModifier = 0
        end
    end
    table.clear(tbl_upv_4)
end
local function markDecorNear(a1, a2)
    --[[
      name: markDecorNear
      line: 179
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_5 (copy, index: 2)
        boxDistance (copy, index: 3)
    ]]
    local v22 = (a1 - (Vector3.new(1, 1, 1) * a2)) / 16
    local v23 = (a1 + (Vector3.new(1, 1, 1) * a2)) / 16
    for n_4 = math.floor(v22.X), math.floor(v23.X) do
        for n_5 = math.floor(v22.Y), math.floor(v23.Y) do
            for n_6 = math.floor(v22.Z), math.floor(v23.Z) do
                local v24 = tbl_upv_2[n_4 .. "," .. n_5 .. "," .. n_6]
                if not (v24) then
                    continue
                end
                for key_2 in v24 do
                    if tbl_upv_5[key_2] then
                        continue
                    end
                    if boxDistance(key_2, a1) < a2 then
                        tbl_upv_5[key_2] = true
                    end
                end
            end
        end
    end
end
function tbl_1.UpdateDecor(a1, a2)
    --[[
      name: UpdateDecor
      line: 207
      upvalues:
        u2 (ref,  index: 1)
        startDecorWatch (copy, index: 2)
        tbl_upv_5 (copy, index: 3)
        markDecorNear (copy, index: 4)
        tbl_upv_4 (copy, index: 5)
    ]]
    local v25 = os.clock()
    if (v25 - u2 < 0.1) then
        return
    end
    u2 = v25
    startDecorWatch()
    table.clear(tbl_upv_5)
    markDecorNear(a1, 3)
    if a2 then
        markDecorNear(a1:Lerp(a2, 0.33), 1.2)
        markDecorNear(a1:Lerp(a2, 0.66), 1.2)
    end
    for key_3 in tbl_upv_5 do
        if not (tbl_upv_4[key_3]) then
            tbl_upv_4[key_3] = true
            key_3.LocalTransparencyModifier = 0.75
        end
    end
    for key_4 in tbl_upv_4 do
        if tbl_upv_5[key_4] then
            continue
        end
        tbl_upv_4[key_4] = nil
        if key_4.Parent then
            key_4.LocalTransparencyModifier = 0
        end
    end
end
local tbl_upv_7 = {}
local function setAllyLtm(a1, a2, a3)
    --[[
      name: setAllyLtm
      line: 242
    ]]
    if a1.dirty then
        table.clear(a1.parts)
        for _, value_5 in a2:GetDescendants() do
            if value_5:IsA("BasePart") or value_5:IsA("Decal") then
                table.insert(a1.parts, value_5)
            end
        end
        a1.dirty = false
    end
    for _, value_6 in a1.parts do
        if value_6.LocalTransparencyModifier == a3 then
            continue
        end
        if value_6.Parent then
            value_6.LocalTransparencyModifier = a3
        end
    end
end
local function unfadeAlly(a1)
    --[[
      name: unfadeAlly
      line: 259
      upvalues:
        tbl_upv_7 (copy, index: 1)
        setAllyLtm (copy, index: 2)
    ]]
    local v26 = tbl_upv_7[a1]
    if not v26 then
        return
    end
    tbl_upv_7[a1] = nil
    for _, value_7 in v26.conns do
        value_7:Disconnect()
    end
    v26.dirty = true
    setAllyLtm(v26, a1, 0)
end
function tbl_1.ClearAllies()
    --[[
      name: ClearAllies
      line: 272
      upvalues:
        tbl_upv_7 (copy, index: 1)
        setAllyLtm (copy, index: 2)
    ]]
    for key_5 in tbl_upv_7 do
        local v27 = tbl_upv_7[key_5]
        if not (v27) then
            continue
        end
        tbl_upv_7[key_5] = nil
        for _, value_8 in v27.conns do
            value_8:Disconnect()
        end
        v27.dirty = true
        setAllyLtm(v27, key_5, 0)
    end
end
local function segmentDistance(a1, a2, a3)
    --[[
      name: segmentDistance
      line: 278
    ]]
    local v28 = a3 - a2
    local v29 = v28:Dot(v28)
    local v30 = ((not (v29 > 1e-06)) and 0) or (math.clamp((a1 - a2):Dot(v28) / v29, 0, 1))
    return ((a2 + (v28 * v30)) - a1).Magnitude
end
local function isAlly(a1, a2)
    --[[
      name: isAlly
      line: 285
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    if a1 == a2 then
        return false
    end
    local v31 = LocalPlayer_upv_1:GetAttribute("MatchId")
    if type(v31) == "string" and v31 ~= "" and a1:GetAttribute("MatchId") == v31 then
        local v32 = LocalPlayer_upv_1:GetAttribute("Team")
        local v33 = (v32 ~= nil) and (a1:GetAttribute("Team") == v32)
        return v33
    end
    return false
end
function tbl_1.UpdateAllies(a1, a2, a3)
    --[[
      name: UpdateAllies
      line: 298
      upvalues:
        Fighters_upv_1 (copy, index: 1)
        tbl_upv_7 (copy, index: 2)
        isAlly (copy, index: 3)
        setAllyLtm (copy, index: 4)
    ]]
    local v34 = nil
    for _, value_9 in Fighters_upv_1.List() do
        local v35 = value_9:FindFirstChildOfClass("Humanoid")
        local HumanoidRootPart_1 = value_9:FindFirstChild("HumanoidRootPart")
        local v36 = tbl_upv_7[value_9] ~= nil
        v34 = false
        if v35 and v35.Health > 0 and HumanoidRootPart_1 then
            local v37 = HumanoidRootPart_1:IsA("BasePart")
            if v37 then
                local v38 = isAlly(value_9, a3)
                if v38 then
                    local Head_1 = value_9:FindFirstChild("Head")
                    local Position_1 = HumanoidRootPart_1.Position
                    local v39 = a2 - a1
                    local v40 = v39:Dot(v39)
                    local v41 = ((not (v40 > 1e-06)) and 0) or (math.clamp((Position_1 - a1):Dot(v39) / v40, 0, 1))
                    local Magnitude_1 = ((a1 + (v39 * v41)) - Position_1).Magnitude
                    if Head_1 and Head_1:IsA("BasePart") then
                        local Position_2 = Head_1.Position
                        local v42 = a2 - a1
                        local v43 = (a2 - a1):Dot(a2 - a1)
                        local v44 = ((not (v43 > 1e-06)) and 0) or (math.clamp((Position_2 - a1):Dot(v42) / v43, 0, 1))
                        local v48 = math.min(Magnitude_1, ((a1 + (v42 * v44)) - Position_2).Magnitude)
                    end
                    v34 = Magnitude_1 < ((v36 and 5.6) or 5)
                end
            end
        end
        if v34 and not (v36) then
            local tbl_upv_8 = {dirty = true}
            tbl_upv_8.parts = {}
            tbl_upv_8.conns = {}
            table.insert(
                tbl_upv_8.conns,
                value_9.DescendantAdded:Connect(
                    function()
                        --[[
                          line: 314
                          upvalues:
                            tbl_upv_8 (copy, index: 1)
                        ]]
                        tbl_upv_8.dirty = true
                    end
                )
            )
            tbl_upv_7[value_9] = tbl_upv_8
            setAllyLtm(tbl_upv_8, value_9, 0.7)
            continue
        end
        if v34 and v36 then
            local v45 = tbl_upv_7[value_9]
            if v45.dirty then
                setAllyLtm(v45, value_9, 0.7)
            end
        else
            if not (v36) then
                continue
            end
            local v46 = tbl_upv_7[value_9]
            if not (v46) then
                continue
            end
            tbl_upv_7[value_9] = nil
            for v49, value_10 in v46.conns do
                value_10:Disconnect()
            end
            v46.dirty = true
            setAllyLtm(v46, value_9, 0)
        end
    end
    for key_6 in tbl_upv_7 do
        if key_6.Parent then
            continue
        end
        local v47 = tbl_upv_7[key_6]
        if not (v47) then
            continue
        end
        tbl_upv_7[key_6] = nil
        for _, value_11 in v47.conns do
            value_11:Disconnect()
        end
        v47.dirty = true
        setAllyLtm(v47, key_6, 0)
    end
end
function tbl_1.Stats()
    --[[
      name: Stats
      line: 335
      upvalues:
        tbl_upv_4 (copy, index: 1)
        tbl_upv_7 (copy, index: 2)
        u1 (ref,  index: 3)
    ]]
    local v48 = 0
    local v49 = 0
    for _ in tbl_upv_4 do
        v48 = v48 + 1
    end
    for _ in tbl_upv_7 do
        v49 = v49 + 1
    end
    local tbl_9 = {}
    tbl_9.decorParts = u1
    tbl_9.decorFaded = v48
    tbl_9.alliesFaded = v49
    return tbl_9
end
return tbl_1