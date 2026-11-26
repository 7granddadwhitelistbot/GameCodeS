local collectionService = game:GetService("CollectionService")
local workspace = game:GetService("Workspace")
local v3 = {}
local patterns = {"torch", "brazier", "campfire", "bonfire", "firepit", "fire_pit", "hearth"}
local v5 = {}
local v6 = {}
local v7 = nil
local v8 = {}
local v9 = 0

local function anchorOf(a11)
    --[[
      name: anchorOf
      line: 27
      upvalues:
        patterns (copy, index: 1)
    ]]
    if a11:IsA("Fire") then
        local parent = a11.Parent

        if not parent or not parent:IsA("BasePart") and not parent:IsA("Attachment") then
            parent = nil
        end

        return parent
    end

    if not a11:IsA("ParticleEmitter") then
        if a11:IsA("BasePart") then
            local lowercaseText = string.lower(a11.Name)

            for _, pattern in patterns do
                if string.find(lowercaseText, pattern, 1, true) then
                    return a11
                end
            end
        end

        return nil
    end

    local lowercaseText = string.lower(a11.Name)

    if not string.find(lowercaseText, "fire", 1, true) and not string.find(lowercaseText, "flame", 1, true) then
        return nil
    end

    local parent = a11.Parent

    if not parent or not parent:IsA("BasePart") and not parent:IsA("Attachment") then
        parent = nil
    end

    return parent
end

local function consider(a19)
    --[[
      name: consider
      line: 51
      upvalues:
        anchorOf (copy, index: 1)
        v5 (copy, index: 2)
    ]]
    local v20 = anchorOf(a19)

    if v20 and not v5[v20] then
        v5[v20] = {sound = "Ambience/Fire_Emitter", volume = 1}
    end
end

local function addTagged(ambientSound: Instance)
    --[[
      name: addTagged
      line: 58
      upvalues:
        v5 (copy, index: 1)
    ]]
    if not ambientSound:IsA("BasePart") and not ambientSound:IsA("Attachment") then
        return
    end

    local sound = ambientSound:GetAttribute("Sound")

    if type(sound) ~= "string" then
        return
    end

    local volume
    local volume2 = ambientSound:GetAttribute("Volume")
    local v26 = {sound = sound}

    if type(volume2) ~= "number" then
        volume = 1
    else
        volume = volume2
    end

    v26.volume = volume
    v5[ambientSound] = v26
end

function v3.Watch(key)
    --[[
      name: Watch
      line: 71
      upvalues:
        v8 (copy, index: 1)
        consider (copy, index: 2)
        anchorOf (copy, index: 3)
        v5 (copy, index: 4)
    ]]
    if v8[key] then
        return
    end

    v8[key] = key.DescendantAdded:Connect(consider)

    task.spawn(
        function()
            --[[
              line: 76
              upvalues:
                key (copy, index: 1)
                anchorOf (copy, index: 2)
                v5 (copy, index: 3)
            ]]
            for v28, descendant in key:GetDescendants() do
                local v30 = anchorOf(descendant)

                if v30 and not v5[v30] then
                    v5[v30] = {sound = "Ambience/Fire_Emitter", volume = 1}
                end

                if v28 % 500 == 0 then
                    task.wait()
                end
            end
        end
    )
end

function v3.Unwatch(key)
    --[[
      name: Unwatch
      line: 86
      upvalues:
        v8 (copy, index: 1)
        v5 (copy, index: 2)
    ]]
    if const v32 = v8[key] then
        v32:Disconnect()
        v8[key] = nil
    end

    for v33 in v5 do
        if v33:IsDescendantOf(key) then
            v5[v33] = nil
        end
    end
end

local function positionOf(a35)
    --[[
      name: positionOf
      line: 99
    ]]
    if a35:IsA("BasePart") then
        return a35.Position
    end
    if a35:IsA("Attachment") then
        return a35.WorldPosition
    end

    return nil
end

local function stopActive(key)
    --[[
      name: stopActive
      line: 108
      upvalues:
        v6 (copy, index: 1)
    ]]
    if const v38 = v6[key] then
        v38:Destroy()
        v6[key] = nil
    end
end

function v3.Update()
    --[[
      name: Update
      line: 116
      upvalues:
        workspace (copy, index: 1)
        v5 (copy, index: 2)
        v6 (copy, index: 3)
        v9 (ref,  index: 4)
        v7 (ref,  index: 5)
    ]]
    local camera = workspace.CurrentCamera
    if not camera then
        return
    end

    local position = camera.CFrame.Position
    local v41 = {}

    for inst, _ in v5 do
        if inst.Parent then
            local v44

            if inst:IsA("BasePart") then
                v44 = inst.Position
            else
                v44 = if inst:IsA("Attachment") then inst.WorldPosition else nil
            end

            local v45 = not v44 and math.huge or (v44 - position).Magnitude

            if v45 < 42 or v6[inst] and v45 < 55 then
                table.insert(v41, {inst = inst, d = v45})
            end
        else
            v5[inst] = nil

            if const v46 = v6[inst] then
                v46:Destroy()
                v6[inst] = nil
            end
        end
    end

    table.sort(
        v41,
        function(left, right)
            --[[
              line: 137
            ]]
            return left.d < right.d
        end
    )
    v9 = #v41
    local v49 = {}

    for index = 1, math.min(#v41, 6) do
        local inst = v41[index].inst
        v49[inst] = true

        if not v6[inst] then
            local v52 = v5[inst]

            if const v53 = v7.Clone(v52.sound) then
                v53.Looped = true
                v53.Volume *= v52.volume
                v53.PlaybackSpeed *= (0.94 + (math.random() * 0.12))
                v53.Parent = inst
                v53.TimePosition = math.random() * 20
                v53:Play()
                v6[inst] = v53
            end
        end
    end

    for v54 in v6 do
        if not v49[v54] then
            local v55 = v6[v54]
            if not v55 then
                continue
            end

            v55:Destroy()
            v6[v54] = nil
        end
    end
end

function v3.Count()
    --[[
      name: Count
      line: 166
      upvalues:
        v6 (copy, index: 1)
        v5 (copy, index: 2)
        v9 (ref,  index: 3)
    ]]
    local count = 0
    local count2 = 0

    for _ in v6 do
        count += 1
    end

    for _ in v5 do
        count2 += 1
    end

    return count .. "/" .. count2 .. " near=" .. v9
end

function v3.Init(a60)
    --[[
      name: Init
      line: 177
      upvalues:
        v7 (ref,  index: 1)
        collectionService (copy, index: 2)
        addTagged (copy, index: 3)
        v5 (copy, index: 4)
        v6 (copy, index: 5)
    ]]
    v7 = a60
    collectionService:GetInstanceAddedSignal("AmbientSound"):Connect(addTagged)

    collectionService:GetInstanceRemovedSignal("AmbientSound"):Connect(
        function(ambientSound: Instance)
            --[[
              line: 180
              upvalues:
                v5 (copy, index: 1)
                v6 (copy, index: 2)
            ]]
            v5[ambientSound] = nil

            if const v62 = v6[ambientSound] then
                v62:Destroy()
                v6[ambientSound] = nil
            end
        end
    )

    for _, ambientSound in collectionService:GetTagged("AmbientSound") do
        addTagged(ambientSound)
    end
end

return v3