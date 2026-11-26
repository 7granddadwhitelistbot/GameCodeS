local collectionService = game:GetService("CollectionService")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local shared = replicatedStorage:WaitForChild("Shared")
local childName = "Weapons"
local child = require(shared:WaitForChild(childName))
local v8 = {}
local localPlayer = players.LocalPlayer
local v10 = {"LinearVelocity", "VectorForce", "AlignOrientation", "AlignPosition", "AngularVelocity", "BodyVelocity", "BodyGyro", "BodyPosition", "BodyForce", "BodyAngularVelocity", "Torque"}
local v11 = {}

for _, v13 in v10 do
    v11[v13] = true
end

local v14 = {Tool = true, ForceField = true, Highlight = true, BillboardGui = true, SurfaceGui = true, Sound = true, SelectionBox = true, ProximityPrompt = true, ClickDetector = true, Explosion = true, Fire = true, Smoke = true, Sparkles = true}

local function strip(result)
    --[[
      name: strip
      line: 101
      upvalues:
        v14 (copy, index: 1)
        v11 (copy, index: 2)
    ]]
    for _, tag in result:GetTags() do
        result:RemoveTag(tag)
    end

    for _, v20 in {"MatchId", "Team", "CombatantId", "IsBot", "Frozen", "Blocking", "ShotNonce"} do
        result:SetAttribute(v20, nil)
    end

    for _, descendant in result:GetDescendants() do
        local v23
        local className = descendant.ClassName

        if descendant:IsA("ParticleEmitter") then
            v23 = descendant:FindFirstAncestorOfClass("Accessory") == nil
        elseif descendant:IsA("Trail") then
            v23 = descendant:FindFirstAncestorOfClass("Accessory") == nil
        elseif descendant:IsA("Beam") then
            v23 = descendant:FindFirstAncestorOfClass("Accessory") == nil
        else
            v23 = descendant:IsA("Light")
            v23 = v23 and descendant:FindFirstAncestorOfClass("Accessory") == nil
        end

        if descendant:IsA("LuaSourceContainer") or v14[className] or v11[className] or v23 then
            descendant:Destroy()
        else
            for _, tag in descendant:GetTags() do
                descendant:RemoveTag(tag)
            end

            if descendant:IsA("BasePart") then
                descendant.CanCollide = false
                descendant.CanQuery = false
                descendant.CanTouch = false
                descendant.LocalTransparencyModifier = 0
            elseif descendant:IsA("Decal") then
                descendant.LocalTransparencyModifier = 0
            end
        end
    end
end

local function rigidJoints(result)
    --[[
      name: rigidJoints
      line: 137
    ]]
    for _, descendant in result:GetDescendants() do
        if descendant:IsA("AnimationConstraint") or descendant:IsA("RigidConstraint") then
            local attachment0 = descendant.Attachment0
            local attachment1 = descendant.Attachment1
            local parent = attachment0 and attachment0.Parent
            local parent2 = attachment1 and attachment1.Parent

            if not attachment0
                or not attachment1
                or not parent
                or not parent2
                or not parent:IsA("BasePart")
                or not parent2:IsA("BasePart")
            then
                descendant:Destroy()
            else
                local jointInstance = if descendant:IsA("AnimationConstraint") then Instance.new("Motor6D") else Instance.new("Weld")
                jointInstance.Name = descendant.Name
                jointInstance.Part0 = parent
                jointInstance.Part1 = parent2
                jointInstance.C0 = attachment0.CFrame
                jointInstance.C1 = attachment1.CFrame
                jointInstance.Parent = parent2
                descendant:Destroy()
            end
        elseif descendant:IsA("BallSocketConstraint")
            or descendant:IsA("HingeConstraint")
            or descendant:IsA("NoCollisionConstraint")
        then
            descendant:Destroy()
        elseif descendant:IsA("Motor6D") then
            descendant.Transform = CFrame.identity
        end
    end
end

local function hasBody(a37)
    --[[
      name: hasBody
      line: 164
    ]]
    local head = a37:FindFirstChild("Head")
    local v39 = a37:FindFirstChild("UpperTorso") or a37:FindFirstChild("Torso")

    return head ~= nil and head:IsA("BasePart") and v39 ~= nil and v39:IsA("BasePart")
end

function v8.Snapshot(a40)
    --[[
      name: Snapshot
      line: 172
      upvalues:
        hasBody (copy, index: 1)
        strip (copy, index: 2)
        rigidJoints (copy, index: 3)
    ]]
    if not a40.Parent then
        return nil, "gone"
    end
    if not a40:FindFirstChildOfClass("Humanoid") then
        return nil, "nohum"
    end
    if not a40:FindFirstChild("HumanoidRootPart") then
        return nil, "noroot"
    end
    if not hasBody(a40) then
        return nil, "nobody"
    end

    local archivable = a40.Archivable
    a40.Archivable = true
    local success, result = pcall(
        function()
            --[[
              line: 184
              upvalues:
                a40 (copy, index: 1)
            ]]
            return a40:Clone()
        end
    )
    a40.Archivable = archivable

    if not success or not result then
        return nil, "noclone"
    end

    if not hasBody(result) or not result:FindFirstChild("HumanoidRootPart") then
        result:Destroy()
        return nil, "noclone"
    end

    strip(result)
    rigidJoints(result)

    return result, nil
end

local function aliveWithBody(a45)
    --[[
      name: aliveWithBody
      line: 202
      upvalues:
        hasBody (copy, index: 1)
    ]]
    local humanoid = a45:FindFirstChildOfClass("Humanoid")
    return humanoid ~= nil and 0 < humanoid.Health and a45:FindFirstChild("HumanoidRootPart") ~= nil and hasBody(a45)
end

function v8.FindLive(a47)
    --[[
      name: FindLive
      line: 208
      upvalues:
        collectionService (copy, index: 1)
        players (copy, index: 2)
    ]]
    for _, combatant in collectionService:GetTagged("Combatant") do
        if combatant:IsA("Model") and combatant:GetAttribute("CombatantId") == a47 and combatant.Parent then
            return combatant
        end
    end

    local character

    for _, player in players:GetPlayers() do
        character = player.Character

        if character and character:GetAttribute("CombatantId") == a47 and character.Parent then
            return character
        end
    end

    return nil
end

local v53 = {}
local matchId = ""
local v55 = {}
local v56 = {}
local isBusy = false

local function pump()
    --[[
      name: pump
      line: 231
      upvalues:
        isBusy (ref,  index: 1)
        v55 (copy, index: 2)
        v56 (copy, index: 3)
        v8 (copy, index: 4)
        hasBody (copy, index: 5)
        v53 (copy, index: 6)
    ]]
    if isBusy then
        return
    end

    isBusy = true

    task.spawn(
        function()
            --[[
              line: 236
              upvalues:
                v55 (copy, index: 1)
                v56 (copy, index: 2)
                v8 (copy, index: 3)
                hasBody (copy, index: 4)
                v53 (copy, index: 5)
                isBusy (ref,  index: 6)
            ]]
            local v59
            v59 = v55

            while 0 < #v59 do
                local removedValue = table.remove(v59, 1)
                v56[removedValue] = nil

                if const live = v8.FindLive(removedValue) then
                    local humanoid = live:FindFirstChildOfClass("Humanoid")

                    if humanoid ~= nil
                        and 0 < humanoid.Health
                        and live:FindFirstChild("HumanoidRootPart") ~= nil
                        and hasBody(live)
                    then
                        if const v63 = v8.Snapshot(live) then
                            local v64 = v53[removedValue]
                            v53[removedValue] = v63

                            if v64 then
                                v64:Destroy()
                            end
                        end
                    end
                end

                task.wait()
                v59 = v55
            end

            isBusy = false
        end
    )
end

local function clearCache()
    --[[
      name: clearCache
      line: 259
      upvalues:
        v53 (copy, index: 1)
        v55 (copy, index: 2)
        v56 (copy, index: 3)
    ]]
    for _, v67 in v53 do
        v67:Destroy()
    end

    table.clear(v53)
    table.clear(v55)
    table.clear(v56)
end

function v8.CacheMatch()
    --[[
      name: CacheMatch
      line: 270
      upvalues:
        localPlayer (copy, index: 1)
        matchId (ref,  index: 2)
        clearCache (copy, index: 3)
        v56 (copy, index: 4)
        v55 (copy, index: 5)
        collectionService (copy, index: 6)
        players (copy, index: 7)
        isBusy (ref,  index: 8)
        v8 (copy, index: 9)
        hasBody (copy, index: 10)
        v53 (copy, index: 11)
    ]]
    local matchId2 = localPlayer:GetAttribute("MatchId")

    if type(matchId2) ~= "string" or matchId2 == "" then
        return
    end

    if matchId2 ~= matchId then
        clearCache()
        matchId = matchId2
    end

    local function consider(instance: Instance?)
        --[[
          name: consider
          line: 279
          upvalues:
            matchId2 (copy, index: 1)
            v56 (copy, index: 2)
            v55 (copy, index: 3)
        ]]
        if instance and instance:IsA("Model") and instance:GetAttribute("MatchId") == matchId2 then
            local combatantId = instance:GetAttribute("CombatantId")

            if type(combatantId) == "string" and combatantId ~= "" and not v56[combatantId] then
                v56[combatantId] = true
                table.insert(v55, combatantId)
            end
        end
    end

    for _, combatant in collectionService:GetTagged("Combatant") do
        consider(combatant)
    end

    for _, player in players:GetPlayers() do
        consider(player.Character)
    end

    if isBusy then
        return
    end

    isBusy = true

    task.spawn(
        function()
            --[[
              line: 236
              upvalues:
                v55 (copy, index: 1)
                v56 (copy, index: 2)
                v8 (copy, index: 3)
                hasBody (copy, index: 4)
                v53 (copy, index: 5)
                isBusy (ref,  index: 6)
            ]]
            local v76
            v76 = v55

            while 0 < #v76 do
                local removedValue = table.remove(v76, 1)
                v56[removedValue] = nil

                if const live = v8.FindLive(removedValue) then
                    local humanoid = live:FindFirstChildOfClass("Humanoid")

                    if humanoid ~= nil
                        and 0 < humanoid.Health
                        and live:FindFirstChild("HumanoidRootPart") ~= nil
                        and hasBody(live)
                    then
                        if const v80 = v8.Snapshot(live) then
                            local v81 = v53[removedValue]
                            v53[removedValue] = v80

                            if v81 then
                                v81:Destroy()
                            end
                        end
                    end
                end

                task.wait()
                v76 = v55
            end

            isBusy = false
        end
    )
end

function v8.ClearCache()
    --[[
      name: ClearCache
      line: 298
      upvalues:
        clearCache (copy, index: 1)
        matchId (ref,  index: 2)
    ]]
    clearCache()
    matchId = ""
end

local weapons = nil

local function weaponModel(childName: string)
    --[[
      name: weaponModel
      line: 306
      upvalues:
        weapons (ref,  index: 1)
        replicatedStorage (copy, index: 2)
    ]]
    if not weapons or not weapons.Parent then
        local assets = replicatedStorage:FindFirstChild("Assets")
        weapons = assets and assets:FindFirstChild("Weapons")
    end

    return weapons and weapons:FindFirstChild(childName)
end

local function makeTool(a87: string)
    --[[
      name: makeTool
      line: 314
      upvalues:
        child (copy, index: 1)
        weapons (ref,  index: 2)
        replicatedStorage (copy, index: 3)
    ]]
    local v88 = child.Get(a87)

    if not weapons or not weapons.Parent then
        local assets = replicatedStorage:FindFirstChild("Assets")
        weapons = assets and assets:FindFirstChild("Weapons")
    end

    local child3 = weapons and weapons:FindFirstChild(a87)

    if not v88 or not child3 or v88.hotbar == false then
        return nil
    end

    local parent = Instance.new("Tool")
    parent.Name = v88.name or a87
    parent.CanBeDropped = false
    parent.ManualActivationOnly = true
    parent.RequiresHandle = true
    parent:SetAttribute("WeaponId", a87)
    parent:SetAttribute("Kind", v88.kind)
    local child4 = child3:Clone()

    for _, child2 in child4:GetChildren() do
        child2.Parent = parent
    end

    child4:Destroy()
    local handle = parent:FindFirstChild("Handle")

    if not handle or not handle:IsA("BasePart") then
        parent:Destroy()
        return nil
    end

    local rightGripAttachment = handle:FindFirstChild("RightGripAttachment")

    if rightGripAttachment and rightGripAttachment:IsA("Attachment") then
        parent.Grip = rightGripAttachment.CFrame
    end

    for _, descendant in parent:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = false
            descendant.CanCollide = false
            descendant.CanQuery = false
            descendant.CanTouch = false
            descendant.Massless = true
        elseif descendant:IsA("LuaSourceContainer") then
            descendant:Destroy()
        end
    end

    return parent
end

local function attach(item, tool)
    --[[
      name: attach
      line: 355
    ]]
    local rightHand = item.rightHand
    local handle = tool:FindFirstChild("Handle")

    if not rightHand or not handle then
        return
    end

    if not handle:FindFirstChild("ReplayGrip") then
        local replayGrip = Instance.new("Weld")
        replayGrip.Name = "ReplayGrip"
        replayGrip.Part0 = rightHand
        replayGrip.Part1 = handle
        local rightGripAttachment = rightHand:FindFirstChild("RightGripAttachment")
        replayGrip.C0 = if rightGripAttachment and rightGripAttachment:IsA("Attachment") then rightGripAttachment.CFrame else CFrame.new(0, -rightHand.Size.Y / 2, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
        replayGrip.C1 = tool.Grip
        replayGrip.Parent = handle
    end

    tool.Parent = item.model
end

function v8.SetItem(item, itemId: string)
    --[[
      name: SetItem
      line: 376
      upvalues:
        makeTool (copy, index: 1)
        attach (copy, index: 2)
    ]]
    if item.itemId == itemId then
        return false
    elseif const tool = item.itemId and item.tools[item.itemId] then
        tool.Parent = nil
    end

    item.itemId = itemId

    if itemId then
        local tool2 = item.tools[itemId]
        if tool2 == nil then
            tool2 = makeTool(itemId) or false
            item.tools[itemId] = tool2
        end

        if tool2 then
            attach(item, tool2)
        end
    end

    return true
end

local function findPart(a111, a112)
    --[[
      name: findPart
      line: 400
    ]]
    local v113 = a111:FindFirstChild(a112)

    if v113 and v113:IsA("BasePart") then
        return v113
    end

    local v114 = a111:FindFirstChild(a112, true)

    if v114 and v114:IsA("BasePart") then
        return v114
    end

    return nil
end

local function greyCopy(a116, a117: boolean)
    --[[
      name: greyCopy
      line: 412
      upvalues:
        v8 (copy, index: 1)
    ]]
    local v118

    if not a116 then
        return nil
    end

    if a116.Parent and not a117 then
        v118 = v8.Snapshot(a116)
    else
        local success, result = pcall(
            function()
                --[[
                  line: 420
                  upvalues:
                    a116 (copy, index: 1)
                ]]
                local archivable = a116.Archivable
                a116.Archivable = true
                local v122 = a116:Clone()
                a116.Archivable = archivable

                return v122
            end
        )

        if success then
            v118 = result
        else
            v118 = nil
        end

        if v118 and a117 then
            for _, descendant in v118:GetDescendants() do
                if descendant:IsA("Tool") or descendant:IsA("Highlight") then
                    descendant:Destroy()
                end
            end
        end
    end

    if not v118 then
        return nil
    end

    for _, descendant in v118:GetDescendants() do
        if descendant:IsA("Accessory")
            or descendant:IsA("Clothing")
            or descendant:IsA("ShirtGraphic")
            or descendant:IsA("Decal") and descendant.Name ~= "face"
        then
            descendant:Destroy()
        elseif descendant:IsA("BodyColors") then
            local color3 = Color3.fromRGB(150, 150, 156)
            descendant.HeadColor3 = color3
            descendant.TorsoColor3 = color3
            descendant.LeftArmColor3 = color3
            descendant.RightArmColor3 = color3
            descendant.LeftLegColor3 = color3
            descendant.RightLegColor3 = color3
        end
    end

    return v118
end

local function standIn()
    --[[
      name: standIn
      line: 451
      upvalues:
        localPlayer (copy, index: 1)
        greyCopy (copy, index: 2)
        v53 (copy, index: 3)
    ]]
    local character = localPlayer.Character

    if const v130 = if character and character.Parent then greyCopy(character, false) else nil then
        return v130
    end

    local v131

    for _, v131 in v53 do
        return (greyCopy(v131, true))
    end

    return nil
end

local function assemble(model, index, id: string, name, team, folder)
    --[[
      name: assemble
      line: 464
    ]]
    local humanoidRootPart = model:FindFirstChild("HumanoidRootPart")
    local humanoid = model:FindFirstChildOfClass("Humanoid")

    if humanoidRootPart and humanoidRootPart:IsA("BasePart") and humanoid then
        pcall(
            function()
                --[[
                  line: 472
                  upvalues:
                    humanoid (copy, index: 1)
                ]]
                humanoid.EvaluateStateMachine = false
            end
        )
        humanoid.BreakJointsOnDeath = false
        humanoid.RequiresNeck = false

        if humanoid.MaxHealth <= 0 then
            humanoid.MaxHealth = 100
        end

        humanoid.Health = humanoid.MaxHealth
        humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
        humanoidRootPart.Anchored = true
        humanoidRootPart.Transparency = 1
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if not animator then
            animator = Instance.new("Animator")
            animator.Parent = humanoid
        end

        model.Name = `ReplayPuppet_{index}`
        model:SetAttribute("ReplayPuppet", id)
        model:SetAttribute("DisplayName", name)
        local parts = {}

        for _, child in model:GetChildren() do
            if child:IsA("BasePart") then
                parts[child.Name] = child
            end
        end

        local v146 = parts.RightHand or parts["Right Arm"]

        return {itemId = nil, hold = nil, visible = false, alive = true, blocking = false, loco = nil, standIn = false, src = "", liveParts = -1, index = index, id = id, name = name, team = team, model = model, root = humanoidRootPart, hum = humanoid, animator = animator, rightHand = v146, parts = parts, tools = {}, folder = folder}, nil
    end

    model:Destroy()
    local v147 = nil

    if humanoid then
        return v147, "noroot"
    end

    return v147, "nohum"
end

local function isBody(a149, a150)
    --[[
      name: isBody
      line: 527
    ]]
    if not a149:IsA("BasePart") or a149.Name == "HumanoidRootPart" or a149.Name == "TribesHull" then
        return false
    end

    local firstAncestorOfClass = a149:FindFirstAncestorOfClass("Tool")

    return firstAncestorOfClass == nil or not firstAncestorOfClass:IsDescendantOf(a150)
end

local function bodyCount(live)
    --[[
      name: bodyCount
      line: 535
    ]]
    local count = 0

    for _, descendant in live:GetDescendants() do
        local v157

        if not descendant:IsA("BasePart")
            or descendant.Name == "HumanoidRootPart"
            or descendant.Name == "TribesHull"
        then
            v157 = false
        else
            local firstAncestorOfClass = descendant:FindFirstAncestorOfClass("Tool")
            v157 = firstAncestorOfClass == nil or not firstAncestorOfClass:IsDescendantOf(live)
        end

        if v157 then
            count += 1
        end
    end

    return count
end

local isStudio = runService:IsStudio()

local function debugBreak(a161, text: string)
    --[[
      name: debugBreak
      line: 549
      upvalues:
        isStudio (copy, index: 1)
    ]]
    if not isStudio or string.sub(text, 1, 1) ~= "p" then
        return nil
    end

    local replayDiagBreak = workspace:GetAttribute("ReplayDiagBreak")

    if type(replayDiagBreak) ~= "string" or replayDiagBreak == "" then
        return nil
    end

    if replayDiagBreak ~= "noroot" then
        if replayDiagBreak ~= "tr" and replayDiagBreak ~= "ltm" then
            if replayDiagBreak ~= "loose" and replayDiagBreak ~= "far" then
                return replayDiagBreak
            end

            for _, descendant in a161:GetDescendants() do
                if descendant:IsA("JointInstance") and descendant.Name == "Root"
                    or descendant:IsA("Attachment") and descendant.Name == "RootRigAttachment"
                then
                    descendant:Destroy()
                end
            end

            if replayDiagBreak == "far" then
                for _, descendant in a161:GetDescendants() do
                    local v168

                    if not descendant:IsA("BasePart")
                        or descendant.Name == "HumanoidRootPart"
                        or descendant.Name == "TribesHull"
                    then
                        v168 = false
                    else
                        local firstAncestorOfClass = descendant:FindFirstAncestorOfClass("Tool")
                        v168 = firstAncestorOfClass == nil or not firstAncestorOfClass:IsDescendantOf(a161)
                    end

                    if v168 then
                        descendant.Anchored = true
                        descendant.CFrame += Vector3.new(0, 60, 0)
                    end
                end
            end

            return replayDiagBreak
        end

        for _, descendant in a161:GetDescendants() do
            local v172

            if not descendant:IsA("BasePart")
                or descendant.Name == "HumanoidRootPart"
                or descendant.Name == "TribesHull"
            then
                v172 = false
            else
                local firstAncestorOfClass = descendant:FindFirstAncestorOfClass("Tool")
                v172 = firstAncestorOfClass == nil or not firstAncestorOfClass:IsDescendantOf(a161)
            end

            if v172 then
                if replayDiagBreak == "tr" then
                    descendant.Transparency = 1
                else
                    descendant.LocalTransparencyModifier = 1
                end
            end
        end

        return replayDiagBreak
    elseif const humanoidRootPart = a161:FindFirstChild("HumanoidRootPart") then
        humanoidRootPart:Destroy()
        return replayDiagBreak
    end

    return replayDiagBreak
end

local v175 = {"live", "cache", "standin", "donor"}
local v176 = {"cache", "live", "standin", "donor"}

function v8.Build(index, key: string, name, team, folder, a182, a183)
    --[[
      name: Build
      line: 600
      upvalues:
        v8 (copy, index: 1)
        bodyCount (copy, index: 2)
        v53 (copy, index: 3)
        hasBody (copy, index: 4)
        v176 (copy, index: 5)
        v175 (copy, index: 6)
        standIn (copy, index: 7)
        greyCopy (copy, index: 8)
        debugBreak (copy, index: 9)
        assemble (copy, index: 10)
    ]]
    local v184
    local src, v186, skipped, v188
    local live = v8.FindLive(key)
    local liveParts = not live and -1 or bodyCount(live)

    if live and v53[key] then
        local humanoid = live:FindFirstChildOfClass("Humanoid")

        if humanoid ~= nil
            and 0 < humanoid.Health
            and live:FindFirstChild("HumanoidRootPart") ~= nil
            and hasBody(live)
        then
            v184 = v175
        else
            v184 = v176
        end
    else
        v184 = v175
    end

    local v192 = 1

    if a182 then
        for v193, v194 in v184 do
            if v194 == a182 then
                v192 = v193 + 1
            end
        end
    end

    skipped = nil

    for index2 = v192, #v184 do
        local v196
        src = v184[index2]
        local v197 = nil
        local v198 = nil

        if src == "live" then
            if live then
                local v199
                v199, v198 = v8.Snapshot(live)
                v197 = v199
            end
        elseif src == "cache" then
            v197 = if const v200 = v53[key] then v200:Clone() else nil
        elseif src ~= "standin" then
            if a183 then
                v197 = greyCopy(a183, true)
            end
        else
            v197 = standIn()
        end

        local v201 = nil

        if v197 then
            v188 = if src == "live" then debugBreak(v197, key) else v201
        else
            v188 = v201
        end

        v186 = nil

        if v197 then
            local v202
            v186, v202 = assemble(v197, index, key, name, team, folder)
            v196 = v202
        else
            v196 = v198
        end

        if v196 then
            skipped = skipped or v196 .. ":" .. src
        end

        if v186 then
            v186.skipped = skipped
            v186.src = src
            v186.standIn = src == "standin" or src == "donor"
            v186.liveParts = liveParts

            if v188 == "unparent" then
                v186.debugUnparent = true
            end

            return v186, skipped, liveParts
        end
    end

    return nil, skipped, liveParts
end

function v8.Inspect(a203, a204)
    --[[
      name: Inspect
      line: 656
    ]]
    local model = a203.model
    local position = a203.root.Position
    local parented = model:IsDescendantOf(workspace)
    local v208 = {parts = 0, vis = 0, tr = 0, ltm = 0, far = 0, loose = 0, wrap = 0, parented = parented}

    for _, descendant in model:GetDescendants() do
        if descendant:IsA("WrapLayer") then
            v208.wrap += 1
        else
            local v211

            if not descendant:IsA("BasePart")
                or descendant.Name == "HumanoidRootPart"
                or descendant.Name == "TribesHull"
            then
                v211 = false
            else
                local firstAncestorOfClass = descendant:FindFirstAncestorOfClass("Tool")
                v211 = firstAncestorOfClass == nil or not firstAncestorOfClass:IsDescendantOf(model)
            end

            if v211 then
                local v213
                v208.parts += 1
                local v214 = false

                if 0.95 <= descendant.Transparency then
                    v208.tr += 1
                    v214 = true
                end

                if not (0.95 <= descendant.LocalTransparencyModifier) then
                    v213 = v214
                else
                    v208.ltm += 1
                    v213 = true
                end

                if not v213 then
                    v208.vis += 1
                end

                if a204 < (descendant.Position - position).Magnitude then
                    v208.far += 1
                end

                if parented and not descendant:IsGrounded() then
                    v208.loose += 1
                end
            end
        end
    end

    return v208
end

function v8.SetVisible(visible2, visible)
    --[[
      name: SetVisible
      line: 690
    ]]
    if visible2.visible == visible then
        return
    end

    visible2.visible = visible
    visible2.model.Parent = if visible then visible2.folder else nil
end

function v8.Part(a217, partKey)
    --[[
      name: Part
      line: 699
    ]]
    if partKey == "Handle" then
        return a217.parts.Head or a217.root
    end

    local v219 = a217.parts[partKey]
    if not v219 then
        local model = a217.model
        local v221 = model:FindFirstChild(partKey)

        if v221 and v221:IsA("BasePart") then
            v219 = v221
        else
            local v222 = model:FindFirstChild(partKey, true)
            v219 = if v222 and v222:IsA("BasePart") then v222 else nil
        end

        return v219 or a217.parts.UpperTorso or a217.root
    end

    return v219
end

function v8.Destroy(a223)
    --[[
      name: Destroy
      line: 706
    ]]
    for _, tool in a223.tools do
        if tool then
            tool:Destroy()
        end
    end

    a223.model:Destroy()
end

return v8