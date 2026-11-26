local players = game:GetService("Players")
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local isStudio = runService:IsStudio()
local v5 = {}
local v6 = {"LuaSourceContainer", "JointInstance", "WeldConstraint", "NoCollisionConstraint", "Constraint", "BodyMover", "Sound", "Animator", "AnimationController", "HumanoidDescription", "Humanoid", "ForceField", "BillboardGui", "SurfaceGui", "ProximityPrompt", "ClickDetector", "Highlight", "ValueBase", "Configuration", "Backpack"}
local v7 = {"ParticleEmitter", "Trail", "Beam", "Light", "Fire", "Smoke", "Sparkles"}

local function isA(a9, a10)
    --[[
      name: isA
      line: 84
    ]]
    for _, v12 in a10 do
        if a9:IsA(v12) then
            return true
        end
    end

    return false
end

local localPlayer = players.LocalPlayer
local model = nil
local v15 = nil
local v16 = nil
local v17 = {}
local v18 = {}
local v19 = {}
local v20 = {}
local v21 = true
local v22 = {}
local partList = {}
local cframeList = {}
local v25 = {}
local v26 = true
local proxyShown = false
local v28 = nil
local timestamp = 0
local bindableEvent = Instance.new("BindableEvent")
local v31 = {builds = 0, parts = 0, copies = 0, frames = 0, jointsStripped = 0, hideWrites = 0, props = 0, maxMs = 0, collisionResets = 0, totalMs = 0}
v5.Changed = bindableEvent.Event

local function stripInstance(a33)
    --[[
      name: stripInstance
      line: 121
    ]]
    for _, tag in a33:GetTags() do
        a33:RemoveTag(tag)
    end

    for text in a33:GetAttributes() do
        if string.sub(text, 1, 3) ~= "RBX" then
            pcall(a33.SetAttribute, a33, text, nil)
        end
    end
end

local function hideReal(key, a39)
    --[[
      name: hideReal
      line: 133
      upvalues:
        v20 (copy, index: 1)
        v31 (copy, index: 2)
    ]]
    if a39 then
        v20[key] = true

        if key.LocalTransparencyModifier ~= 1 then
            key.LocalTransparencyModifier = 1
            v31.hideWrites += 1
        end
    else
        v20[key] = nil

        if key.Parent and key.LocalTransparencyModifier ~= 0 then
            key.LocalTransparencyModifier = 0
        end
    end
end

local function noCollisions(model: Model?)
    --[[
      name: noCollisions
      line: 154
      upvalues:
        v31 (copy, index: 1)
    ]]
    for _, descendant in model:GetDescendants() do
        if descendant:IsA("BasePart") then
            if descendant.CanCollide then
                descendant.CanCollide = false
                v31.collisionResets += 1
            end

            if descendant.CanQuery then
                descendant.CanQuery = false
            end

            if not descendant.CanTouch then
                continue
            end

            descendant.CanTouch = false
        end
    end
end

local function prepCopy(a45, a46)
    --[[
      name: prepCopy
      line: 171
    ]]
    a45.Anchored = true
    a45.CanCollide = false
    a45.CanQuery = false
    a45.CanTouch = false
    a45.Massless = true
    a45.LocalTransparencyModifier = 0
    a45.CastShadow = a46.CastShadow
end

local function unmap(key)
    --[[
      name: unmap
      line: 181
      upvalues:
        v17 (copy, index: 1)
        v21 (ref,  index: 2)
    ]]
    local v49 = v17[key]
    if not v49 then
        return
    end

    v17[key] = nil
    v21 = true

    for _, descendant in key:GetDescendants() do
        v17[descendant] = nil
    end

    v49:Destroy()
end

local function pair(a53, a54)
    --[[
      name: pair
      line: 196
      upvalues:
        v17 (copy, index: 1)
        pair (copy, index: 2)
    ]]
    v17[a53] = a54
    local children = a54:GetChildren()
    local v56 = {}
    local v57 = 1

    for _, child in a53:GetChildren() do
        local child2
        local child3

        for childKey = v57, #children do
            child3 = children[childKey]

            if not v56[child3] and child3.Name == child.Name and child3.ClassName == child.ClassName then
                child2 = child3
                v56[child3] = true

                if childKey == v57 then
                    v57 += 1
                end

                break
            end
        end

        if child2 then
            pair(child, child2)
        end
    end
end

local function clean(a64)
    --[[
      name: clean
      line: 222
      upvalues:
        v17 (copy, index: 1)
        v6 (copy, index: 2)
        v31 (copy, index: 3)
        stripInstance (copy, index: 4)
        v7 (copy, index: 5)
    ]]
    local v65 = {a64}

    for _, descendant in a64:GetDescendants() do
        table.insert(v65, descendant)
    end

    for _, v69 in v65 do
        if const v70 = v17[v69] then
            if v69.Name ~= "TribesHull" and v69.Name ~= "TribesBubbleAnchor" then
                local v71
                v71 = false

                for _, v73 in v6 do
                    if v69:IsA(v73) then
                        v71 = true
                        break
                    end
                end

                if v71 then
                    if v69:IsA("JointInstance") or v69:IsA("WeldConstraint") or v69:IsA("Constraint") then
                        v31.jointsStripped += 1
                    end

                    v17[v69] = nil

                    for _, descendant in v69:GetDescendants() do
                        v17[descendant] = nil
                    end

                    if v70.Parent then
                        v70:Destroy()
                    end
                else
                    stripInstance(v70)

                    if v70:IsA("BasePart") and v69:IsA("BasePart") then
                        v70.Anchored = true
                        v70.CanCollide = false
                        v70.CanQuery = false
                        v70.CanTouch = false
                        v70.Massless = true
                        v70.LocalTransparencyModifier = 0
                        v70.CastShadow = v69.CastShadow
                    else
                        local v76
                        v76 = false

                        for _, v78 in v7 do
                            if v70:IsA(v78) then
                                v76 = true
                                break
                            end
                        end

                        if v76 then
                            v70.Enabled = false
                        elseif v70:IsA("Tool") then
                            local parent = Instance.new("Model")
                            parent.Name = v70.Name

                            for _, child in v70:GetChildren() do
                                child.Parent = parent
                            end

                            parent.Parent = v70.Parent
                            v17[v69] = parent
                            v70:Destroy()
                        end
                    end
                end
            else
                if v69:IsA("JointInstance") or v69:IsA("WeldConstraint") or v69:IsA("Constraint") then
                    v31.jointsStripped += 1
                end

                v17[v69] = nil

                for _, descendant in v69:GetDescendants() do
                    v17[descendant] = nil
                end

                if v70.Parent then
                    v70:Destroy()
                end
            end
        end
    end
end

local function add(a83)
    --[[
      name: add
      line: 266
      upvalues:
        v17 (copy, index: 1)
        model (ref,  index: 2)
        v15 (ref,  index: 3)
        v6 (copy, index: 4)
        pair (copy, index: 5)
        clean (copy, index: 6)
        noCollisions (copy, index: 7)
        v21 (ref,  index: 8)
    ]]
    if v17[a83] or not model or not v15 then
        return
    end

    local v84 = a83.Parent
    v84 = v84 and v17[v84]

    if not v84 then
        return
    end

    if a83.Name ~= "TribesHull" and a83.Name ~= "TribesBubbleAnchor" then
        local v85 = false

        for _, v87 in v6 do
            if a83:IsA(v87) then
                v85 = true
                break
            end
        end

        if not v85 then
            if not a83.Archivable then
                return
            end

            local success, result = pcall(
                function()
                    --[[
                      line: 281
                      upvalues:
                        a83 (copy, index: 1)
                    ]]
                    return a83:Clone()
                end
            )

            if not success or not result then
                return
            end

            pair(a83, result)
            clean(a83)

            if const v90 = v17[a83] then
                v90.Parent = v84

                if model and model.Parent then
                    noCollisions(model)
                end
            end

            v21 = true
        end
    end
end

local function rebuildLists()
    --[[
      name: rebuildLists
      line: 299
      upvalues:
        v21 (ref,  index: 1)
        v18 (copy, index: 2)
        v19 (copy, index: 3)
        v22 (copy, index: 4)
        partList (copy, index: 5)
        v17 (copy, index: 6)
        cframeList (copy, index: 7)
        v31 (copy, index: 8)
    ]]
    v21 = false
    table.clear(v18)
    table.clear(v19)
    table.clear(v22)
    table.clear(partList)

    for real, copy in v17 do
        if real:IsA("BasePart") and copy:IsA("BasePart") then
            if real.Parent and copy.Parent then
                table.insert(v18, {t = -1, real = real, copy = copy, color = copy.Color, mat = copy.Material})
                table.insert(v22, real)
                table.insert(partList, copy)
            end
        elseif real:IsA("Decal") and copy:IsA("Decal") then
            table.insert(v19, {t = -1, real = real, copy = copy})
        end
    end

    table.clear(cframeList)
    v31.parts = #v22
    v31.copies = #partList
end

local function disconnectAll()
    --[[
      name: disconnectAll
      line: 321
      upvalues:
        v25 (copy, index: 1)
    ]]
    for _, v96 in v25 do
        v96:Disconnect()
    end

    table.clear(v25)
end

local function unhideAll()
    --[[
      name: unhideAll
      line: 329
      upvalues:
        v20 (copy, index: 1)
    ]]
    for v98 in v20 do
        if v98.Parent then
            v98.LocalTransparencyModifier = 0
        end
    end

    table.clear(v20)
end

local function destroy()
    --[[
      name: destroy
      line: 338
      upvalues:
        v25 (copy, index: 1)
        v20 (copy, index: 2)
        model (ref,  index: 3)
        v15 (ref,  index: 4)
        v16 (ref,  index: 5)
        v17 (copy, index: 6)
        v21 (ref,  index: 7)
        rebuildLists (copy, index: 8)
        proxyShown (ref,  index: 9)
        bindableEvent (copy, index: 10)
    ]]
    for _, v101 in v25 do
        v101:Disconnect()
    end

    table.clear(v25)

    for v102 in v20 do
        if v102.Parent then
            v102.LocalTransparencyModifier = 0
        end
    end

    table.clear(v20)

    if model then
        model:Destroy()
    end

    model = nil
    v15 = nil
    v16 = nil
    table.clear(v17)
    v21 = true
    rebuildLists()

    if proxyShown then
        proxyShown = false
        bindableEvent:Fire(nil)
    end
end

local function build(key, a105)
    --[[
      name: build
      line: 354
      upvalues:
        destroy (copy, index: 1)
        v15 (ref,  index: 2)
        v16 (ref,  index: 3)
        model (ref,  index: 4)
        v17 (copy, index: 5)
        add (copy, index: 6)
        v25 (copy, index: 7)
        v31 (copy, index: 8)
        proxyShown (ref,  index: 9)
        v20 (copy, index: 10)
        v21 (ref,  index: 11)
    ]]
    destroy()
    local tribesDrawnBody = Instance.new("Model")
    tribesDrawnBody.Name = "TribesDrawnBody"
    v15 = key
    v16 = a105
    model = tribesDrawnBody
    v17[key] = tribesDrawnBody

    for _, child in key:GetChildren() do
        add(child)
    end

    local humanoid2 = Instance.new("Humanoid")
    local humanoid = key:FindFirstChildOfClass("Humanoid")
    humanoid2.RigType = if humanoid then humanoid.RigType else Enum.HumanoidRigType.R15
    humanoid2.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    humanoid2.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
    humanoid2.RequiresNeck = false
    humanoid2.BreakJointsOnDeath = false
    humanoid2.AutomaticScalingEnabled = false
    humanoid2.EvaluateStateMachine = false
    humanoid2.Parent = tribesDrawnBody

    table.insert(
        v25,
        tribesDrawnBody.DescendantAdded:Connect(
            function(descendant: Instance)
                --[[
                  line: 374
                  upvalues:
                    v31 (copy, index: 1)
                ]]
                if descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint") or descendant:IsA("Constraint") then
                    v31.jointsStripped += 1

                    task.defer(
                        function()
                            --[[
                              line: 377
                              upvalues:
                                descendant (copy, index: 1)
                            ]]
                            if descendant.Parent then
                                descendant:Destroy()
                            end
                        end
                    )
                end
            end
        )
    )

    table.insert(
        v25,
        key.DescendantAdded:Connect(
            function(key)
                --[[
                  line: 384
                  upvalues:
                    add (copy, index: 1)
                    proxyShown (ref,  index: 2)
                    v20 (copy, index: 3)
                    v31 (copy, index: 4)
                ]]
                add(key)

                if proxyShown and (key:IsA("BasePart") or key:IsA("Decal")) then
                    v20[key] = true

                    if key.LocalTransparencyModifier ~= 1 then
                        key.LocalTransparencyModifier = 1
                        v31.hideWrites += 1
                    end
                end
            end
        )
    )

    table.insert(
        v25,
        key.DescendantRemoving:Connect(
            function(key)
                --[[
                  line: 390
                  upvalues:
                    v20 (copy, index: 1)
                    v17 (copy, index: 2)
                    v21 (ref,  index: 3)
                ]]
                if v20[key] then
                    v20[key] = nil
                    pcall(
                        function()
                            --[[
                              line: 394
                              upvalues:
                                key (copy, index: 1)
                            ]]
                            key.LocalTransparencyModifier = 0
                        end
                    )
                end

                local v114 = v17[key]
                if not v114 then
                    return
                end

                v17[key] = nil
                v21 = true

                for _, descendant in key:GetDescendants() do
                    v17[descendant] = nil
                end

                v114:Destroy()
            end
        )
    )

    v31.builds += 1
    v21 = true
end

local function parentFor()
    --[[
      name: parentFor
      line: 404
      upvalues:
        workspace (copy, index: 1)
    ]]
    return workspace.CurrentCamera
end

local function setShown(shown: boolean)
    --[[
      name: setShown
      line: 409
      upvalues:
        model (ref,  index: 1)
        v15 (ref,  index: 2)
        proxyShown (ref,  index: 3)
        workspace (copy, index: 4)
        noCollisions (copy, index: 5)
        v20 (copy, index: 6)
        v31 (copy, index: 7)
        localPlayer (copy, index: 8)
        bindableEvent (copy, index: 9)
    ]]
    local model2
    local model3 = model
    local v122 = v15

    if model3 then
        if not v122 then
            shown = false
        end
    else
        shown = false
    end

    if shown == proxyShown then
        return
    end

    proxyShown = shown

    if shown then
        model3.Parent = workspace.CurrentCamera
        noCollisions(model3)

        for _, descendant in v122:GetDescendants() do
            if descendant:IsA("BasePart") or descendant:IsA("Decal") then
                v20[descendant] = true

                if descendant.LocalTransparencyModifier ~= 1 then
                    descendant.LocalTransparencyModifier = 1
                    v31.hideWrites += 1
                end
            end
        end
    else
        if model3 then
            model3.Parent = nil
        end

        if localPlayer:GetAttribute("ReplayPlaying") == true then
            table.clear(v20)
        else
            for v125 in v20 do
                if v125.Parent then
                    v125.LocalTransparencyModifier = 0
                end
            end

            table.clear(v20)
        end
    end

    if shown then
        model2 = model3
    else
        model2 = nil
    end

    bindableEvent:Fire(model2)
end

local part = nil

local function placeBubbleAnchor(a128, cFrame)
    --[[
      name: placeBubbleAnchor
      line: 443
      upvalues:
        part (ref, index: 1)
    ]]
    local v130 = if a128 then a128.Parent else nil

    if not a128 or not cFrame or not v130 then
        return
    end

    local tribesBubbleAnchor = part

    if not tribesBubbleAnchor or tribesBubbleAnchor.Parent ~= v130 then
        if tribesBubbleAnchor then
            tribesBubbleAnchor:Destroy()
        end

        tribesBubbleAnchor = Instance.new("Part")
        tribesBubbleAnchor.Name = "TribesBubbleAnchor"
        tribesBubbleAnchor.Archivable = false
        tribesBubbleAnchor.Anchored = true
        tribesBubbleAnchor.CanCollide = false
        tribesBubbleAnchor.CanQuery = false
        tribesBubbleAnchor.CanTouch = false
        tribesBubbleAnchor.Massless = true
        tribesBubbleAnchor.CastShadow = false
        tribesBubbleAnchor.Transparency = 1
        tribesBubbleAnchor.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
        tribesBubbleAnchor.CFrame = cFrame
        tribesBubbleAnchor.Parent = v130
        part = tribesBubbleAnchor
    end

    if tribesBubbleAnchor.CFrame ~= cFrame then
        tribesBubbleAnchor.CFrame = cFrame
    end
end

function v5.Render(a132, cFrame: CFrame)
    --[[
      name: Render
      line: 473
      upvalues:
        v15 (ref,  index: 1)
        v16 (ref,  index: 2)
        v28 (ref,  index: 3)
        timestamp (ref,  index: 4)
        build (copy, index: 5)
        destroy (copy, index: 6)
        v26 (ref,  index: 7)
        model (ref,  index: 8)
        localPlayer (copy, index: 9)
        setShown (copy, index: 10)
        proxyShown (ref,  index: 11)
        placeBubbleAnchor (copy, index: 12)
        workspace (copy, index: 13)
        noCollisions (copy, index: 14)
        v21 (ref,  index: 15)
        rebuildLists (copy, index: 16)
        v18 (copy, index: 17)
        cframeList (copy, index: 18)
        v31 (copy, index: 19)
        v19 (copy, index: 20)
        partList (copy, index: 21)
    ]]
    local timestamp2 = os.clock()
    local v135 = if a132 then a132.Parent else nil

    if a132
        and v135
        and v135:IsA("Model")
        and (v135 ~= v15 or a132 ~= v16)
        and (a132 ~= v28 or 5 < os.clock() - timestamp)
    then
        local success, result = pcall(build, v135, a132)
        if not success then
            local timestamp3 = os.clock()
            v28 = a132
            timestamp = timestamp3
            destroy()
            warn("[BodyProxy] build failed, the real body is shown: " .. tostring(result))
        end
    elseif not a132 and v15 then
        destroy()
    end

    local v139 = v26 and cFrame ~= nil and model ~= nil and localPlayer:GetAttribute("ReplayPlaying") ~= true
    setShown(v139)

    if proxyShown and cFrame and v16 then
        placeBubbleAnchor(a132, cFrame)
        local model2 = model

        if model2.Parent ~= workspace.CurrentCamera then
            model2.Parent = workspace.CurrentCamera
            noCollisions(model2)
        end

        if v21 then
            rebuildLists()
        end

        local v141 = cFrame * v16.CFrame:Inverse()

        for v142, v143 in v18 do
            local real = v143.real
            cframeList[v142] = v141 * real.CFrame
            local copy = v143.copy

            if copy.CanCollide then
                copy.CanCollide = false
                copy.CanQuery = false
                local v146 = v31
                v146.collisionResets += 1
            end

            local transparency = real.Transparency

            if transparency ~= v143.t then
                v143.t = transparency
                v143.copy.Transparency = transparency
                local v148 = v31
                v148.props += 1
            end

            local color = real.Color

            if color ~= v143.color then
                v143.color = color
                v143.copy.Color = color
                local v150 = v31
                v150.props += 1
            end

            local material = real.Material

            if material ~= v143.mat then
                v143.mat = material
                v143.copy.Material = material
                local v152 = v31
                v152.props += 1
            end
        end

        for _, v154 in v19 do
            local transparency = v154.real.Transparency

            if transparency ~= v154.t then
                v154.t = transparency
                v154.copy.Transparency = transparency
            end
        end

        if 0 < #partList
            and not pcall(
                function()
                    --[[
                      line: 541
                      upvalues:
                        workspace (copy, index: 1)
                        partList (copy, index: 2)
                        cframeList (copy, index: 3)
                    ]]
                    workspace:BulkMoveTo(partList, cframeList, Enum.BulkMoveMode.FireCFrameChanged)
                end
            )
        then
            v21 = true
        end

        v31.frames += 1
        local maxMs = (os.clock() - timestamp2) * 1000
        v31.totalMs += maxMs

        if v31.maxMs < maxMs then
            v31.maxMs = maxMs
        end

        return
    end

    local v157 = if a132 then a132.CFrame else nil
    placeBubbleAnchor(a132, v157)
end

function v5.EnforceHidden()
    --[[
      name: EnforceHidden
      line: 559
      upvalues:
        proxyShown (ref,  index: 1)
        v20 (copy, index: 2)
        v31 (copy, index: 3)
    ]]
    if not proxyShown then
        return
    end

    for v158 in v20 do
        if v158.LocalTransparencyModifier ~= 1 then
            if v158.Parent then
                v158.LocalTransparencyModifier = 1
                v31.hideWrites += 1
            else
                v20[v158] = nil
            end
        end
    end
end

function v5.SetEnabled(enabled)
    --[[
      name: SetEnabled
      line: 576
      upvalues:
        v26 (ref,  index: 1)
        setShown (copy, index: 2)
    ]]
    v26 = enabled == true

    if not v26 then
        setShown(false)
    end
end

function v5.IsShown()
    --[[
      name: IsShown
      line: 583
      upvalues:
        proxyShown (ref, index: 1)
    ]]
    return proxyShown
end

function v5.Model()
    --[[
      name: Model
      line: 588
      upvalues:
        proxyShown (ref, index: 1)
        model (ref, index: 2)
    ]]
    if proxyShown then
        return model
    end

    return nil
end

function v5.Drawn(key)
    --[[
      name: Drawn
      line: 594
      upvalues:
        proxyShown (ref,  index: 1)
        v17 (copy, index: 2)
    ]]
    if key and proxyShown then
        return v17[key] or key
    end

    return key
end

function v5.Stats()
    --[[
      name: Stats
      line: 601
      upvalues:
        proxyShown (ref,  index: 1)
        v31 (copy, index: 2)
    ]]
    local v161 = {proxyShown = proxyShown, proxyBuilds = v31.builds, proxyParts = v31.parts, proxyFrames = v31.frames, proxyJointsStripped = v31.jointsStripped, proxyHideWrites = v31.hideWrites, proxyPropCopies = v31.props, proxyMaxMs = math.floor(v31.maxMs * 1000) / 1000, proxyAvgMs = if not (0 < v31.frames) then 0 else math.floor((v31.totalMs / v31.frames) * 10000) / 10000}
    v161.proxyCollisionResets = v31.collisionResets
    return v161
end

if isStudio then
    function v5.DebugMap()
        --[[
          name: DebugMap
          line: 618
          upvalues:
            v17 (copy, index: 1)
        ]]
        local v162 = {parts = 0, decals = 0, attachments = 0, other = 0}

        for v163 in v17 do
            if v163:IsA("BasePart") then
                v162.parts += 1
            elseif v163:IsA("Decal") then
                v162.decals += 1
            elseif v163:IsA("Attachment") then
                v162.attachments += 1
            else
                v162.other += 1
            end
        end

        return v162
    end
end

if runService:IsClient() then
    task.spawn(
        function()
            --[[
              line: 637
            ]]
            local bubbleChatConfiguration = game:GetService("TextChatService"):WaitForChild("BubbleChatConfiguration", 30)

            if bubbleChatConfiguration and bubbleChatConfiguration:IsA("BubbleChatConfiguration") then
                bubbleChatConfiguration.AdorneeName = "TribesBubbleAnchor"
            end
        end
    )
end

return v5