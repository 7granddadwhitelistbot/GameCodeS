local players = game:GetService("Players")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local Util = require(script.Parent.Util)
local Effects = require(script.Parent.Effects)
local Quality = require(script.Parent.Quality)
local v7 = {}
local localPlayer = players.LocalPlayer
v7.POSE = {RightShoulder = Vector3.new(102, 64, -24), RightElbow = Vector3.new(11, 0, 0), RightWrist = Vector3.new(-23, 0, 117), LeftShoulder = Vector3.new(102, -119, -8), LeftElbow = Vector3.new(0, 0, 0), LeftWrist = Vector3.new(0, 0, 0)}
local color3 = Color3.fromRGB(80, 170, 240)
local v10 = {}
local targetValues = {}

local function rebuildPose()
    --[[
      name: rebuildPose
      line: 52
      upvalues:
        v7 (copy, index: 1)
        targetValues (copy, index: 2)
    ]]
    for v13, v14 in v7.POSE do
        targetValues[v13] = CFrame.Angles(math.rad(v14.X), math.rad(v14.Y), (math.rad(v14.Z)))
    end
end

rebuildPose()

local function fxFolder()
    --[[
      name: fxFolder
      line: 59
    ]]
    return workspace:FindFirstChild("FX") or workspace
end

local function findMotors(char)
    --[[
      name: findMotors
      line: 65
      upvalues:
        v7 (copy, index: 1)
    ]]
    local v18 = {}

    for v19 in v7.POSE do
        if const v20 = char:FindFirstChild(v19, true) then
            if v20:IsA("Motor6D") or v20:IsA("AnimationConstraint") then
                v18[v19] = v20
            end
        end
    end

    return v18
end

local function makeShield()
    --[[
      name: makeShield
      line: 76
      upvalues:
        color3 (copy, index: 1)
    ]]
    local guardShimmer = Instance.new("Part")
    guardShimmer.Name = "GuardShimmer"
    guardShimmer.Anchored = true
    guardShimmer.CanCollide = false
    guardShimmer.CanQuery = false
    guardShimmer.CanTouch = false
    guardShimmer.CastShadow = false
    guardShimmer.Size = Vector3.new(1, 1, 1)
    guardShimmer.Material = Enum.Material.ForceField
    guardShimmer.Color = color3
    guardShimmer.Transparency = 1

    local specialMesh = Instance.new("SpecialMesh")
    specialMesh.MeshType = Enum.MeshType.Sphere
    specialMesh.Scale = Vector3.new(3.799999952316284, 4, 1.399999976158142)
    specialMesh.Parent = guardShimmer
    local instance = workspace:FindFirstChild("FX") or workspace
    guardShimmer.Parent = instance

    return guardShimmer
end

local function toolOf(key)
    --[[
      name: toolOf
      line: 97
    ]]
    return key:FindFirstChildOfClass("Tool")
end

local function ensure(char)
    --[[
      name: ensure
      line: 101
      upvalues:
        v10 (copy, index: 1)
        findMotors (copy, index: 2)
    ]]
    local v29 = v10[char]
    if not v29 then
        v29 = {target = 0, alpha = 0, shield = nil, highlight = nil, lastImpact = 0, char = char, motors = findMotors(char)}
        v10[char] = v29
    end

    return v29
end

local function cleanup(a31)
    --[[
      name: cleanup
      line: 118
      upvalues:
        v10 (copy, index: 1)
    ]]
    if a31.shield then
        a31.shield:Destroy()
        a31.shield = nil
    end

    if a31.highlight then
        a31.highlight:Destroy()
        a31.highlight = nil
    end

    v10[a31.char] = nil
end

function v7.Set(char, a33)
    --[[
      name: Set
      line: 130
      upvalues:
        v10 (copy, index: 1)
        findMotors (copy, index: 2)
    ]]
    if not char then
        return
    end

    local v34 = v10[char]
    if not v34 then
        v34 = {target = 0, alpha = 0, shield = nil, highlight = nil, lastImpact = 0, char = char, motors = findMotors(char)}
        v10[char] = v34
    end

    v34.target = a33 and 1 or 0

    if a33 then
        v34.motors = findMotors(char)
    end
end

function v7.SetLocal(localValue)
    --[[
      name: SetLocal
      line: 142
      upvalues:
        v7 (copy, index: 1)
        localPlayer (copy, index: 2)
    ]]
    v7.Set(localPlayer.Character, localValue)
end

function v7.IsGuarding(key)
    --[[
      name: IsGuarding
      line: 146
      upvalues:
        v10 (copy, index: 1)
    ]]
    local v37 = key and v10[key]
    return v37 ~= nil and 0 < v37.target
end

function v7.Impact(key, a39)
    --[[
      name: Impact
      line: 153
      upvalues:
        v10 (copy, index: 1)
        Util (copy, index: 2)
        toolOf (copy, index: 3)
        Effects (copy, index: 4)
        tweenService (copy, index: 5)
    ]]
    local v40

    if not key then
        return
    end

    local v41 = v10[key]
    local v42 = Util.Drawn(toolOf(key))
    local tip = v42 and v42:FindFirstChild("Tip", true)
    local handle = v42 and v42:FindFirstChild("Handle")

    if tip and tip:IsA("Attachment") and handle and handle:IsA("BasePart") then
        v40 = handle.Position:Lerp(tip.WorldPosition, 0.6)
    else
        local v45 = Util.Drawn(key:FindFirstChild("HumanoidRootPart"))
        v40 = v45 and (v45.CFrame * CFrame.new(0, 1, -1.6)).Position
    end

    if v40 then
        Effects.Burst("Block_Spark", CFrame.new(v40), 1.4)
        Effects.Burst("Impact_Sparks", CFrame.new(v40), 1)
        Util.Sound("Block_Hit", v40)
    end

    if v41 then
        v41.lastImpact = os.clock()

        if const shield = v41.shield then
            if const specialMesh = shield:FindFirstChildOfClass("SpecialMesh") then
                specialMesh.Scale = Vector3.new(4.800000190734863, 5, 1.7999999523162842)
                local propertyTable = {Scale = Vector3.new(3.799999952316284, 4, 1.399999976158142)}
                tweenService:Create(specialMesh, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable):Play()
            end
        end

        if const highlight = v41.highlight then
            highlight.OutlineTransparency = 0
        end
    end

    if a39 then
        Util.Shake(0.35, 0.12)
        Util.Recoil(1.6, (math.random() - 0.5) * 1.5)
    end
end

local function step(deltaTimeSim: number)
    --[[
      name: step
      line: 196
      upvalues:
        v10 (copy, index: 1)
        targetValues (copy, index: 2)
        localPlayer (copy, index: 3)
        Util (copy, index: 4)
        makeShield (copy, index: 5)
        Quality (copy, index: 6)
        color3 (copy, index: 7)
    ]]
    for v52, v53 in v10 do
        if v52:IsDescendantOf(workspace) then
            local target = v53.target
            local v55 = if v53.alpha < target then deltaTimeSim / 0.08 else deltaTimeSim / 0.12
            local target2 = v53.target

            if v53.alpha < target2 then
                v53.alpha = math.min(v53.target, v53.alpha + v55)
            else
                v53.alpha = math.max(v53.target, v53.alpha - v55)
            end

            if not (v53.alpha <= 0) or not (v53.target <= 0) then
                local alpha = v53.alpha * v53.alpha * (3 - (v53.alpha * 2))

                for v58, motor in v53.motors do
                    local targetValue = targetValues[v58]

                    if targetValue and motor.Parent then
                        motor.Transform = motor.Transform:Lerp(targetValue, alpha)
                    end
                end

                if v52 == localPlayer.Character and Util.InFirstPerson() then
                    if v53.shield then
                        v53.shield:Destroy()
                        v53.shield = nil
                    end

                    if v53.highlight then
                        v53.highlight:Destroy()
                        v53.highlight = nil
                    end
                else
                    if v52:FindFirstChild("HumanoidRootPart") then
                        if not v53.shield then
                            v53.shield = makeShield()
                        end

                        v53.shield.Transparency = 1 - (alpha * ((math.clamp(1 - ((os.clock() - v53.lastImpact) / 0.25), 0, 1) * 0.2) + 0.8))
                    end

                    local v62 = if const v61 = if Quality.highlights then v52:FindFirstChildOfClass("Tool") else nil then Util.Drawn(v61) else nil

                    if v62 then
                        local v63 = false
                        local highlight = v53.highlight

                        if highlight then
                            if highlight.Parent ~= v62 then
                                v63 = true
                            end
                        else
                            v63 = true
                        end

                        if v63 then
                            if highlight then
                                highlight:Destroy()
                            end

                            highlight = Instance.new("Highlight")
                            highlight.Name = "GuardHighlight"
                            highlight.Adornee = v62
                            highlight.DepthMode = Enum.HighlightDepthMode.Occluded
                            highlight.FillColor = color3
                            highlight.OutlineColor = Color3.fromRGB(90, 185, 250)
                            highlight.Parent = v62
                            v53.highlight = highlight
                        end

                        local highlight2 = highlight
                        local clampedValue = math.clamp(1 - ((os.clock() - v53.lastImpact) / 0.25), 0, 1)
                        highlight2.FillTransparency = 1
                        highlight2.OutlineTransparency = 1 - (alpha * ((clampedValue * 0.45) + 0.55))
                    end
                end
            else
                if v53.shield then
                    v53.shield:Destroy()
                    v53.shield = nil
                end

                if v53.highlight then
                    v53.highlight:Destroy()
                    v53.highlight = nil
                end

                v10[v53.char] = nil
            end
        else
            if v53.shield then
                v53.shield:Destroy()
                v53.shield = nil
            end

            if v53.highlight then
                v53.highlight:Destroy()
                v53.highlight = nil
            end

            v10[v53.char] = nil
        end
    end
end

local function placeShields()
    --[[
      name: placeShields
      line: 275
      upvalues:
        v10 (copy, index: 1)
        Util (copy, index: 2)
    ]]
    for v68, v69 in v10 do
        if const shield = v69.shield then
            local v71 = Util.Drawn(v68:FindFirstChild("HumanoidRootPart"))

            if v71 and v71:IsA("BasePart") then
                shield.CFrame = v71.CFrame * CFrame.new(0, 1.1, -1.6)
            end
        end
    end
end

local collectionService = game:GetService("CollectionService")
local v73 = {}

local function watchModel(instance: Instance?)
    --[[
      name: watchModel
      line: 291
      upvalues:
        v73 (copy, index: 1)
        localPlayer (copy, index: 2)
        v7 (copy, index: 3)
    ]]
    if not v73[instance] and instance ~= localPlayer.Character then
        v73[instance] = true
        instance:GetAttributeChangedSignal("Blocking"):Connect(
            function()
                --[[
                  name: apply
                  line: 296
                  upvalues:
                    v7 (copy, index: 1)
                    instance (copy, index: 2)
                ]]
                v7.Set(instance, instance:GetAttribute("Blocking") == true)
            end
        )
        instance.Destroying:Once(
            function()
                --[[
                  line: 300
                  upvalues:
                    v73 (copy, index: 1)
                    instance (copy, index: 2)
                ]]
                v73[instance] = nil
            end
        )

        if instance:GetAttribute("Blocking") == true then
            v7.Set(instance, instance:GetAttribute("Blocking") == true)
        end
    end
end

local function watchPlayer(player: Player)
    --[[
      name: watchPlayer
      line: 308
      upvalues:
        localPlayer (copy, index: 1)
        watchModel (copy, index: 2)
    ]]
    if player == localPlayer then
        return
    end

    player.CharacterAdded:Connect(watchModel)

    if player.Character then
        watchModel(player.Character)
    end
end

local function reconcile()
    --[[
      name: reconcile
      line: 320
      upvalues:
        localPlayer (copy, index: 1)
        v10 (copy, index: 2)
        v7 (copy, index: 3)
        players (copy, index: 4)
        collectionService (copy, index: 5)
    ]]
    local function check(key)
        --[[
          name: check
          line: 321
          upvalues:
            localPlayer (copy, index: 1)
            v10 (copy, index: 2)
            v7 (copy, index: 3)
        ]]
        if key
            and key ~= localPlayer.Character
            and key:IsDescendantOf(workspace)
            and key:GetAttribute("Blocking") == true
            and not v10[key]
        then
            v7.Set(key, true)
        end
    end

    for _, player in players:GetPlayers() do
        if const character = player.Character then
            if character == localPlayer.Character then
                continue
            end
            if not character:IsDescendantOf(workspace) then
                continue
            end

            if character:GetAttribute("Blocking") == true and not v10[character] then
                v7.Set(character, true)
            end
        end
    end

    for _, tag in {"Combatant", "Bot"} do
        for _, instance in collectionService:GetTagged(tag) do
            if instance:IsA("Model") then
                if not instance then
                    continue
                end
                if instance == localPlayer.Character then
                    continue
                end
                if not instance:IsDescendantOf(workspace) then
                    continue
                end

                if instance:GetAttribute("Blocking") == true and not v10[instance] then
                    v7.Set(instance, true)
                end
            end
        end
    end
end

local hasRun = false

function v7.Init()
    --[[
      name: Init
      line: 339
      upvalues:
        hasRun (ref,  index: 1)
        runService (copy, index: 2)
        step (copy, index: 3)
        placeShields (copy, index: 4)
        reconcile (copy, index: 5)
        players (copy, index: 6)
        localPlayer (copy, index: 7)
        watchModel (copy, index: 8)
        watchPlayer (copy, index: 9)
        collectionService (copy, index: 10)
    ]]
    if hasRun then
        return
    end

    hasRun = true
    runService.PreSimulation:Connect(step)
    runService:BindToRenderStep("TribesGuardShields", Enum.RenderPriority.Camera.Value - 1, placeShields)

    task.spawn(
        function()
            --[[
              line: 346
              upvalues:
                reconcile (copy, index: 1)
            ]]
            while true do
                task.wait(1)
                pcall(reconcile)
            end
        end
    )

    for _, player in players:GetPlayers() do
        if player ~= localPlayer then
            player.CharacterAdded:Connect(watchModel)

            if not player.Character then
                continue
            end

            watchModel(player.Character)
        end
    end

    players.PlayerAdded:Connect(watchPlayer)

    for _, tag in {"Combatant", "Bot"} do
        collectionService:GetInstanceAddedSignal(tag):Connect(
            function(instance: Instance)
                --[[
                  line: 357
                  upvalues:
                    watchModel (copy, index: 1)
                ]]
                if instance:IsA("Model") then
                    watchModel(instance)
                end
            end
        )

        for _, instance in collectionService:GetTagged(tag) do
            if instance:IsA("Model") then
                watchModel(instance)
            end
        end
    end
end

function v7.RebuildPose()
    --[[
      name: RebuildPose
      line: 371
      upvalues:
        rebuildPose (copy, index: 1)
    ]]
    rebuildPose()
end

return v7