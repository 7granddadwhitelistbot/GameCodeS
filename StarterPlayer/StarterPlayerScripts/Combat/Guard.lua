local Players_upv_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local TweenService_upv_1 = game:GetService("TweenService")
local Util_upv_1 = require(script.Parent.Util)
local Effects_upv_1 = require(script.Parent.Effects)
local Quality_upv_1 = require(script.Parent.Quality)
local tbl_upv_1 = {}
local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
tbl_upv_1.POSE = {LeftShoulder = Vector3.new(102, -119, -8), RightShoulder = Vector3.new(102, 64, -24), LeftWrist = Vector3.new(0, 0, 0), RightWrist = Vector3.new(-23, 0, 117), RightElbow = Vector3.new(11, 0, 0), LeftElbow = Vector3.new(0, 0, 0)}
local u1 = Color3.fromRGB(80, 170, 240)
local tbl_upv_2 = {}
local tbl_upv_3 = {}
local function rebuildPose()
    --[[
      name: rebuildPose
      line: 52
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    for key_1, value_1 in tbl_upv_1.POSE do
        tbl_upv_3[key_1] = CFrame.Angles(math.rad(value_1.X), math.rad(value_1.Y), math.rad(value_1.Z))
    end
end
rebuildPose()
local function fxFolder()
    --[[
      name: fxFolder
      line: 59
    ]]
    local v1 = workspace:FindFirstChild("FX") or workspace
    return v1
end
local function makeShield()
    --[[
      name: makeShield
      line: 76
      upvalues:
        u1 (copy, index: 1)
    ]]
    local v2 = Instance.new("Part")
    v2.Name = "GuardShimmer"
    v2.Anchored = true
    v2.CanCollide = false
    v2.CanQuery = false
    v2.CanTouch = false
    v2.CastShadow = false
    v2.Size = Vector3.new(1, 1, 1)
    v2.Material = Enum.Material.ForceField
    v2.Color = u1
    v2.Transparency = 1
    local v3 = Instance.new("SpecialMesh")
    v3.MeshType = Enum.MeshType.Sphere
    v3.Scale = Vector3.new(3.799999952316284, 4, 1.399999976158142)
    v3.Parent = v2
    v2.Parent = workspace:FindFirstChild("FX") or workspace
    return v2
end
local function findMotors(a1)
    --[[
      name: findMotors
      line: 65
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local tbl_4 = {}
    for key_2 in tbl_upv_1.POSE do
        local v5 = a1:FindFirstChild(key_2, true)
        if v5 and (v5:IsA("Motor6D") or v5:IsA("AnimationConstraint")) then
            tbl_4[key_2] = v5
        end
    end
    return tbl_4
end
local function ensure(a1)
    --[[
      name: ensure
      line: 101
      upvalues:
        tbl_upv_2 (copy, index: 1)
        findMotors (copy, index: 2)
    ]]
    local v6 = tbl_upv_2[a1]
    if not (v6) then
        v6 = {lastImpact = 0, target = 0, alpha = 0, char = a1, motors = findMotors(a1)}
        tbl_upv_2[a1] = v6
    end
    return v6
end
local function cleanup(a1)
    --[[
      name: cleanup
      line: 118
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    if a1.shield then
        a1.shield:Destroy()
        a1.shield = nil
    end
    if a1.highlight then
        a1.highlight:Destroy()
        a1.highlight = nil
    end
    tbl_upv_2[a1.char] = nil
end
function tbl_upv_1.Set(a1, a2)
    --[[
      name: Set
      line: 130
      upvalues:
        tbl_upv_2 (copy, index: 1)
        findMotors (copy, index: 2)
    ]]
    if not a1 then
        return
    end
    local v7 = tbl_upv_2[a1]
    if not (v7) then
        v7 = {lastImpact = 0, target = 0, alpha = 0, char = a1, motors = findMotors(a1)}
        tbl_upv_2[a1] = v7
    end
    v7.target = (a2 and 1) or 0
    if not a2 then
        return
    end
    v7.motors = findMotors(a1)
end
function tbl_upv_1.SetLocal(a1)
    --[[
      name: SetLocal
      line: 142
      upvalues:
        tbl_upv_1 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    tbl_upv_1.Set(LocalPlayer_upv_1.Character, a1)
end
function tbl_upv_1.IsGuarding(a1)
    --[[
      name: IsGuarding
      line: 146
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v8 = a1 and (tbl_upv_2[a1])
    local v9 = false
    if v8 ~= nil then
        v9 = v8.target > 0
    end
    return v9
end
local function toolOf(a1)
    --[[
      name: toolOf
      line: 97
    ]]
    return a1:FindFirstChildOfClass("Tool")
end
function tbl_upv_1.Impact(a1, a2)
    --[[
      name: Impact
      line: 153
      upvalues:
        tbl_upv_2 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
        toolOf (copy, index: 3)
        Effects_upv_1 (copy, index: 4)
        TweenService_upv_1 (copy, index: 5)
    ]]
    if not a1 then
        return
    end
    local v10 = tbl_upv_2[a1]
    local v11 = Util_upv_1.Drawn(toolOf(a1))
    local v12 = v11
    local _ = v12 and (v11:FindFirstChild("Tip", true))
    local v13 = v11 and (v11:FindFirstChild("Handle"))
    if v12 and v12:IsA("Attachment") and v13 and v13:IsA("BasePart") then
        v11 = v13.Position:Lerp(v12.WorldPosition, 0.6)
    else
        local v14 = Util_upv_1.Drawn(a1:FindFirstChild("HumanoidRootPart"))
        v11 = v14 and (v14.CFrame * CFrame.new(0, 1, -1.6)).Position
    end
    if v11 then
        Effects_upv_1.Burst("Block_Spark", CFrame.new(v11), 1.4)
        Effects_upv_1.Burst("Impact_Sparks", CFrame.new(v11), 1)
        Util_upv_1.Sound("Block_Hit", v11)
    end
    local v16, v17 = nil, nil
    if v10 then
        v10.lastImpact = os.clock()
        v16 = v10.shield
        if v16 then
            v17 = v16:FindFirstChildOfClass("SpecialMesh")
            if v17 then
                v17.Scale = Vector3.new(4.800000190734863, 5, 1.7999999523162842)
                local tbl_5 = {Scale = Vector3.new(3.799999952316284, 4, 1.399999976158142)}
                TweenService_upv_1:Create(v17, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_5):Play()
            end
        end
        local highlight_1 = v10.highlight
        if highlight_1 then
            highlight_1.OutlineTransparency = 0
        end
    end
    if not a2 then
        return
    end
    Util_upv_1.Shake(0.35, 0.12)
    Util_upv_1.Recoil(1.6, (math.random() - 0.5) * 1.5)
end
local function placeShields()
    --[[
      name: placeShields
      line: 275
      upvalues:
        tbl_upv_2 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    for key_3, value_2 in tbl_upv_2 do
        local shield_1 = value_2.shield
        if not (shield_1) then
            continue
        end
        local v18 = Util_upv_1.Drawn(key_3:FindFirstChild("HumanoidRootPart"))
        if not (v18) then
            continue
        end
        if v18:IsA("BasePart") then
            shield_1.CFrame = v18.CFrame * CFrame.new(0, 1.1, -1.6)
        end
    end
end
local CollectionService_upv_1 = game:GetService("CollectionService")
local tbl_upv_6 = {}
local function watchModel(a1)
    --[[
      name: watchModel
      line: 291
      upvalues:
        tbl_upv_6 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    if (tbl_upv_6[a1]) then
        return
    end
    if a1 ~= LocalPlayer_upv_1.Character then
        tbl_upv_6[a1] = true
        local function apply_1()
            --[[
              name: apply
              line: 296
              upvalues:
                tbl_upv_1 (copy, index: 1)
                a1 (copy, index: 2)
            ]]
            local Set_1 = tbl_upv_1.Set
            local v19 = a1:GetAttribute("Blocking") == true
            Set_1(a1, v19)
        end
        a1:GetAttributeChangedSignal("Blocking"):Connect(apply_1)
        a1.Destroying:Once(
            function()
                --[[
                  line: 300
                  upvalues:
                    tbl_upv_6 (copy, index: 1)
                    a1 (copy, index: 2)
                ]]
                tbl_upv_6[a1] = nil
            end
        )
        if a1:GetAttribute("Blocking") == true then
            local Set_2 = tbl_upv_1.Set
            local v20 = a1:GetAttribute("Blocking") == true
            Set_2(a1, v20)
        end
    end
end
local function reconcile()
    --[[
      name: reconcile
      line: 320
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
        Players_upv_1 (copy, index: 4)
        CollectionService_upv_1 (copy, index: 5)
    ]]
    local function check_1(a1)
        --[[
          name: check
          line: 321
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            tbl_upv_2 (copy, index: 2)
            tbl_upv_1 (copy, index: 3)
        ]]
        if not a1 or a1 == LocalPlayer_upv_1.Character or not a1:IsDescendantOf(workspace) or a1:GetAttribute("Blocking") ~= true or (tbl_upv_2[a1]) then
            return
        end
        tbl_upv_1.Set(a1, true)
    end
    for _, value_3 in Players_upv_1:GetPlayers() do
        local Character_1 = value_3.Character
        if not (Character_1) or Character_1 == LocalPlayer_upv_1.Character or not (Character_1:IsDescendantOf(workspace)) or Character_1:GetAttribute("Blocking") ~= true then
            continue
        end
        if not (tbl_upv_2[Character_1]) then
            tbl_upv_1.Set(Character_1, true)
        end
    end
    for _, value_4 in {"Combatant", "Bot"} do
        for v1, value_5 in CollectionService_upv_1:GetTagged(value_4) do
            if not (value_5:IsA("Model")) or not (value_5) or value_5 == LocalPlayer_upv_1.Character or not (value_5:IsDescendantOf(workspace)) or value_5:GetAttribute("Blocking") ~= true then
                continue
            end
            if not (tbl_upv_2[value_5]) then
                tbl_upv_1.Set(value_5, true)
            end
        end
    end
end
local u2 = false
local function watchPlayer(a1)
    --[[
      name: watchPlayer
      line: 308
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        watchModel (copy, index: 2)
    ]]
    if a1 == LocalPlayer_upv_1 then
        return
    end
    a1.CharacterAdded:Connect(watchModel)
    if a1.Character then
        watchModel(a1.Character)
    end
end
local function step(a1)
    --[[
      name: step
      line: 196
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        Util_upv_1 (copy, index: 4)
        makeShield (copy, index: 5)
        Quality_upv_1 (copy, index: 6)
        u1 (copy, index: 7)
    ]]
    local v21, v22 = nil, nil
    local value_6 = nil
    for key_4, value_6 in tbl_upv_2 do
        if key_4:IsDescendantOf(workspace) then
            local v23 = ((value_6.alpha < value_6.target) and (a1 / 0.08)) or (a1 / 0.12)
            if value_6.alpha < value_6.target then
                value_6.alpha = math.min(value_6.target, value_6.alpha + v23)
            else
                value_6.alpha = math.max(value_6.target, value_6.alpha - v23)
            end
            if value_6.alpha <= 0 and value_6.target <= 0 then
                if value_6.shield then
                    value_6.shield:Destroy()
                    value_6.shield = nil
                end
                if value_6.highlight then
                    value_6.highlight:Destroy()
                    value_6.highlight = nil
                end
                tbl_upv_2[value_6.char] = nil
            else
                local v24 = value_6.alpha * value_6.alpha * (3 - (value_6.alpha * 2))
                for key_5, value_7 in value_6.motors do
                    local v25 = tbl_upv_3[key_5]
                    if not (v25) then
                        continue
                    end
                    if value_7.Parent then
                        value_7.Transform = value_7.Transform:Lerp(v25, v24)
                    end
                end
                if key_4 ~= LocalPlayer_upv_1.Character or not (Util_upv_1.InFirstPerson()) then
                    v21 = key_4:FindFirstChild("HumanoidRootPart")
                    if v21 then
                        if not (value_6.shield) then
                            value_6.shield = makeShield()
                        end
                        value_6.shield.Transparency = 1 - (v24 * ((math.clamp(1 - ((os.clock() - value_6.lastImpact) / 0.25), 0, 1) * 0.2) + 0.8))
                    else
                        v23 = v24
                    end
                    if Quality_upv_1.highlights then
                        v21 = key_4:FindFirstChildOfClass("Tool")
                    else
                        v21 = nil
                    end
                    if v21 then
                        v22 = Util_upv_1.Drawn(v21)
                    else
                        v22 = nil
                    end
                    if not (v22) then
                        continue
                    end
                    v21 = value_6.highlight
                    if not (v21) or v21.Parent ~= v22 then
                        if v21 then
                            v21:Destroy()
                        end
                        local v26 = Instance.new("Highlight")
                        v26.Name = "GuardHighlight"
                        v26.Adornee = v22
                        v26.DepthMode = Enum.HighlightDepthMode.Occluded
                        v26.FillColor = u1
                        v26.OutlineColor = Color3.fromRGB(90, 185, 250)
                        v26.Parent = v22
                        value_6.highlight = v26
                        v21 = v26
                        local v27 = math.clamp(1 - ((os.clock() - value_6.lastImpact) / 0.25), 0, 1)
                        v21.FillTransparency = 1
                        v21.OutlineTransparency = 1 - (v23 * ((v27 * 0.45) + 0.55))
                    end
                    local v27 = math.clamp(1 - ((os.clock() - value_6.lastImpact) / 0.25), 0, 1)
                    v21.FillTransparency = 1
                    v21.OutlineTransparency = 1 - (v23 * ((v27 * 0.45) + 0.55))
                    continue
                end
                if value_6.shield then
                    value_6.shield:Destroy()
                    value_6.shield = nil
                end
                if value_6.highlight then
                    value_6.highlight:Destroy()
                    value_6.highlight = nil
                end
            end
        else
            if value_6.shield then
                value_6.shield:Destroy()
                value_6.shield = nil
            end
            if value_6.highlight then
                value_6.highlight:Destroy()
                value_6.highlight = nil
            end
            tbl_upv_2[value_6.char] = nil
        end
    end
end
function tbl_upv_1.Init()
    --[[
      name: Init
      line: 339
      upvalues:
        u2 (ref,  index: 1)
        RunService_upv_1 (copy, index: 2)
        step (copy, index: 3)
        placeShields (copy, index: 4)
        reconcile (copy, index: 5)
        Players_upv_1 (copy, index: 6)
        LocalPlayer_upv_1 (copy, index: 7)
        watchModel (copy, index: 8)
        watchPlayer (copy, index: 9)
        CollectionService_upv_1 (copy, index: 10)
    ]]
    if u2 then
        return
    end
    u2 = true
    RunService_upv_1.PreSimulation:Connect(step)
    RunService_upv_1:BindToRenderStep("TribesGuardShields", Enum.RenderPriority.Camera.Value - 1, placeShields)
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
    for _, value_8 in Players_upv_1:GetPlayers() do
        if value_8 == LocalPlayer_upv_1 then
            continue
        end
        value_8.CharacterAdded:Connect(watchModel)
        if value_8.Character then
            watchModel(value_8.Character)
        end
    end
    Players_upv_1.PlayerAdded:Connect(watchPlayer)
    for _, value_9 in {"Combatant", "Bot"} do
        CollectionService_upv_1:GetInstanceAddedSignal(value_9):Connect(
            function(a1)
                --[[
                  line: 357
                  upvalues:
                    watchModel (copy, index: 1)
                ]]
                if not a1:IsA("Model") then
                    return
                end
                watchModel(a1)
            end
        )
        for v1, value_10 in CollectionService_upv_1:GetTagged(value_9) do
            if value_10:IsA("Model") then
                watchModel(value_10)
            end
        end
    end
end
function tbl_upv_1.RebuildPose()
    --[[
      name: RebuildPose
      line: 371
      upvalues:
        rebuildPose (copy, index: 1)
    ]]
    rebuildPose()
end
return tbl_upv_1