local Debris_upv_1 = game:GetService("Debris")
local Players_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local TweenService_upv_1 = game:GetService("TweenService")
local Util_upv_1 = require(script.Parent.Util)
local Effects_upv_1 = require(script.Parent.Effects)
local Quality_upv_1 = require(script.Parent.Quality)
local tbl_upv_1 = {}
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local u1 = Util_upv_1.Assets:WaitForChild("VFX", 10)
local u2 = Color3.fromRGB(196, 70, 64)
local u3 = Color3.fromRGB(70, 132, 196)
local u4 = Color3.fromRGB(232, 172, 40)
local u5 = Color3.fromRGB(44, 34, 26)
local u6 = Color3.fromRGB(255, 214, 140)
local function fx()
    --[[
      name: fx
      line: 35
    ]]
    local v1 = workspace:FindFirstChild("FX") or workspace
    return v1
end
local function anchored(a1, a2, a3, a4, a5)
    --[[
      name: anchored
      line: 39
    ]]
    local v2 = Instance.new("Part")
    v2.Name = a1
    v2.Anchored = true
    v2.CanCollide = false
    v2.CanQuery = false
    v2.CanTouch = false
    v2.CastShadow = false
    v2.Size = a2
    v2.Color = a3
    v2.Material = a4 or (Enum.Material.SmoothPlastic)
    v2.Transparency = a5 or 0
    return v2
end
local function modelOf(a1)
    --[[
      name: modelOf
      line: 54
    ]]
    if typeof(a1) == "Instance" and a1:IsA("Model") then
        return a1
    end
    return nil
end
local function camDistance(a1)
    --[[
      name: camDistance
      line: 71
    ]]
    local CurrentCamera_1 = workspace.CurrentCamera
    if CurrentCamera_1 then
        return (CurrentCamera_1.CFrame.Position - a1).Magnitude
    end
    return 0
end
local tbl_upv_2 = {}
local u7 = nil
local u8 = 0
local function beeTemplate()
    --[[
      name: beeTemplate
      line: 105
      upvalues:
        u1 (copy, index: 1)
    ]]
    local v3
    if u1 then
        v3 = u1:FindFirstChild("Bee")
    else
        v3 = u1
    end
    return v3
end
local function endSwarm(a1, a2)
    --[[
      name: endSwarm
      line: 148
      upvalues:
        tbl_upv_2 (copy, index: 1)
        TweenService_upv_1 (copy, index: 2)
        Debris_upv_1 (copy, index: 3)
    ]]
    if tbl_upv_2[a1.id] ~= a1 then
        return
    end
    tbl_upv_2[a1.id] = nil
    a1.ending = true
    if a1.stopLoop then
        a1.stopLoop(a2)
        a1.stopLoop = nil
    end
    for _, value_1 in a1.bees do
        local v4 = value_1.part.Position - a1.pos
        v4 = ((not (v4.Magnitude > 0.01)) and Vector3.new(0, 1, 0)) or (v4.Unit)
        for v6, value_2 in value_1.parts do
            local v5 = TweenInfo.new(a2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            local tbl_3 = {Transparency = 1}
            tbl_3.CFrame = (value_2.CFrame + (v4 * 2.5)) + Vector3.new(0, 1, 0)
            TweenService_upv_1:Create(value_2, v5, tbl_3):Play()
        end
    end
    if a1.ring then
        local tbl_4 = {Transparency = 1}
        TweenService_upv_1:Create(a1.ring, TweenInfo.new(a2), tbl_4):Play()
    end
    Debris_upv_1:AddItem(a1.folder, a2 + 0.1)
    Debris_upv_1:AddItem(a1.anchor, a2 + 0.2)
end
local u9 = RaycastParams.new()
u9.FilterType = Enum.RaycastFilterType.Exclude
u9.IgnoreWater = true
local tbl_upv_5 = {}
local tbl_upv_6 = {}
local function rootOf(a1)
    --[[
      name: rootOf
      line: 61
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    if not a1 then
        return nil
    end
    local v6 = Util_upv_1.Drawn(a1)
    local v7
    if (v6) and (v6:IsA("Model")) then
        v7 = v6
    else
        v7 = a1
    end
    local v8 = v7:FindFirstChild("HumanoidRootPart") or (a1:FindFirstChild("HumanoidRootPart"))
    if v8 and v8:IsA("BasePart") then
        return v8
    end
    return nil
end
local function stepSwarms(a1)
    --[[
      name: stepSwarms
      line: 183
      upvalues:
        tbl_upv_5 (copy, index: 1)
        tbl_upv_6 (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        rootOf (copy, index: 4)
        tbl_upv_2 (copy, index: 5)
        endSwarm (copy, index: 6)
        u9 (copy, index: 7)
        u8 (ref,  index: 8)
        tbl_upv_1 (copy, index: 9)
        u7 (ref,  index: 10)
    ]]
    local v9 = os.clock()
    table.clear(tbl_upv_5)
    table.clear(tbl_upv_6)
    local Character_1 = LocalPlayer_upv_1.Character
    local v10 = rootOf(Character_1)
    local v11 = 0
    local v12 = false
    local v14 = nil
    local value_3 = nil
    for v27, value_3 in tbl_upv_2 do
        v12 = true
        if value_3.untilT <= v9 then
            endSwarm(value_3, 0.35)
            continue
        end
        local target_1 = value_3.target
        local v13 = not (target_1) or not (target_1.Parent) or rootOf(target_1)
        if v13 then
            local v15 = v13.Position + Vector3.new(0, 0.6000000238418579, 0) - value_3.pos
            local Magnitude_1 = v15.Magnitude
            local v16 = math.min(value_3.speed * a1, math.max(0, Magnitude_1 - 0.6))
            if Magnitude_1 > 0.01 and v16 > 0 then
                value_3.pos = value_3.pos + (v15.Unit * v16)
            end
        end
        local v17 = 1 - math.exp(-a1 * 6)
        value_3.pos = value_3.pos + (value_3.err * v17)
        value_3.err = value_3.err * (1 - v17)
        value_3.anchor.CFrame = CFrame.new(value_3.pos)
        v14 = workspace.CurrentCamera
        if not ((((not v14) and 0) or ((v14.CFrame.Position - value_3.pos).Magnitude)) > 140) then
            for v28, value_4 in value_3.bees do
                local v18 = v9 * value_4.speed + value_4.phase
                local v19 = value_4.radius * ((math.sin((v9 * 3.1) + value_4.phase) * 0.15) + 0.85)
                local v20 = Vector3.new(math.cos(v18) * v19, math.sin((v9 * value_4.bob) + value_4.phase) * 0.45 + (math.sin(v18) * value_4.tilt), math.sin(v18) * v19)
                local v21 = Vector3.new(-math.sin(v18), (math.cos(v18) * value_4.tilt) * 0.6, math.cos(v18))
                local v22 = value_3.pos + v20
                local v23 = CFrame.lookAt(v22, v22 - v21)
                for key_1, value_5 in value_4.parts do
                    table.insert(tbl_upv_5, value_5)
                    table.insert(tbl_upv_6, v23 * value_4.rel[key_1])
                end
            end
        end
        local ring_1 = value_3.ring
        if ring_1 and v9 - value_3.ringAt > 0.1 then
            value_3.ringAt = v9
            v14 = workspace:FindFirstChild("FX")
            v14 = v14 or workspace
            u9.FilterDescendantsInstances = {v14, Character_1}
            local v24 = workspace:Raycast(value_3.pos, Vector3.new(0, -14, 0), u9)
            if v24 then
                ring_1.CFrame = CFrame.lookAt(v24.Position + (v24.Normal * 0.06), v24.Position + (v24.Normal * 1.06)) * CFrame.Angles(0, 1.5707963267948966, 0)
                ring_1.Transparency = 0.6
            else
                ring_1.Transparency = 1
            end
        end
        if not (target_1) or target_1 ~= Character_1 then
            continue
        end
        if v10 then
            v11 = math.max(v11, math.clamp(1 - ((((v10.Position + Vector3.new(0, 0.6000000238418579, 0)) - value_3.pos).Magnitude - value_3.reach) / 5), 0, 1))
        end
    end
    if #tbl_upv_5 > 0 then
        workspace:BulkMoveTo(tbl_upv_5, tbl_upv_6, Enum.BulkMoveMode.FireCFrameChanged)
    end
    local v25 = v11 - u8
    local v26 = ((u8 < v11) and 10) or 3
    u8 = u8 + v25 * (1 - math.exp(-a1 * v26))
    tbl_upv_1.StepBuzz(a1, u8)
    if (v12) or not (u8 < 0.01) or not u7 then
        return
    end
    u7:Disconnect()
    u7 = nil
    tbl_upv_1.StepBuzz(a1, 0)
end
local function newBee(a1, a2)
    --[[
      name: newBee
      line: 111
      upvalues:
        u1 (copy, index: 1)
        u4 (copy, index: 2)
        u5 (copy, index: 3)
    ]]
    local v27
    if u1 then
        v27 = u1:FindFirstChild("Bee")
    else
        v27 = u1
    end
    local tbl_7 = {}
    local tbl_8 = {}
    local v28 = nil
    if v27 then
        v28 = v27:Clone()
        local v29
        if v28:IsA("Model") then
            v29 = v28.PrimaryPart
        elseif v28:IsA("BasePart") then
            v29 = v28
        else
            v29 = nil
        end
        if v28:IsA("Model") and a2 ~= 1 then
            v28:ScaleTo(a2)
        end
        local v30 = ((v28:IsA("BasePart")) and {v28}) or (v28:GetDescendants())
        local v31 = nil
        for _, value_6 in v30 do
            local v32 = value_6:IsA("BasePart")
            if not (v32) then
                continue
            end
            value_6.Anchored = true
            value_6.CanCollide = false
            value_6.CanQuery = false
            value_6.CanTouch = false
            value_6.CastShadow = false
            table.insert(tbl_7, value_6)
            if v29 then
                v31 = v29.CFrame:ToObjectSpace(value_6.CFrame)
            else
                v31 = CFrame.identity
            end
            table.insert(tbl_8, v31)
        end
        v28.Parent = a1
        return v29 or (tbl_7[1]), tbl_7, tbl_8
    else
        local v33 = Instance.new("Part")
        v33.Name = "Bee"
        v33.Anchored = true
        v33.CanCollide = false
        v33.CanQuery = false
        v33.CanTouch = false
        v33.CastShadow = false
        v33.Size = Vector3.new(0.1599999964237213, 0.1599999964237213, 0.25999999046325684) * a2
        v33.Color = u4
        v33.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
        v33.Transparency = 0
        v33.Shape = Enum.PartType.Ball
        local v34 = Instance.new("Part")
        v34.Name = "Band"
        v34.Anchored = true
        v34.CanCollide = false
        v34.CanQuery = false
        v34.CanTouch = false
        v34.CastShadow = false
        v34.Size = Vector3.new(0.17000000178813934, 0.17000000178813934, 0.05999999865889549) * a2
        v34.Color = u5
        v34.Material = Enum.Material.SmoothPlastic
        v34.Transparency = 0
        v34.Shape = Enum.PartType.Ball
        local v35 = Color3.fromRGB(196, 214, 226)
        local v36 = Instance.new("Part")
        v36.Name = "Wings"
        v36.Anchored = true
        v36.CanCollide = false
        v36.CanQuery = false
        v36.CanTouch = false
        v36.CastShadow = false
        v36.Size = Vector3.new(0.3199999928474426, 0.019999999552965164, 0.10000000149011612) * a2
        v36.Color = v35
        v36.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
        v36.Transparency = 0.35
        v33.Parent = a1
        v34.Parent = a1
        v36.Parent = a1
        local tbl_9 = {v33, v34, v36}
        local tbl_10 = {CFrame.identity, CFrame.new(0, 0, a2 * 0.04), CFrame.new(0, a2 * 0.08, a2 * -0.02)}
        return v33, tbl_9, tbl_10
    end
end
function tbl_upv_1.Swarm(a1)
    --[[
      name: Swarm
      line: 260
      upvalues:
        tbl_upv_2 (copy, index: 1)
        endSwarm (copy, index: 2)
        Util_upv_1 (copy, index: 3)
        u4 (copy, index: 4)
        u2 (copy, index: 5)
        u3 (copy, index: 6)
        Quality_upv_1 (copy, index: 7)
        newBee (copy, index: 8)
        Effects_upv_1 (copy, index: 9)
        u7 (ref,  index: 10)
        RunService_upv_1 (copy, index: 11)
        stepSwarms (copy, index: 12)
    ]]
    local num_1 = tonumber(a1.id)
    local position_1 = a1.position
    if not num_1 or typeof(position_1) ~= "Vector3" then
        return
    end
    local v37 = tbl_upv_2[num_1]
    if v37 then
        endSwarm(v37, 0)
    end
    local v38 = a1.attacker
    v37 = typeof(v38) ~= "Instance" or not (v38:IsA("Model")) or v38
    local v39 = false
    if v37 == nil then
        v38 = v39
    else
        v38 = Util_upv_1.IsEnemy(v37)
    end
    local v40 = Instance.new("Folder")
    v40.Name = "Swarm"
    local v41 = workspace:FindFirstChild("FX") or workspace
    v40.Parent = v41
    v41 = Instance.new("Part")
    v41.Name = "SwarmCore"
    v41.Anchored = true
    v41.CanCollide = false
    v41.CanQuery = false
    v41.CanTouch = false
    v41.CastShadow = false
    v41.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    v41.Color = u4
    v41.Material = Enum.Material.SmoothPlastic
    v41.Transparency = 1
    v41.CFrame = CFrame.new(position_1)
    v41.Parent = v40
    local v42 = Instance.new("ParticleEmitter")
    v42.Name = "Haze"
    v42.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    local new_1 = ColorSequence.new
    local v43
    if v38 then
        v43 = u2
    else
        v43 = u3
    end
    v42.Color = new_1(v43)
    v42.LightEmission = 0.25
    v42.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.38), NumberSequenceKeypoint.new(1, 0)})
    v42.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1)})
    v42.Lifetime = NumberRange.new(0.35, 0.6)
    v42.Rate = ((Quality_upv_1.layers) and 22) or 10
    v42.Speed = NumberRange.new(0.5, 2)
    v42.SpreadAngle = Vector2.new(180, 180)
    v42.Shape = Enum.ParticleEmitterShape.Sphere
    v42.Parent = v41
    local v44 = Instance.new("ParticleEmitter")
    v44.Name = "Specks"
    v44.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    v44.Color = ColorSequence.new(Color3.fromRGB(60, 44, 20), Color3.fromRGB(150, 110, 30))
    v44.LightEmission = 0
    v44.LightInfluence = 1
    v44.Size = NumberSequence.new(0.16, 0.12)
    v44.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(0.8, 0.25), NumberSequenceKeypoint.new(1, 1)})
    v44.Lifetime = NumberRange.new(0.25, 0.45)
    v44.Rate = ((Quality_upv_1.layers) and 70) or 30
    v44.Speed = NumberRange.new(4, 8)
    v44.SpreadAngle = Vector2.new(180, 180)
    v44.Acceleration = Vector3.new(0, 0, 0)
    v44.Drag = 3
    v44.Shape = Enum.ParticleEmitterShape.Sphere
    v44.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
    v44.Parent = v41
    v41.Size = Vector3.new(2.5999999046325684, 2.5999999046325684, 2.5999999046325684)
    local CurrentCamera_2 = workspace.CurrentCamera
    local v45 = (((((not CurrentCamera_2) and 0) or ((CurrentCamera_2.CFrame.Position - position_1).Magnitude)) > 90) and 10) or (((Quality_upv_1.layers) and 22) or 14)
    local v46 = Random.new(num_1)
    local tbl_11 = {}
    for _ = 1, v45 do
        local v47, v48, v49 = newBee(v40, 1.5 * v46:NextNumber(0.85, 1.15))
        local tbl_12 = {bob = 0, tilt = 0, phase = 0, speed = 0}
        tbl_12.part = v47
        tbl_12.parts = v48
        tbl_12.rel = v49
        tbl_12.radius = v46:NextNumber(0.9, 2.4)
        local v50 = v46:NextNumber(5, 9)
        local v51 = ((v46:NextNumber() < 0.5) and -1) or 1
        tbl_12.speed = v50 * v51
        tbl_12.phase = v46:NextNumber(0, math.tau)
        tbl_12.tilt = v46:NextNumber(-0.5, 0.5)
        tbl_12.bob = v46:NextNumber(5, 9)
        table.insert(tbl_11, tbl_12)
    end
    local v52
    if v38 then
        v52 = u2
    else
        v52 = u3
    end
    local v53 = Instance.new("Part")
    v53.Name = "SwarmRing"
    v53.Anchored = true
    v53.CanCollide = false
    v53.CanQuery = false
    v53.CanTouch = false
    v53.CastShadow = false
    v53.Size = Vector3.new(0.05000000074505806, 5, 5)
    v53.Color = v52
    v53.Material = Enum.Material.SmoothPlastic
    v53.Transparency = 1
    v53.Shape = Enum.PartType.Cylinder
    v53.Parent = v40
    local v54 = tonumber(a1.duration) or 4.5
    local tbl_13 = {ringAt = 0, ending = false, err = Vector3.new(0, 0, 0)}
    tbl_13.id = num_1
    tbl_13.pos = position_1
    tbl_13.speed = tonumber(a1.speed) or 18
    tbl_13.reach = tonumber(a1.reach) or 4
    tbl_13.untilT = os.clock() + v54
    tbl_13.enemy = v38
    tbl_13.bees = tbl_11
    tbl_13.ring = v53
    tbl_13.folder = v40
    tbl_13.anchor = v41
    tbl_upv_2[num_1] = tbl_13
    local CurrentCamera_3 = workspace.CurrentCamera
    if (((not CurrentCamera_3) and 0) or ((CurrentCamera_3.CFrame.Position - position_1).Magnitude)) <= 160 then
        Util_upv_1.Sound("Beehive_Break", position_1)
        tbl_13.stopLoop = Util_upv_1.Loop("Bees_Loop", v41)
        Effects_upv_1.Puff(position_1, Color3.fromRGB(196, 160, 96), 8, 0.9, 6, 0.5)
    end
    if (u7) then
        return
    end
    u7 = RunService_upv_1.Heartbeat:Connect(stepSwarms)
end
function tbl_upv_1.SwarmTarget(a1)
    --[[
      name: SwarmTarget
      line: 359
      upvalues:
        tbl_upv_2 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        Util_upv_1 (copy, index: 3)
    ]]
    local v55 = tbl_upv_2[tonumber(a1.id) or -1]
    if not v55 then
        return
    end
    if typeof(a1.position) == "Vector3" then
        v55.err = a1.position - v55.pos
    end
    local target_2 = a1.target
    local v56 = typeof(target_2) ~= "Instance" or not (target_2:IsA("Model")) or target_2
    v55.target = v56
    if not v56 then
        return
    end
    if v56 == LocalPlayer_upv_1.Character then
        Util_upv_1.Sound("Bees_Angry", v55.anchor)
    end
end
function tbl_upv_1.SwarmSync(a1)
    --[[
      name: SwarmSync
      line: 375
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v57 = tbl_upv_2[tonumber(a1.id) or -1]
    if not v57 or typeof(a1.position) ~= "Vector3" then
        return
    end
    v57.err = a1.position - v57.pos
end
function tbl_upv_1.SwarmEnd(a1)
    --[[
      name: SwarmEnd
      line: 382
      upvalues:
        tbl_upv_2 (copy, index: 1)
        endSwarm (copy, index: 2)
    ]]
    local v58 = tbl_upv_2[tonumber(a1.id) or -1]
    if not v58 then
        return
    end
    endSwarm(v58, 0.3)
end
local u10 = nil
local tbl_upv_14 = {}
local tbl_upv_15 = {}
local function buildGui()
    --[[
      name: buildGui
      line: 396
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u10 (ref,  index: 2)
        tbl_upv_14 (copy, index: 3)
        u4 (copy, index: 4)
        u5 (copy, index: 5)
        tbl_upv_15 (copy, index: 6)
    ]]
    local v59 = LocalPlayer_upv_1:FindFirstChildOfClass("PlayerGui")
    if not v59 then
        return
    end
    local v60 = Instance.new("ScreenGui")
    v60.Name = "TribesSwarm"
    v60.IgnoreGuiInset = true
    v60.ResetOnSpawn = false
    v60.DisplayOrder = 4
    v60.Enabled = false
    v60.Parent = v59
    u10 = v60
    local tbl_16 = {UDim2.new(1, 0, 0.22, 0), UDim2.fromScale(0.5, 0), Vector2.new(0.5, 0), 90}
    local tbl_17 = {UDim2.new(1, 0, 0.22, 0), UDim2.fromScale(0.5, 1), Vector2.new(0.5, 1), -90}
    local tbl_18 = {UDim2.new(0.18, 0, 1, 0), UDim2.fromScale(0, 0.5), Vector2.new(0, 0.5), 0}
    local tbl_19 = {tbl_16, tbl_17, tbl_18, {UDim2.new(0.18, 0, 1, 0), UDim2.fromScale(1, 0.5), Vector2.new(1, 0.5), 180}}
    for _, value_7 in tbl_19 do
        local v61 = Instance.new("Frame")
        v61.Name = "Edge"
        v61.Size = value_7[1]
        v61.Position = value_7[2]
        v61.AnchorPoint = value_7[3]
        v61.BorderSizePixel = 0
        v61.BackgroundColor3 = Color3.fromRGB(196, 136, 30)
        v61.BackgroundTransparency = 1
        local v62 = Instance.new("UIGradient")
        v62.Rotation = value_7[4]
        v62.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)})
        v62.Parent = v61
        v61.Parent = v60
        table.insert(tbl_upv_14, v61)
    end
    local v63 = Random.new()
    for n_1 = 1, 12 do
        local v64 = Instance.new("Frame")
        v64.Name = "Bee" .. n_1
        v64.AnchorPoint = Vector2.new(0.5, 0.5)
        v64.BackgroundColor3 = u4
        v64.BorderSizePixel = 0
        v64.BackgroundTransparency = 1
        local v65 = v63:NextInteger(10, 18)
        v64.Size = UDim2.fromOffset(v65, math.floor(v65 * 0.66))
        v65 = Instance.new("UICorner")
        v65.CornerRadius = UDim.new(0.5, 0)
        v65.Parent = v64
        v65 = Instance.new("UIGradient")
        v65.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, u5), ColorSequenceKeypoint.new(0.22, u5), ColorSequenceKeypoint.new(0.23, u4), ColorSequenceKeypoint.new(0.44, u4), ColorSequenceKeypoint.new(0.45, u5), ColorSequenceKeypoint.new(0.6, u5), ColorSequenceKeypoint.new(0.61, u4), ColorSequenceKeypoint.new(1, u4)})
        v65.Parent = v64
        v65 = Instance.new("Frame")
        v65.Name = "Wing"
        v65.AnchorPoint = Vector2.new(0.5, 1)
        v65.Position = UDim2.fromScale(0.45, 0.15)
        v65.Size = UDim2.fromScale(0.55, 0.9)
        v65.BackgroundColor3 = Color3.fromRGB(200, 216, 228)
        v65.BackgroundTransparency = 1
        v65.BorderSizePixel = 0
        local v66 = Instance.new("UICorner")
        v66.CornerRadius = UDim.new(0.5, 0)
        v66.Parent = v65
        v65.Parent = v64
        v64.Parent = v60
        table.insert(tbl_upv_15, {vy = 0, vx = 0, f = v64, x = v63:NextNumber(), y = v63:NextNumber(), t = v63:NextNumber(0, 10)})
    end
end
function tbl_upv_1.StepBuzz(a1, a2)
    --[[
      name: StepBuzz
      line: 475
      upvalues:
        u10 (ref,  index: 1)
        buildGui (copy, index: 2)
        tbl_upv_14 (copy, index: 3)
        tbl_upv_15 (copy, index: 4)
    ]]
    if a2 < 0.02 then
        if u10 and u10.Enabled then
            u10.Enabled = false
        end
    else
        if not (u10) then
            buildGui()
        end
        if not u10 then
            return
        end
        u10.Enabled = true
        for _, value_8 in tbl_upv_14 do
            value_8.BackgroundTransparency = 1 - (a2 * 0.4)
        end
        local v67 = math.ceil(#tbl_upv_15 * math.clamp(a2, 0, 1))
        local v68 = nil
        for key_2, value_9 in tbl_upv_15 do
            value_9.t = value_9.t + a1
            local v69 = key_2 <= v67
            local f_1 = value_9.f
            if v69 then
                v68 = 0.05
            else
                v68 = 1
            end
            f_1.BackgroundTransparency = v68
            local Wing_1 = value_9.f:FindFirstChild("Wing")
            if Wing_1 then
                v68 = ((not v69) and 1) or (((math.floor(value_9.t * 30) % 2 ~= 0) and 0.75) or 0.35)
                Wing_1.BackgroundTransparency = v68
            end
            if v69 then
                local v70 = (math.sin((value_9.t * 1.7) + key_2) * 0.38) * (1.15 - (a2 * 0.6)) + 0.5
                local v71 = (math.cos((value_9.t * 1.3) + (key_2 * 2)) * 0.32) * (1.15 - (a2 * 0.6)) + 0.5
                value_9.vx = value_9.vx + ((((v70 - value_9.x) * 9) + ((math.random() - 0.5) * 6)) * a1)
                value_9.vy = value_9.vy + ((((v71 - value_9.y) * 9) + ((math.random() - 0.5) * 6)) * a1)
                value_9.vx = value_9.vx * 0.94
                value_9.vy = value_9.vy * 0.94
                value_9.x = math.clamp(value_9.x + (value_9.vx * a1), -0.05, 1.05)
                value_9.y = math.clamp(value_9.y + (value_9.vy * a1), -0.05, 1.05)
                value_9.f.Position = UDim2.fromScale(value_9.x, value_9.y)
                value_9.f.Rotation = math.deg(math.atan2(value_9.vy, value_9.vx))
            end
        end
    end
end
function tbl_upv_1.Stung()
    --[[
      name: Stung
      line: 521
      upvalues:
        u8 (ref,  index: 1)
        Util_upv_1 (copy, index: 2)
        u7 (ref,  index: 3)
        RunService_upv_1 (copy, index: 4)
        stepSwarms (copy, index: 5)
    ]]
    u8 = math.max(u8, 0.7)
    Util_upv_1.Sound("Bees_Angry")
    if (u7) then
        return
    end
    u7 = RunService_upv_1.Heartbeat:Connect(stepSwarms)
end
local tbl_upv_20 = {}
local u11 = Color3.fromRGB(255, 176, 40)
local u12 = Color3.fromRGB(18, 20, 26)
local u13 = Color3.fromRGB(255, 255, 255)
local u14 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy)
local u15 = nil
local u16 = nil
local u17 = nil
local function clearMark(a1)
    --[[
      name: clearMark
      line: 561
      upvalues:
        u15 (ref, index: 1)
        u17 (ref, index: 2)
    ]]
    if not u15 then
        return
    end
    if not a1 or u15.key == a1 then
        u15 = nil
        u15.frame:Destroy()
        if u15.outline then
            u15.outline:Destroy()
        end
        if u17 then
            u17:Disconnect()
            u17 = nil
        end
        return
    end
end
local function stepMark()
    --[[
      name: stepMark
      line: 577
      upvalues:
        u15 (ref,  index: 1)
        TweenService_upv_1 (copy, index: 2)
    ]]
    local CurrentCamera_4 = workspace.CurrentCamera
    if not u15 or not CurrentCamera_4 then
        return
    end
    local ViewportSize_1 = CurrentCamera_4.ViewportSize
    local v72 = CurrentCamera_4:WorldToViewportPoint(u15.at)
    local X_1 = v72.X
    local Y_1 = v72.Y
    if v72.Z <= 0 then
        X_1 = ViewportSize_1.X - X_1
        Y_1 = ViewportSize_1.Y
    end
    local v73 = math.max(44, ViewportSize_1.X - 44)
    local v74 = math.max(84, ViewportSize_1.Y - 44)
    local v75 = os.clock()
    local v76
    if v75 - u15.born < 0.25 then
        return
    end
    if not (u15.shown) then
        u15.shown = true
        u15.frame.Visible = true
        local tbl_21 = {Scale = 1}
        TweenService_upv_1:Create(u15.scale, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_21):Play()
    end
    local v77 = math.clamp(X_1, 44, v73)
    local v78 = math.clamp(Y_1, 84, v74)
    u15.frame.Position = UDim2.fromOffset(v77, v78)
    u15.pointer.Position = UDim2.new(0.5, 0, 1, -9 - (math.abs(math.sin((v75 - u15.born) * 4)) * 2))
    v76 = math.clamp(1 - ((Vector2.new(v77, v78 - 36) - (ViewportSize_1 / 2)).Magnitude / 110), 0, 1) * 0.75
    if math.abs(v76 - u15.fade) > 0.01 then
        u15.fade = v76
        for _, value_10 in u15.fades do
            value_10.inst[value_10.prop] = value_10.base + ((1 - value_10.base) * v76)
        end
    end
    u15.bar.Size = UDim2.fromScale(math.clamp((u15.returnsAt - workspace:GetServerTimeNow()) / u15.span, 0, 1), 1)
end
local function showMark(a1, a2, a3, a4)
    --[[
      name: showMark
      line: 616
      upvalues:
        u15 (ref,  index: 1)
        u17 (ref,  index: 2)
        u16 (ref,  index: 3)
        LocalPlayer_upv_1 (copy, index: 4)
        u12 (copy, index: 5)
        u11 (copy, index: 6)
        u14 (copy, index: 7)
        u13 (copy, index: 8)
        RunService_upv_1 (copy, index: 9)
        stepMark (copy, index: 10)
    ]]
    local v79 = u15
    if v79 then
        u15 = nil
        v79.frame:Destroy()
        if v79.outline then
            v79.outline:Destroy()
        end
        if u17 then
            u17:Disconnect()
            u17 = nil
        end
    end
    local v80 = u16
    if not (v80) or not (v80.Parent) then
        local v81 = LocalPlayer_upv_1:FindFirstChildOfClass("PlayerGui")
        if not v81 then
            return
        end
        local v82 = Instance.new("ScreenGui")
        v82.Name = "TribesHatchetMark"
        v82.ResetOnSpawn = false
        v82.IgnoreGuiInset = true
        v82.ScreenInsets = Enum.ScreenInsets.None
        v82.DisplayOrder = 4
        v82.Parent = v81
        u16 = v82
        v80 = v82
    end
    local v83 = Instance.new("Frame")
    v83.Name = "Mark"
    v83.AnchorPoint = Vector2.new(0.5, 1)
    v83.Size = UDim2.fromOffset(96, 54)
    v83.BackgroundTransparency = 1
    v83.Visible = false
    local v84 = Instance.new("UIScale")
    v84.Scale = 0.6
    v84.Parent = v83
    local v85 = Instance.new("Frame")
    v85.Name = "Pill"
    v85.AnchorPoint = Vector2.new(0.5, 0)
    v85.Position = UDim2.new(0.5, 0, 0, 4)
    v85.Size = UDim2.fromOffset(84, 26)
    v85.BackgroundColor3 = u12
    v85.BackgroundTransparency = 0.25
    v85.BorderSizePixel = 0
    v85.Parent = v83
    local v86 = Instance.new("UICorner")
    v86.CornerRadius = UDim.new(0, 7)
    v86.Parent = v85
    local v87 = Instance.new("UIStroke")
    v87.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v87.Thickness = 1.5
    v87.Color = u11
    v87.Transparency = 0.35
    v87.Parent = v85
    local v88 = Instance.new("TextLabel")
    v88.BackgroundTransparency = 1
    v88.Size = UDim2.new(1, 0, 1, -4)
    v88.FontFace = u14
    v88.TextSize = 15
    v88.TextColor3 = u13
    v88.Text = "PICK UP"
    v88.AutoLocalize = false
    v88.Parent = v85
    local v89 = Instance.new("Frame")
    v89.Name = "Timer"
    v89.AnchorPoint = Vector2.new(0, 1)
    v89.Position = UDim2.new(0, 10, 1, -4)
    v89.Size = UDim2.new(1, -20, 0, 2)
    v89.BackgroundTransparency = 1
    v89.Parent = v85
    local v90 = Instance.new("Frame")
    v90.Name = "Left"
    v90.Size = UDim2.fromScale(1, 1)
    v90.BackgroundColor3 = u11
    v90.BorderSizePixel = 0
    v90.Parent = v89
    local v91 = Instance.new("Frame")
    v91.Name = "Pointer"
    v91.AnchorPoint = Vector2.new(0.5, 0.5)
    v91.Size = UDim2.fromOffset(10, 10)
    v91.Rotation = 45
    v91.BackgroundColor3 = u11
    v91.BorderSizePixel = 0
    v91.Parent = v83
    local v92 = Instance.new("UICorner")
    v92.CornerRadius = UDim.new(0, 2)
    v92.Parent = v91
    local v93 = Instance.new("UIStroke")
    v93.Thickness = 1.5
    v93.Color = u12
    v93.Transparency = 0.3
    v93.Parent = v91
    v83.Parent = v80
    v80 = Instance.new("Highlight")
    v80.Name = "PickUpOutline"
    v80.FillColor = u11
    v80.FillTransparency = 0.8
    v80.OutlineColor = u11
    v80.OutlineTransparency = 0.15
    v80.DepthMode = Enum.HighlightDepthMode.Occluded
    v80.Adornee = a2
    v80.Parent = a2
    local v94 = workspace:GetServerTimeNow()
    local v95
    if type(a4) == "number" and (v94 < a4) then
        v95 = a4
    else
        v95 = v94 + 5
    end
    local tbl_22 = {{prop = "BackgroundTransparency", inst = v85, base = v85.BackgroundTransparency}, {prop = "Transparency", inst = v87, base = v87.Transparency}, {base = 0, prop = "TextTransparency", inst = v88}, {base = 0, prop = "BackgroundTransparency", inst = v90}, {base = 0, prop = "BackgroundTransparency", inst = v91}, {prop = "Transparency", inst = v93, base = v93.Transparency}}
    local tbl_23 = {fade = 0, shown = false}
    tbl_23.key = a1
    tbl_23.at = a3 + Vector3.new(0, 1.600000023841858, 0)
    tbl_23.frame = v83
    tbl_23.bar = v90
    tbl_23.pointer = v91
    tbl_23.scale = v84
    tbl_23.born = os.clock()
    tbl_23.returnsAt = v95
    tbl_23.span = math.max(0.5, v95 - v94)
    tbl_23.outline = v80
    tbl_23.fades = tbl_22
    u15 = tbl_23
    if not (u17) then
        u17 = RunService_upv_1.RenderStepped:Connect(stepMark)
    end
    stepMark()
end
local function place(a1, a2)
    --[[
      name: place
      line: 755
    ]]
    if a1:IsA("Model") then
        a1:PivotTo(a2)
    elseif a1:IsA("BasePart") then
        a1.CFrame = a2
    end
end
local function hatchetModel()
    --[[
      name: hatchetModel
      line: 727
      upvalues:
        u1 (copy, index: 1)
    ]]
    if u1 and not (u1:FindFirstChild("Hatchet")) and u1:FindFirstChild("Projectiles") then
        local _ = u1.Projectiles:FindFirstChild("Hatchet")
    end
    if u1 then
        local v96 = u1:Clone()
        local v97 = ((v96:IsA("BasePart")) and {v96}) or (v96:GetDescendants())
        for _, value_11 in v97 do
            if value_11:IsA("BasePart") then
                value_11.Anchored = true
                value_11.CanCollide = false
                value_11.CanQuery = false
                value_11.CanTouch = false
                continue
            end
            if value_11:IsA("Trail") or value_11:IsA("ParticleEmitter") then
                value_11.Enabled = false
            end
        end
        return v96
    else
        local v98 = Instance.new("Model")
        local v99 = Color3.fromRGB(150, 104, 66)
        local v100 = Instance.new("Part")
        v100.Name = "Haft"
        v100.Anchored = true
        v100.CanCollide = false
        v100.CanQuery = false
        v100.CanTouch = false
        v100.CastShadow = false
        v100.Size = Vector3.new(0.18000000715255737, 2.200000047683716, 0.18000000715255737)
        v100.Color = v99
        v100.Material = Enum.Material.Wood or (Enum.Material.SmoothPlastic)
        v100.Transparency = 0
        v100.CFrame = CFrame.new(0, 1.1, 0.3)
        v100.Parent = v98
        local v101 = Color3.fromRGB(80, 80, 86)
        local v102 = Instance.new("Part")
        v102.Name = "Head"
        v102.Anchored = true
        v102.CanCollide = false
        v102.CanQuery = false
        v102.CanTouch = false
        v102.CastShadow = false
        v102.Size = Vector3.new(0.11999999731779099, 0.800000011920929, 0.75)
        v102.Color = v101
        v102.Material = Enum.Material.Metal or (Enum.Material.SmoothPlastic)
        v102.Transparency = 0
        v102.CFrame = CFrame.new(0, 0.2, 0)
        v102.Parent = v98
        v98.PrimaryPart = v102
        return v98
    end
end
function tbl_upv_1.HatchetDrop(a1)
    --[[
      name: HatchetDrop
      line: 763
      upvalues:
        tbl_upv_20 (copy, index: 1)
        hatchetModel (copy, index: 2)
        Util_upv_1 (copy, index: 3)
        Effects_upv_1 (copy, index: 4)
        LocalPlayer_upv_1 (copy, index: 5)
        showMark (copy, index: 6)
        u15 (ref,  index: 7)
        u17 (ref,  index: 8)
    ]]
    local key_upv_3 = a1.key
    local cframe_1 = a1.cframe
    if type(key_upv_3) ~= "string" then
        return
    end
    if typeof(cframe_1) == "CFrame" then
        local v103 = tbl_upv_20[key_upv_3]
        if v103 then
            v103.model:Destroy()
        end
        local u18 = hatchetModel()
        if u18:IsA("Model") then
            u18:PivotTo(cframe_1)
        elseif u18:IsA("BasePart") then
            u18.CFrame = cframe_1
        end
        local v104 = workspace:FindFirstChild("FX") or workspace
        u18.Parent = v104
        local owner_1 = a1.owner
        v104 = typeof(owner_1) ~= "Instance" or not (owner_1:IsA("Model")) or owner_1
        tbl_upv_20[key_upv_3] = {model = u18, owner = v104}
        local CurrentCamera_5 = workspace.CurrentCamera
        if (((not CurrentCamera_5) and 0) or ((CurrentCamera_5.CFrame.Position - cframe_1.Position).Magnitude)) <= 120 then
            Util_upv_1.Sound("Hatchet_Thunk", cframe_1.Position)
            Effects_upv_1.Puff(cframe_1.Position, Color3.fromRGB(150, 132, 108), 5, 0.6, 4, 0.4)
        end
        if v104 and v104 == LocalPlayer_upv_1.Character then
            showMark(key_upv_3, u18, cframe_1.Position, a1.returnsAt)
        end
        task.delay(
            10,
            function()
                --[[
                  line: 786
                  upvalues:
                    tbl_upv_20 (copy, index: 1)
                    key_upv_3 (copy, index: 2)
                    u18 (copy, index: 3)
                    u15 (ref,  index: 4)
                    u17 (ref,  index: 5)
                ]]
                local v105 = tbl_upv_20[key_upv_3]
                if not v105 then
                    return
                end
                if v105.model == u18 then
                    tbl_upv_20[key_upv_3] = nil
                    local v106 = key_upv_3
                    local v107 = u15
                    if v107 and (not (v106) or v107.key == v106) then
                        u15 = nil
                        v107.frame:Destroy()
                        if v107.outline then
                            v107.outline:Destroy()
                        end
                        if u17 then
                            u17:Disconnect()
                            u17 = nil
                        end
                    end
                    u18:Destroy()
                end
            end
        )
    end
end
function tbl_upv_1.HatchetEnd(a1)
    --[[
      name: HatchetEnd
      line: 796
      upvalues:
        tbl_upv_20 (copy, index: 1)
        u15 (ref,  index: 2)
        u17 (ref,  index: 3)
        rootOf (copy, index: 4)
        RunService_upv_1 (copy, index: 5)
        TweenService_upv_1 (copy, index: 6)
        Debris_upv_1 (copy, index: 7)
        LocalPlayer_upv_1 (copy, index: 8)
        Util_upv_1 (copy, index: 9)
    ]]
    local key_4 = a1.key
    if type(key_4) ~= "string" then
        return
    end
    local v108 = tbl_upv_20[key_4]
    tbl_upv_20[key_4] = nil
    local v109 = u15
    if v109 and (not (key_4) or v109.key == key_4) then
        u15 = nil
        v109.frame:Destroy()
        if v109.outline then
            v109.outline:Destroy()
        end
        if u17 then
            u17:Disconnect()
            u17 = nil
        end
    end
    local owner_2 = a1.owner
    key_4 = typeof(owner_2) ~= "Instance" or not (owner_2:IsA("Model")) or owner_2
    local u19
    if key_4 then
        u19 = rootOf(key_4)
    else
        v109 = nil
    end
    if v108 then
        local model_upv_1 = v108.model
        if u19 then
            if a1.how ~= "pickup" then
                local v110 = ((model_upv_1:IsA("BasePart")) and {model_upv_1}) or (model_upv_1:GetDescendants())
                for _, value_12 in v110 do
                    if value_12:IsA("BasePart") then
                        local tbl_24 = {Transparency = 1}
                        TweenService_upv_1:Create(value_12, TweenInfo.new(0.25), tbl_24):Play()
                    end
                end
                Debris_upv_1:AddItem(model_upv_1, 0.3)
            else
                local CFrame_upv_1
                if model_upv_1:IsA("Model") then
                    CFrame_upv_1 = model_upv_1:GetPivot()
                else
                    CFrame_upv_1 = model_upv_1.CFrame
                end
                local u20 = os.clock()
                local u21 = nil
                local v111 = RunService_upv_1.Heartbeat:Connect(
                    function()
                        --[[
                          line: 813
                          upvalues:
                            u20 (copy, index: 1)
                            model_upv_1 (copy, index: 2)
                            u19 (copy, index: 3)
                            u21 (ref,  index: 4)
                            CFrame_upv_1 (copy, index: 5)
                        ]]
                        local v112 = math.clamp((os.clock() - u20) / 0.12, 0, 1)
                        if model_upv_1.Parent and u19.Parent then
                            if v112 >= 1 then
                                if u21 then
                                    u21:Disconnect()
                                end
                            else
                                local v113 = CFrame_upv_1:Lerp(u19.CFrame * CFrame.new(0.8, 0.6, -0.6), v112 * v112)
                                if model_upv_1:IsA("Model") then
                                    model_upv_1:PivotTo(v113)
                                elseif model_upv_1:IsA("BasePart") then
                                    model_upv_1.CFrame = v113
                                end
                                return
                            end
                        elseif u21 then
                            u21:Disconnect()
                        end
                        model_upv_1:Destroy()
                    end
                )
                u21 = v111
            end
        else
            local v110 = ((model_upv_1:IsA("BasePart")) and {model_upv_1}) or (model_upv_1:GetDescendants())
            for _, value_12 in v110 do
                if value_12:IsA("BasePart") then
                    local tbl_24 = {Transparency = 1}
                    TweenService_upv_1:Create(value_12, TweenInfo.new(0.25), tbl_24):Play()
                end
            end
            Debris_upv_1:AddItem(model_upv_1, 0.3)
        end
    end
    if a1.how == "reset" then
        return
    end
    if key_4 and u19 then
        local v114 = nil
        if key_4 == LocalPlayer_upv_1.Character then
            Util_upv_1.Sound("Hatchet_Catch", u19)
        else
            v114 = workspace.CurrentCamera
            if ((((not v114) and 0) or ((v114.CFrame.Position - u19.Position).Magnitude)) <= 80) then
                Util_upv_1.Sound("Hatchet_Catch", u19)
            end
        end
    end
end
function tbl_upv_1.ParryStart(a1)
    --[[
      name: ParryStart
      line: 840
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        rootOf (copy, index: 2)
        Util_upv_1 (copy, index: 3)
        Effects_upv_1 (copy, index: 4)
    ]]
    local attacker_1 = a1.attacker
    local v115 = typeof(attacker_1) ~= "Instance" or not (attacker_1:IsA("Model")) or attacker_1
    if not v115 then
        return
    end
    if v115 ~= LocalPlayer_upv_1.Character then
        local v116 = rootOf(v115)
        if v116 then
            local CurrentCamera_6 = workspace.CurrentCamera
            if not ((((not CurrentCamera_6) and 0) or ((CurrentCamera_6.CFrame.Position - v116.Position).Magnitude)) > 150) then
                Util_upv_1.Sound("Katana_Flick", v116)
                local v117 = Util_upv_1.ToolPoint(v115:FindFirstChildOfClass("Tool"), "Tip")
                if v117 then
                    Effects_upv_1.Burst("Charge_Sparkle", CFrame.new(v117), 0.6, Color3.fromRGB(170, 210, 240))
                end
                return
            end
        end
    end
end
function tbl_upv_1.Parried(a1)
    --[[
      name: Parried
      line: 860
      upvalues:
        Util_upv_1 (copy, index: 1)
        Effects_upv_1 (copy, index: 2)
        u6 (copy, index: 3)
        rootOf (copy, index: 4)
        TweenService_upv_1 (copy, index: 5)
        Debris_upv_1 (copy, index: 6)
    ]]
    local position_2 = a1.position
    if typeof(position_2) == "Vector3" then
        local CurrentCamera_7 = workspace.CurrentCamera
        if not ((((not CurrentCamera_7) and 0) or ((CurrentCamera_7.CFrame.Position - position_2).Magnitude)) > 160) then
            local v118 = a1.ranged == true
            local Sound_1 = Util_upv_1.Sound
            local v119
            if v118 then
                v119 = "Katana_Deflect"
            else
                v119 = "Katana_Parry"
            end
            Sound_1(v119, position_2)
            local Burst_1 = Effects_upv_1.Burst
            local v120 = CFrame.new(position_2)
            Burst_1("Block_Spark", v120, (v118 and 1.2) or 1.6, u6)
            Effects_upv_1.Burst("Impact_Sparks", CFrame.new(position_2), 0.8, u6)
            local target_3 = a1.target
            local v121 = typeof(target_3) ~= "Instance" or not (target_3:IsA("Model")) or target_3
            local v122 = rootOf(v121)
            local v123 = ((not v122) and Vector3.new(0, 0, 1)) or (v122.CFrame.LookVector)
            local v124 = Color3.fromRGB(176, 214, 240)
            local v125 = Instance.new("Part")
            v125.Name = "ParryRing"
            v125.Anchored = true
            v125.CanCollide = false
            v125.CanQuery = false
            v125.CanTouch = false
            v125.CastShadow = false
            v125.Size = Vector3.new(0.05000000074505806, 0.6000000238418579, 0.6000000238418579)
            v125.Color = v124
            v125.Material = Enum.Material.SmoothPlastic
            v125.Transparency = 0.3
            v125.Shape = Enum.PartType.Cylinder
            v125.CFrame = CFrame.lookAt(position_2, position_2 + v123) * CFrame.Angles(0, 1.5707963267948966, 0)
            v125.Parent = workspace:FindFirstChild("FX") or workspace
            local v127 = TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            local tbl_25 = {Transparency = 1, Size = 0}
            tbl_25.Size = Vector3.new(0.05, (v118 and 3.2) or 4.2, (v118 and 3.2) or 4.2)
            TweenService_upv_1:Create(v125, v127, tbl_25):Play()
            Debris_upv_1:AddItem(v125, 0.3)
        end
    end
end
return tbl_upv_1