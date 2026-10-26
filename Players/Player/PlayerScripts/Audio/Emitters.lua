local CollectionService_upv_1 = game:GetService("CollectionService")
local Workspace_upv_1 = game:GetService("Workspace")
local tbl_1 = {}
local tbl_upv_2 = {"torch", "brazier", "campfire", "bonfire", "firepit", "fire_pit", "hearth"}
local tbl_upv_3 = {}
local tbl_upv_4 = {}
local u1 = nil
local tbl_upv_5 = {}
local u2 = 0
local function anchorOf(a1)
    --[[
      name: anchorOf
      line: 27
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v1 = nil
    if a1:IsA("Fire") then
        v1 = a1.Parent
        if v1 then
            if not (v1:IsA("BasePart")) and not (v1:IsA("Attachment")) then
                return nil
            end
            return v1
        end
    else
        local v2, v3 = nil, nil
        if a1:IsA("ParticleEmitter") then
            v2 = string.lower(a1.Name)
            if not (string.find(v2, "fire", 1, true)) and not (string.find(v2, "flame", 1, true)) then
                return nil
            end
            v3 = a1.Parent
            if v3 then
                if not (v3:IsA("BasePart")) and not (v3:IsA("Attachment")) then
                    return nil
                end
                return v3
            end
        else
            if not a1:IsA("BasePart") then
                return nil
            end
            local v4 = string.lower(a1.Name)
            for _, value_1 in tbl_upv_2 do
                if not (string.find(v4, value_1, 1, true)) then
                    continue
                end
                return a1
            end
        end
    end
    return nil
end
local function addTagged(a1)
    --[[
      name: addTagged
      line: 58
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    if not (a1:IsA("BasePart")) and not (a1:IsA("Attachment")) then
        return
    end
    local v5 = a1:GetAttribute("Sound")
    if type(v5) ~= "string" then
        return
    end
    local v6 = a1:GetAttribute("Volume")
    local tbl_6 = {volume = 0}
    tbl_6.sound = v5
    local v7
    if type(v6) ~= "number" then
        v7 = 1
    else
        v7 = v6
    end
    tbl_6.volume = v7
    tbl_upv_3[a1] = tbl_6
end
local function consider(a1)
    --[[
      name: consider
      line: 51
      upvalues:
        anchorOf (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    local v8 = anchorOf(a1)
    if not v8 or (tbl_upv_3[v8]) then
        return
    end
    tbl_upv_3[v8] = {sound = "Ambience/Fire_Emitter", volume = 1}
end
function tbl_1.Watch(a1)
    --[[
      name: Watch
      line: 71
      upvalues:
        tbl_upv_5 (copy, index: 1)
        consider (copy, index: 2)
        anchorOf (copy, index: 3)
        tbl_upv_3 (copy, index: 4)
    ]]
    if tbl_upv_5[a1] then
        return
    end
    tbl_upv_5[a1] = a1.DescendantAdded:Connect(consider)
    task.spawn(
        function()
            --[[
              line: 76
              upvalues:
                a1 (copy, index: 1)
                anchorOf (copy, index: 2)
                tbl_upv_3 (copy, index: 3)
            ]]
            for key_1, value_2 in a1:GetDescendants() do
                local v9 = anchorOf(value_2)
                if v9 and not (tbl_upv_3[v9]) then
                    tbl_upv_3[v9] = {sound = "Ambience/Fire_Emitter", volume = 1}
                end
                if key_1 % 500 == 0 then
                    task.wait()
                end
            end
        end
    )
end
function tbl_1.Unwatch(a1)
    --[[
      name: Unwatch
      line: 86
      upvalues:
        tbl_upv_5 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    local v10 = tbl_upv_5[a1]
    if v10 then
        v10:Disconnect()
        tbl_upv_5[a1] = nil
    end
    for key_2 in tbl_upv_3 do
        if key_2:IsDescendantOf(a1) then
            tbl_upv_3[key_2] = nil
        end
    end
end
local function positionOf(a1)
    --[[
      name: positionOf
      line: 99
    ]]
    if a1:IsA("BasePart") then
        return a1.Position
    elseif a1:IsA("Attachment") then
        return a1.WorldPosition
    else
        return nil
    end
end
local function stopActive(a1)
    --[[
      name: stopActive
      line: 108
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    local v11 = tbl_upv_4[a1]
    if not v11 then
        return
    end
    v11:Destroy()
    tbl_upv_4[a1] = nil
end
function tbl_1.Update()
    --[[
      name: Update
      line: 116
      upvalues:
        Workspace_upv_1 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
        tbl_upv_4 (copy, index: 3)
        u2 (ref,  index: 4)
        u1 (ref,  index: 5)
    ]]
    local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
    if not CurrentCamera_1 then
        return
    end
    local Position_1 = CurrentCamera_1.CFrame.Position
    local tbl_7 = {}
    local v12 = nil
    local v13 = nil
    for key_3, _ in tbl_upv_3 do
        if key_3.Parent then
            if key_3:IsA("BasePart") then
                v12 = key_3.Position
            elseif key_3:IsA("Attachment") then
                v12 = key_3.WorldPosition
            else
                v12 = nil
            end
            if v12 then
                v13 = (v12 - Position_1).Magnitude
            else
                v13 = math.huge
            end
            if v13 < 42 or tbl_upv_4[key_3] and v13 < 55 then
                table.insert(tbl_7, {inst = key_3, d = v13})
            end
        else
            tbl_upv_3[key_3] = nil
            v12 = tbl_upv_4[key_3]
            if v12 then
                v12:Destroy()
                tbl_upv_4[key_3] = nil
            end
        end
    end
    table.sort(
        tbl_7,
        function(a1, a2)
            --[[
              line: 137
            ]]
            return a1.d < a2.d
        end
    )
    u2 = #tbl_7
    local tbl_8 = {}
    for n_1 = 1, math.min(#tbl_7, 6) do
        local inst_1 = tbl_7[n_1].inst
        tbl_8[inst_1] = true
        if tbl_upv_4[inst_1] then
            continue
        end
        local v14 = tbl_upv_3[inst_1]
        local v15 = u1.Clone(v14.sound)
        if v15 then
            v15.Looped = true
            v15.Volume = v15.Volume * v14.volume
            v15.PlaybackSpeed = v15.PlaybackSpeed * (0.94 + (math.random() * 0.12))
            v15.Parent = inst_1
            v15.TimePosition = math.random() * 20
            v15:Play()
            tbl_upv_4[inst_1] = v15
        end
    end
    for key_4 in tbl_upv_4 do
        if tbl_8[key_4] then
            continue
        end
        local v16 = tbl_upv_4[key_4]
        if v16 then
            v16:Destroy()
            tbl_upv_4[key_4] = nil
        end
    end
end
function tbl_1.Count()
    --[[
      name: Count
      line: 166
      upvalues:
        tbl_upv_4 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
        u2 (ref,  index: 3)
    ]]
    local v17 = 0
    local v18 = 0
    for _ in tbl_upv_4 do
        v17 = v17 + 1
    end
    for _ in tbl_upv_3 do
        v18 = v18 + 1
    end
    return v17 .. "/" .. v18 .. " near=" .. u2
end
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 177
      upvalues:
        u1 (ref,  index: 1)
        CollectionService_upv_1 (copy, index: 2)
        addTagged (copy, index: 3)
        tbl_upv_3 (copy, index: 4)
        tbl_upv_4 (copy, index: 5)
    ]]
    u1 = a1
    CollectionService_upv_1:GetInstanceAddedSignal("AmbientSound"):Connect(addTagged)
    CollectionService_upv_1:GetInstanceRemovedSignal("AmbientSound"):Connect(
        function(a2)
            --[[
              line: 180
              upvalues:
                tbl_upv_3 (copy, index: 1)
                tbl_upv_4 (copy, index: 2)
            ]]
            tbl_upv_3[a2] = nil
            local v19 = tbl_upv_4[a2]
            if not v19 then
                return
            end
            v19:Destroy()
            tbl_upv_4[a2] = nil
        end
    )
    for _, value_3 in CollectionService_upv_1:GetTagged("AmbientSound") do
        addTagged(value_3)
    end
end
return tbl_1