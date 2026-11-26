local collectionService = game:GetService("CollectionService")
local players = game:GetService("Players")
local workspace = game:GetService("Workspace")
local Fighters = require(script.Parent:WaitForChild("Fighters"))
local v5 = {DECOR_FADE = 0.75, ALLY_FADE = 0.7}
local localPlayer = players.LocalPlayer
local v7 = {}
local v8 = {}
local decorParts = 0
local v10 = {}
local v11 = {}
local timestamp = 0
local hasRun = false

local function isDecor(instance: Instance)
    --[[
      name: isDecor
      line: 49
    ]]
    if not instance:IsA("BasePart") or not instance.Anchored or 0.95 <= instance.Transparency then
        return false
    end

    if not instance:HasTag("Foliage") then
        if instance.CanCollide then
            return false
        end
        if instance.CanQuery then
            return false
        end
    end

    local size = instance.Size

    if math.max(size.X, size.Y, size.Z) < 1 then
        return false
    end

    local firstAncestorWhichIsA = instance:FindFirstAncestorWhichIsA("Model")

    while firstAncestorWhichIsA do
        if firstAncestorWhichIsA:HasTag("BearTrap") then
            return false
        end
        if firstAncestorWhichIsA:FindFirstChildOfClass("Humanoid") then
            return false
        end

        firstAncestorWhichIsA = firstAncestorWhichIsA:FindFirstAncestorWhichIsA("Model")
    end

    return true
end

local function cellKey(a19, a20, a21)
    --[[
      name: cellKey
      line: 72
    ]]
    return a19 .. "," .. a20 .. "," .. a21
end

local function addDecor(instance: Instance)
    --[[
      name: addDecor
      line: 76
      upvalues:
        v8 (copy, index: 1)
        isDecor (copy, index: 2)
        v7 (copy, index: 3)
        decorParts (ref,  index: 4)
    ]]
    if v8[instance] or not isDecor(instance) then
        return
    end

    local cFrame = instance.CFrame
    local v25 = instance.Size / 2
    local v26 = cFrame.RightVector * v25.X
    local v27 = cFrame.UpVector * v25.Y
    local v28 = cFrame.LookVector * v25.Z
    local vector3 = Vector3.new((math.abs(v26.X) + math.abs(v27.X)) + math.abs(v28.X), (math.abs(v26.Y) + math.abs(v27.Y)) + math.abs(v28.Y), math.abs(v26.Z) + math.abs(v27.Z) + math.abs(v28.Z))
    local v30 = (cFrame.Position - vector3) / 16
    local v31 = (cFrame.Position + vector3) / 16
    local flooredValue = math.floor(v30.X)
    local flooredValue2 = math.floor(v30.Y)
    local flooredValue3 = math.floor(v30.Z)
    local flooredValue4 = math.floor(v31.X)
    local flooredValue5 = math.floor(v31.Y)
    local flooredValue6 = math.floor(v31.Z)

    if 64 < ((flooredValue4 - flooredValue) + 1) * (flooredValue5 - flooredValue2 + 1) * (flooredValue6 - flooredValue3 + 1) then
        return
    end

    local cells = {}

    for index = flooredValue, flooredValue4 do
        for index2 = flooredValue2, flooredValue5 do
            for index3 = flooredValue3, flooredValue6 do
                local v42
                local v43 = index .. "," .. index2 .. "," .. index3

                if const v44 = v7[v43] then
                    v42 = v44
                else
                    v42 = {}
                    v7[v43] = v42
                end

                v42[instance] = true
                table.insert(cells, v43)
            end
        end
    end

    v8[instance] = {part = instance, cells = cells}
    decorParts += 1
end

local function removeDecor(instance: Instance)
    --[[
      name: removeDecor
      line: 115
      upvalues:
        v8 (copy, index: 1)
        decorParts (ref,  index: 2)
        v7 (copy, index: 3)
        v10 (copy, index: 4)
    ]]
    local v47 = v8[instance]
    if not v47 then
        return
    end

    v8[v47.part] = nil
    decorParts -= 1

    for _, cell in v47.cells do
        if const v50 = v7[cell] then
            v50[v47.part] = nil

            if next(v50) ~= nil then
                continue
            end

            v7[cell] = nil
        end
    end

    if v10[v47.part] then
        v10[v47.part] = nil
        v47.part.LocalTransparencyModifier = 0
    end
end

local function watchDecorRoot(child: Instance?)
    --[[
      name: watchDecorRoot
      line: 137
      upvalues:
        addDecor (copy, index: 1)
        removeDecor (copy, index: 2)
    ]]
    for _, descendant in child:GetDescendants() do
        addDecor(descendant)
    end

    child.DescendantAdded:Connect(addDecor)
    child.DescendantRemoving:Connect(removeDecor)
end

local function startDecorWatch()
    --[[
      name: startDecorWatch
      line: 145
      upvalues:
        hasRun (ref,  index: 1)
        workspace (copy, index: 2)
        watchDecorRoot (copy, index: 3)
        collectionService (copy, index: 4)
        addDecor (copy, index: 5)
        removeDecor (copy, index: 6)
    ]]
    if hasRun then
        return
    end

    hasRun = true

    for _, childName in {"Arenas", "Lobby"} do
        if const child = workspace:FindFirstChild(childName) then
            watchDecorRoot(child)
        end
    end

    workspace.ChildAdded:Connect(
        function(child: Instance)
            --[[
              line: 156
              upvalues:
                watchDecorRoot (copy, index: 1)
            ]]
            if child.Name == "Arenas" or child.Name == "Lobby" then
                watchDecorRoot(child)
            end
        end
    )

    collectionService:GetInstanceAddedSignal("Foliage"):Connect(addDecor)
    collectionService:GetInstanceRemovedSignal("Foliage"):Connect(removeDecor)

    for _, foliage in collectionService:GetTagged("Foliage") do
        addDecor(foliage)
    end
end

local function boxDistance(a63, a64)
    --[[
      name: boxDistance
      line: 170
    ]]
    local objectSpacePoint = a63.CFrame:PointToObjectSpace(a64)
    local v66 = a63.Size / 2
    local v67 = math.max(math.abs(objectSpacePoint.X) - v66.X, 0)
    local v68 = math.max(math.abs(objectSpacePoint.Y) - v66.Y, 0)
    local v69 = math.max(math.abs(objectSpacePoint.Z) - v66.Z, 0)

    return (math.sqrt(((v67 * v67) + (v68 * v68)) + (v69 * v69)))
end

local function markDecorNear(a71, a72: number)
    --[[
      name: markDecorNear
      line: 179
      upvalues:
        v7 (copy, index: 1)
        v11 (copy, index: 2)
        boxDistance (copy, index: 3)
    ]]
    local v73 = (a71 - (Vector3.new(1, 1, 1) * a72)) / 16
    local v74 = (a71 + (Vector3.new(1, 1, 1) * a72)) / 16

    for index = math.floor(v73.X), math.floor(v74.X) do
        for index2 = math.floor(v73.Y), math.floor(v74.Y) do
            for index3 = math.floor(v73.Z), math.floor(v74.Z) do
                if const v78 = v7[index .. "," .. index2 .. "," .. index3] then
                    for v79 in v78 do
                        if not v11[v79] and boxDistance(v79, a71) < a72 then
                            v11[v79] = true
                        end
                    end
                end
            end
        end
    end
end

function v5.ClearDecor()
    --[[
      name: ClearDecor
      line: 197
      upvalues:
        v10 (copy, index: 1)
    ]]
    for v80 in v10 do
        if v80.Parent then
            v80.LocalTransparencyModifier = 0
        end
    end

    table.clear(v10)
end

function v5.UpdateDecor(startValue, targetValue)
    --[[
      name: UpdateDecor
      line: 207
      upvalues:
        timestamp (ref,  index: 1)
        startDecorWatch (copy, index: 2)
        v11 (copy, index: 3)
        markDecorNear (copy, index: 4)
        v10 (copy, index: 5)
    ]]
    local timestamp2 = os.clock()

    if timestamp2 - timestamp < 0.1 then
        return
    end

    timestamp = timestamp2
    startDecorWatch()
    table.clear(v11)
    markDecorNear(startValue, 3)

    if targetValue then
        markDecorNear(startValue:Lerp(targetValue, 0.33), 1.2)
        markDecorNear(startValue:Lerp(targetValue, 0.66), 1.2)
    end

    for v84 in v11 do
        if not v10[v84] then
            v10[v84] = true
            v84.LocalTransparencyModifier = 0.75
        end
    end

    for v85 in v10 do
        if not v11[v85] then
            v10[v85] = nil

            if not v85.Parent then
                continue
            end

            v85.LocalTransparencyModifier = 0
        end
    end
end

local v86 = {}

local function setAllyLtm(allyLtm, a89, localTransparencyModifier: number)
    --[[
      name: setAllyLtm
      line: 242
    ]]
    if allyLtm.dirty then
        table.clear(allyLtm.parts)

        for _, descendant in a89:GetDescendants() do
            if descendant:IsA("BasePart") or descendant:IsA("Decal") then
                table.insert(allyLtm.parts, descendant)
            end
        end

        allyLtm.dirty = false
    end

    for _, part in allyLtm.parts do
        if part.LocalTransparencyModifier ~= localTransparencyModifier and part.Parent then
            part.LocalTransparencyModifier = localTransparencyModifier
        end
    end
end

local function unfadeAlly(key)
    --[[
      name: unfadeAlly
      line: 259
      upvalues:
        v86 (copy, index: 1)
        setAllyLtm (copy, index: 2)
    ]]
    local allyLtm = v86[key]
    if not allyLtm then
        return
    end

    v86[key] = nil

    for _, conn in allyLtm.conns do
        conn:Disconnect()
    end

    allyLtm.dirty = true
    setAllyLtm(allyLtm, key, 0)
end

function v5.ClearAllies()
    --[[
      name: ClearAllies
      line: 272
      upvalues:
        v86 (copy, index: 1)
        setAllyLtm (copy, index: 2)
    ]]
    for v100 in v86 do
        if const allyLtm = v86[v100] then
            v86[v100] = nil

            for _, conn in allyLtm.conns do
                conn:Disconnect()
            end

            allyLtm.dirty = true
            setAllyLtm(allyLtm, v100, 0)
        end
    end
end

local function segmentDistance(a105, a106, a107)
    --[[
      name: segmentDistance
      line: 278
    ]]
    local v108 = a107 - a106
    local v109 = v108:Dot(v108)
    local v110 = not (1e-06 < v109) and 0 or math.clamp((a105 - a106):Dot(v108) / v109, 0, 1)

    return ((a106 + (v108 * v110)) - a105).Magnitude
end

local function isAlly(a112, a113)
    --[[
      name: isAlly
      line: 285
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    if a112 == a113 then
        return false
    end

    local matchId = localPlayer:GetAttribute("MatchId")

    if type(matchId) ~= "string" or matchId == "" or a112:GetAttribute("MatchId") ~= matchId then
        return false
    end

    local team = localPlayer:GetAttribute("Team")

    return team ~= nil and a112:GetAttribute("Team") == team
end

function v5.UpdateAllies(a116, a117, a118)
    --[[
      name: UpdateAllies
      line: 298
      upvalues:
        Fighters (copy, index: 1)
        v86 (copy, index: 2)
        isAlly (copy, index: 3)
        setAllyLtm (copy, index: 4)
    ]]
    local magnitude

    for _, v121 in Fighters.List() do
        local humanoid = v121:FindFirstChildOfClass("Humanoid")
        local humanoidRootPart = v121:FindFirstChild("HumanoidRootPart")
        local v124 = v86[v121] ~= nil
        local v125 = false

        if humanoid
            and 0 < humanoid.Health
            and humanoidRootPart
            and humanoidRootPart:IsA("BasePart")
            and isAlly(v121, a118)
        then
            local v126
            local head = v121:FindFirstChild("Head")
            local position = humanoidRootPart.Position
            local v129 = a117 - a116
            local v130 = v129:Dot(v129)
            local v131 = not (1e-06 < v130) and 0 or math.clamp((position - a116):Dot(v129) / v130, 0, 1)
            magnitude = ((a116 + (v129 * v131)) - position).Magnitude

            if head then
                if head:IsA("BasePart") then
                    local position2 = head.Position
                    local v133 = a117 - a116
                    local v134 = v133:Dot(v133)
                    local v135 = not (1e-06 < v134) and 0 or math.clamp((position2 - a116):Dot(v133) / v134, 0, 1)
                    v126 = math.min(magnitude, ((a116 + (v133 * v135)) - position2).Magnitude)
                else
                    v126 = magnitude
                end
            else
                v126 = magnitude
            end

            local v136 = v124 and 5.6 or 5
            v125 = v126 < v136
        end

        if v125 and not v124 then
            local allyLtm = {dirty = true, parts = {}, conns = {}}
            table.insert(
                allyLtm.conns,
                v121.DescendantAdded:Connect(
                    function()
                        --[[
                          line: 314
                          upvalues:
                            allyLtm (copy, index: 1)
                        ]]
                        allyLtm.dirty = true
                    end
                )
            )
            v86[v121] = allyLtm
            setAllyLtm(allyLtm, v121, 0.7)
        elseif v125 and v124 then
            local allyLtm = v86[v121]

            if allyLtm.dirty then
                setAllyLtm(allyLtm, v121, 0.7)
            end
        elseif v124 then
            local allyLtm = v86[v121]
            if not allyLtm then
                continue
            end

            v86[v121] = nil

            for _, conn in allyLtm.conns do
                conn:Disconnect()
            end

            allyLtm.dirty = true
            setAllyLtm(allyLtm, v121, 0)
        end
    end

    for v142 in v86 do
        if not v142.Parent then
            local allyLtm = v86[v142]
            if not allyLtm then
                continue
            end

            v86[v142] = nil

            for _, conn in allyLtm.conns do
                conn:Disconnect()
            end

            allyLtm.dirty = true
            setAllyLtm(allyLtm, v142, 0)
        end
    end
end

function v5.Stats()
    --[[
      name: Stats
      line: 335
      upvalues:
        v10 (copy, index: 1)
        v86 (copy, index: 2)
        decorParts (ref,  index: 3)
    ]]
    local count = 0
    local count2 = 0

    for _ in v10 do
        count += 1
    end

    for _ in v86 do
        count2 += 1
    end

    return {decorParts = decorParts, decorFaded = count, alliesFaded = count2}
end

return v5