local Debris_upv_1 = game:GetService("Debris")
local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local TweenService_upv_1 = game:GetService("TweenService")
local Shared_1 = ReplicatedStorage_1:WaitForChild("Shared")
local Combat_upv_1 = require(Shared_1.Combat)
local Weapons_upv_1 = require(Shared_1.Weapons)
local Ballistics_upv_1 = Combat_upv_1.Ballistics
local Util_upv_1 = require(script.Parent.Util)
local Metrics_upv_1 = require(script.Parent.Metrics)
local Quality_upv_1 = require(script.Parent.Quality)
local Presentation_upv_1 = require(script.Parent.Presentation)
local tbl_upv_1 = {}
local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
local u1 = Util_upv_1.Assets:WaitForChild("VFX", 10)
local u2 = workspace:FindFirstChild("FX")
if not (u2) then
    u2 = Instance.new("Folder")
    u2.Name = "FX"
    u2.Parent = workspace
end
local function fx()
    --[[
      name: fx
      line: 34
      upvalues:
        u2 (ref, index: 1)
    ]]
    local FX_1 = workspace:FindFirstChild("FX")
    if FX_1 then
        u2 = FX_1
    end
    return u2
end
local function prep(a1)
    --[[
      name: prep
      line: 61
    ]]
    local v1 = a1:GetDescendants()
    table.insert(v1, a1)
    for _, value_1 in v1 do
        if value_1:IsA("BasePart") then
            value_1.Anchored = true
            value_1.CanCollide = false
            value_1.CanQuery = false
            value_1.CanTouch = false
            value_1.CastShadow = false
        end
    end
end
local tbl_upv_2 = {}
local tbl_upv_3 = {}
local u3 = 0
tbl_upv_1.NEAR = Quality_upv_1.nearRadius
Quality_upv_1.OnChanged(
    function()
        --[[
          line: 82
          upvalues:
            tbl_upv_1 (copy, index: 1)
            Quality_upv_1 (copy, index: 2)
        ]]
        tbl_upv_1.NEAR = Quality_upv_1.nearRadius
    end
)
local function restore(a1)
    --[[
      name: restore
      line: 107
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    local tbl_4 = {}
    for _, value_2 in tbl_upv_3[a1] or {} do
        tbl_4[value_2[1]] = value_2[2]
    end
    local v2 = a1:GetDescendants()
    table.insert(v2, a1)
    for _, value_3 in v2 do
        local v3 = tbl_4[value_3]
        if value_3:IsA("BasePart") then
            value_3.Anchored = true
            if type(v3) == "number" then
                value_3.Transparency = v3
            end
        else
            if not (value_3:IsA("ParticleEmitter")) or type(v3) ~= "table" then
                if not (value_3:IsA("Trail")) or type(v3) ~= "boolean" then
                    if not (value_3:IsA("Beam")) or type(v3) ~= "boolean" then
                        if not (value_3:IsA("PointLight")) and not (value_3:IsA("SpotLight")) and not (value_3:IsA("SurfaceLight")) or type(v3) ~= "number" then
                            if not (value_3:IsA("WeldConstraint")) then
                                continue
                            end
                            if value_3.Name == "StickWeld" then
                                value_3:Destroy()
                                continue
                            end
                        end
                        value_3.Brightness = v3
                        continue
                    end
                    value_3.Enabled = v3
                    continue
                end
                value_3.Enabled = v3
                value_3:Clear()
                continue
            end
            value_3.Enabled = v3[1]
            value_3.Color = v3[2]
            value_3.LightEmission = v3[3]
            value_3:Clear()
        end
    end
end
local function snapshot(a1)
    --[[
      name: snapshot
      line: 86
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    local v4 = a1:GetDescendants()
    table.insert(v4, a1)
    local tbl_5 = {}
    for _, value_4 in v4 do
        if value_4:IsA("BasePart") then
            table.insert(tbl_5, {value_4, value_4.Transparency})
            continue
        end
        if value_4:IsA("ParticleEmitter") then
            table.insert(tbl_5, {value_4, {value_4.Enabled, value_4.Color, value_4.LightEmission}})
            continue
        end
        if value_4:IsA("Trail") or value_4:IsA("Beam") then
            table.insert(tbl_5, {value_4, value_4.Enabled})
            continue
        end
        if value_4:IsA("PointLight") or value_4:IsA("SpotLight") or value_4:IsA("SurfaceLight") then
            table.insert(tbl_5, {value_4, value_4.Brightness})
        end
    end
    tbl_upv_3[a1] = tbl_5
    a1.Destroying:Connect(
        function()
            --[[
              line: 102
              upvalues:
                tbl_upv_3 (copy, index: 1)
                a1 (copy, index: 2)
            ]]
            tbl_upv_3[a1] = nil
        end
    )
end
local function release(a1)
    --[[
      name: release
      line: 152
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    if not a1 then
        return
    end
    if not (a1:GetAttribute("Released")) then
        local v5 = a1:GetAttribute("PoolKey")
        local v6
        if type(v5) ~= "string" then
            v6 = nil
        else
            v6 = tbl_upv_2[v5] or {}
        end
        if v6 and not (#v6 >= 12) then
            tbl_upv_2[v5] = v6
            a1.Parent = nil
            a1:SetAttribute("Released", true)
            table.insert(v6, a1)
        else
            a1:Destroy()
        end
    end
end
local u4 = setmetatable({}, {__mode = "k"})
tbl_upv_1.CamDistance = function(a1)
    --[[
      name: camDistance
      line: 190
    ]]
    local CurrentCamera_1 = workspace.CurrentCamera
    if CurrentCamera_1 then
        return (CurrentCamera_1.CFrame.Position - a1).Magnitude
    end
    return 0
end
local function flatPart(a1, a2, a3, a4, a5, a6)
    --[[
      name: flatPart
      line: 196
      upvalues:
        u2 (ref, index: 1)
    ]]
    local v7 = Instance.new("Part")
    v7.Name = a1
    v7.Anchored = true
    v7.CanCollide = false
    v7.CanQuery = false
    v7.CanTouch = false
    v7.CastShadow = false
    v7.Size = a2
    v7.CFrame = a3
    v7.Color = a4
    v7.Material = a5 or (Enum.Material.SmoothPlastic)
    v7.Transparency = a6 or 0
    local FX_2 = workspace:FindFirstChild("FX")
    if FX_2 then
        u2 = FX_2
    end
    v7.Parent = u2
    return v7
end
function tbl_upv_1.WeaponColor(a1)
    --[[
      name: WeaponColor
      line: 214
      upvalues:
        Weapons_upv_1 (copy, index: 1)
        Presentation_upv_1 (copy, index: 2)
    ]]
    local v8 = a1 and (a1:GetAttribute("WeaponId"))
    local v9 = Weapons_upv_1.Get(v8)
    local v10 = v9 and (Presentation_upv_1.Kind(v9.kind))
    local v11
    if v10 then
        v11 = v10.slashColor
        if not (v11) then
            v11 = v10.glow
            v11 = v11 or Color3.fromRGB(226, 170, 100)
        end
    else
        v11 = Color3.fromRGB(226, 170, 100)
    end
    return v11
end
tbl_upv_1.GroundAt = function(a1, a2)
    --[[
      name: groundAt
      line: 221
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local v12 = Util_upv_1.WorldParams(Util_upv_1.Targets())
    local v13 = workspace:Raycast(a1 + Vector3.new(0, 1.5, 0), Vector3.new(0, -(a2 + 1.5), 0), v12)
    if v13 then
        return v13.Position, v13.Normal
    end
    return nil, nil
end
local function groundDecal(a1, a2, a3, a4, a5, a6, a7, a8, a9)
    --[[
      name: groundDecal
      line: 232
      upvalues:
        Quality_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
        TweenService_upv_1 (copy, index: 3)
        Debris_upv_1 (copy, index: 4)
    ]]
    if not Quality_upv_1.decals then
        return
    end
    local Unit_1 = a2.Unit
    local Unit_2 = Unit_1:Cross(Vector3.new(0, 0, 1))
    if Unit_2.Magnitude < 0.1 then
        Unit_2 = Unit_1:Cross(Vector3.new(1, 0, 0))
    end
    Unit_2 = Unit_2.Unit
    local v14 = CFrame.fromMatrix(a1 + (Unit_1 * 0.06), Unit_2, Unit_1, -Unit_2:Cross(Unit_1).Unit)
    local v15 = Vector3.new(a5, 0.05, a5)
    local v16 = Instance.new("Part")
    v16.Name = "GroundFX"
    v16.Anchored = true
    v16.CanCollide = false
    v16.CanQuery = false
    v16.CanTouch = false
    v16.CastShadow = false
    v16.Size = v15
    v16.CFrame = v14
    v16.Color = a4
    v16.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
    v16.Transparency = 1
    local FX_3 = workspace:FindFirstChild("FX")
    if FX_3 then
        u2 = FX_3
    end
    v16.Parent = u2
    local v17 = Instance.new("SurfaceGui")
    v17.Face = Enum.NormalId.Top
    v17.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize
    v17.CanvasSize = Vector2.new(256, 256)
    v17.LightInfluence = 1
    v17.Parent = v16
    local u5 = Instance.new("ImageLabel")
    u5.Size = UDim2.fromScale(1, 1)
    u5.BackgroundTransparency = 1
    u5.Image = a3
    u5.ImageColor3 = a4
    u5.ImageTransparency = a8
    u5.Parent = v17
    local v18 = TweenInfo.new(a7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local tbl_6 = {}
    tbl_6.Size = Vector3.new(a6, 0.05, a6)
    TweenService_upv_1:Create(v16, v18, tbl_6):Play()
    task.delay(
        a9 or 0,
        function()
            --[[
              line: 259
              upvalues:
                TweenService_upv_1 (copy, index: 1)
                u5 (copy, index: 2)
                a9 (copy, index: 3)
                a7 (copy, index: 4)
            ]]
            local new_1 = TweenInfo.new
            local v19
            if a9 then
                v19 = 1.2
            else
                v19 = a7
            end
            TweenService_upv_1:Create(u5, new_1(v19, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageTransparency = 1}):Play()
        end
    )
    Debris_upv_1:AddItem(v16, ((a9 or 0) + a7) + 1.3)
end
local function template(a1)
    --[[
      name: template
      line: 50
      upvalues:
        u1 (copy, index: 1)
    ]]
    if u1 then
        for key_1 in string.gmatch(a1, "[^/]+") do
            local _ = u1 and (u1:FindFirstChild(key_1))
        end
        return u1
    end
    return nil
end
local function emitAll(a1, a2)
    --[[
      name: emitAll
      line: 265
      upvalues:
        Quality_upv_1 (copy, index: 1)
        TweenService_upv_1 (copy, index: 2)
    ]]
    local v20 = 0.5
    local v21 = a1:GetDescendants()
    table.insert(v21, a1)
    local u6
    for _, value_upv_5 in v21 do
        if value_upv_5:IsA("ParticleEmitter") then
            local v22 = value_upv_5:GetAttribute("EmitCount")
            if type(v22) ~= "number" then
                u6 = 12
            else
                u6 = v22
            end
            u6 = math.max(1, math.floor(((u6 * (a2 or 1)) * Quality_upv_1.particleScale) + 0.5))
            local v23 = value_upv_5:GetAttribute("EmitDelay")
            if type(v23) ~= "number" then
                value_upv_5:Emit(u6)
                v20 = math.max(v20, value_upv_5.Lifetime.Max)
                continue
            end
            if v23 > 0 then
                task.delay(
                    v23,
                    function()
                        --[[
                          line: 276
                          upvalues:
                            value_upv_5 (copy, index: 1)
                            u6 (ref,  index: 2)
                        ]]
                        if not value_upv_5.Parent then
                            return
                        end
                        value_upv_5:Emit(u6)
                    end
                )
                v20 = math.max(v20, v23 + value_upv_5.Lifetime.Max)
            else
                value_upv_5:Emit(u6)
                v20 = math.max(v20, value_upv_5.Lifetime.Max)
            end
        else
            if value_upv_5:IsA("PointLight") then
                value_upv_5.Enabled = true
                local tbl_7 = {Brightness = 0}
                TweenService_upv_1:Create(value_upv_5, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_7):Play()
                continue
            end
            local v24 = value_upv_5:IsA("SpotLight")
            if v24 then
                value_upv_5.Enabled = true
                local tbl_7 = {Brightness = 0}
                TweenService_upv_1:Create(value_upv_5, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_7):Play()
            end
        end
    end
    return v20
end
local function takeFromPool(a1, a2)
    --[[
      name: takeFromPool
      line: 137
      upvalues:
        tbl_upv_2 (copy, index: 1)
        restore (copy, index: 2)
        prep (copy, index: 3)
        snapshot (copy, index: 4)
    ]]
    local v25 = tbl_upv_2[a1]
    local v26 = v25 and (table.remove(v25))
    if v26 then
        restore(v26)
    else
        local v27 = a2:Clone()
        prep(v27)
        snapshot(v27)
        v27:SetAttribute("PoolKey", a1)
        v26 = v27
    end
    v26:SetAttribute("Released", nil)
    return v26
end
function tbl_upv_1.Burst(a1, a2, a3, a4, a5)
    --[[
      name: Burst
      line: 295
      upvalues:
        template (copy, index: 1)
        u3 (ref,  index: 2)
        Quality_upv_1 (copy, index: 3)
        takeFromPool (copy, index: 4)
        u2 (ref,  index: 5)
        emitAll (copy, index: 6)
        release (copy, index: 7)
    ]]
    local v28 = template(a1)
    if not v28 then
        return false
    end
    local v29 = nil
    if Quality_upv_1.maxBursts <= u3 then
        v29 = workspace.CurrentCamera
        if (((not v29) and 0) or ((v29.CFrame.Position - a2.Position).Magnitude)) > 40 then
            return true
        end
    end
    local u7 = takeFromPool(a1, v28)
    local v30 = nil
    if u7:IsA("BasePart") then
        u7.Transparency = 1
        u7.CFrame = a2
        v30 = workspace:FindFirstChild("FX")
        if v30 then
            u2 = v30
        end
        u7.Parent = u2
    elseif u7:IsA("Model") then
        u7:PivotTo(a2)
        v29 = workspace:FindFirstChild("FX")
        if v29 then
            u2 = v29
        end
        u7.Parent = u2
    elseif u7:IsA("Attachment") then
        u7.Parent = workspace.Terrain
        u7.WorldCFrame = a2
    else
        u7:Destroy()
        return false
    end
    if a4 then
        for _, value_6 in u7:GetDescendants() do
            if value_6:IsA("ParticleEmitter") and (value_6:GetAttribute("Tint") or a5) then
                value_6.Color = ColorSequence.new(a4)
                value_6.LightEmission = math.min(value_6.LightEmission, 0.35)
            end
        end
    end
    local v31 = emitAll(u7, a3)
    u3 = u3 + 1
    task.delay(
        v31 + 0.3,
        function()
            --[[
              line: 328
              upvalues:
                u3 (ref,  index: 1)
                release (copy, index: 2)
                u7 (copy, index: 3)
            ]]
            u3 = u3 - 1
            release(u7)
        end
    )
    return true
end
local function anchorPart(a1, a2)
    --[[
      name: anchorPart
      line: 336
      upvalues:
        u2 (ref, index: 1)
    ]]
    local v32 = CFrame.new(a1)
    local v33 = Color3.new()
    local v34 = Instance.new("Part")
    v34.Name = "PuffFX"
    v34.Anchored = true
    v34.CanCollide = false
    v34.CanQuery = false
    v34.CanTouch = false
    v34.CastShadow = false
    v34.Size = a2
    v34.CFrame = v32
    v34.Color = v33
    v34.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
    v34.Transparency = 1
    local FX_4 = workspace:FindFirstChild("FX")
    if FX_4 then
        u2 = FX_4
    end
    v34.Parent = u2
    return v34
end
function tbl_upv_1.Puff(a1, a2, a3, a4, a5, a6, a7)
    --[[
      name: Puff
      line: 340
      upvalues:
        u2 (ref,  index: 1)
        Quality_upv_1 (copy, index: 2)
        Debris_upv_1 (copy, index: 3)
    ]]
    local v35 = CFrame.new(a1)
    local v36 = Color3.new()
    local v37 = Instance.new("Part")
    v37.Name = "PuffFX"
    v37.Anchored = true
    v37.CanCollide = false
    v37.CanQuery = false
    v37.CanTouch = false
    v37.CastShadow = false
    v37.Size = Vector3.new(1, 1, 1)
    v37.CFrame = v35
    v37.Color = v36
    v37.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
    v37.Transparency = 1
    local FX_5 = workspace:FindFirstChild("FX")
    if FX_5 then
        u2 = FX_5
    end
    v37.Parent = u2
    if a7 then
        v37.CFrame = CFrame.lookAt(a1, a1 + a7)
    end
    local v38 = Instance.new("ParticleEmitter")
    v38.Texture = "rbxasset://textures/particles/smoke_main.dds"
    v38.Color = ColorSequence.new(a2)
    v38.LightEmission = 0
    v38.LightInfluence = 1
    v38.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, a4 * 0.5), NumberSequenceKeypoint.new(1, a4 * 1.6)})
    v38.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(0.6, 0.55), NumberSequenceKeypoint.new(1, 1)})
    v38.Lifetime = NumberRange.new(a6 * 0.7, a6)
    v38.Speed = NumberRange.new(a5 * 0.4, a5)
    local v39
    if a7 then
        v39 = Vector2.new(22, 22)
    else
        v39 = Vector2.new(180, 180)
    end
    v38.SpreadAngle = v39
    v38.EmissionDirection = Enum.NormalId.Front
    v38.Rotation = NumberRange.new(0, 360)
    v38.RotSpeed = NumberRange.new(-40, 40)
    v38.Drag = 3
    v38.Acceleration = Vector3.new(0, 1.5, 0)
    v38.Rate = 0
    v38.Parent = v37
    v38:Emit((math.max(1, math.floor((a3 * Quality_upv_1.particleScale) + 0.5))))
    Debris_upv_1:AddItem(v37, a6 + 0.3)
end
function tbl_upv_1.HitFlash(a1, a2)
    --[[
      name: HitFlash
      line: 372
      upvalues:
        Quality_upv_1 (copy, index: 1)
        TweenService_upv_1 (copy, index: 2)
    ]]
    if not a1 or not a1:IsA("Model") then
        return
    end
    if Quality_upv_1.highlights then
        local u8 = a1:FindFirstChild("CombatHitFlash")
        if not (u8) then
            local v40 = Instance.new("Highlight")
            v40.Name = "CombatHitFlash"
            v40.DepthMode = Enum.HighlightDepthMode.Occluded
            v40.Adornee = a1
            v40.Parent = a1
            u8 = v40
        end
        u8.FillColor = a2 or Color3.fromRGB(255, 70, 60)
        u8.OutlineColor = a2 or Color3.fromRGB(255, 70, 60)
        u8.FillTransparency = 1
        u8.OutlineTransparency = 0.05
        local tbl_8 = {OutlineTransparency = 1}
        TweenService_upv_1:Create(u8, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_8):Play()
        local u9 = (u8:GetAttribute("Tok") or 0) + 1
        u8:SetAttribute("Tok", u9)
        task.delay(
            0.3,
            function()
                --[[
                  line: 394
                  upvalues:
                    u8 (copy, index: 1)
                    u9 (copy, index: 2)
                ]]
                if not u8.Parent or u8:GetAttribute("Tok") ~= u9 then
                    return
                end
                u8:Destroy()
            end
        )
    end
end
local tbl_upv_9 = {}
function tbl_upv_1.PredictHit(a1, a2, a3, a4, a5, a6)
    --[[
      name: PredictHit
      line: 411
      upvalues:
        Util_upv_1 (copy, index: 1)
        tbl_upv_9 (copy, index: 2)
    ]]
    if not Util_upv_1.CanPredictHit(a1) then
        return
    end
    tbl_upv_9[a1] = os.clock()
    if a2 then
        Util_upv_1.Sound(a2, a3)
    end
end
function tbl_upv_1.ConsumePrediction(a1)
    --[[
      name: ConsumePrediction
      line: 421
      upvalues:
        tbl_upv_9 (copy, index: 1)
    ]]
    if not a1 then
        return false
    end
    local v43 = tbl_upv_9[a1]
    tbl_upv_9[a1] = nil
    local v44 = (v43 ~= nil) and (os.clock() - v43 < 0.8)
    return v44
end
task.spawn(
    function()
        --[[
          line: 430
          upvalues:
            tbl_upv_9 (copy, index: 1)
        ]]
        task.wait(5)
        local v45 = os.clock()
        for key_2, value_7 in tbl_upv_9 do
            if v45 - value_7 > 2 then
                tbl_upv_9[key_2] = nil
            end
        end
    end
)
local tbl_upv_10 = {Grass = "Impact_Dust", Sand = "Impact_Dust", Foil = "Impact_Sparks", Salt = "Impact_Dust", Wood = "Impact_Wood", Metal = "Impact_Sparks", DiamondPlate = "Impact_Sparks", WoodPlanks = "Impact_Wood", CorrodedMetal = "Impact_Sparks", Mud = "Impact_Dust", LeafyGrass = "Impact_Dust", Ground = "Impact_Dust", Snow = "Impact_Dust"}
local tbl_upv_11 = {Impact_Dust = "Impact_Dirt", Impact_Stone = "Impact_Stone", Impact_Wood = "Impact_Wood", Impact_Sparks = "Impact_Metal"}
function tbl_upv_1.Impact(a1, a2, a3, a4, a5)
    --[[
      name: Impact
      line: 466
      upvalues:
        tbl_upv_10 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        Util_upv_1 (copy, index: 3)
        tbl_upv_11 (copy, index: 4)
    ]]
    local v46 = tbl_upv_10[a3 or ""] or "Impact_Stone"
    local v47 = CFrame.lookAt(a1, a1 + (a2 or Vector3.new(0, 1, 0)))
    if not (tbl_upv_1.Burst(v46, v47, a5)) then
        tbl_upv_1.Burst("Impact_Stone", v47, a5)
    end
    if a4 == false then
        return
    end
    Util_upv_1.Sound(tbl_upv_11[v46] or "Impact_Stone", a1)
end
local tbl_upv_12 = {}
tbl_upv_12.health = Color3.fromRGB(235, 110, 50)
tbl_upv_12.headshot = Color3.fromRGB(245, 190, 40)
tbl_upv_12.blocked = Color3.fromRGB(120, 190, 245)
function tbl_upv_1.ArmorHit(a1, a2)
    --[[
      name: ArmorHit
      line: 486
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    local CurrentCamera_2 = workspace.CurrentCamera
    if tbl_upv_1.NEAR < (((not CurrentCamera_2) and 0) or ((CurrentCamera_2.CFrame.Position - a1).Magnitude)) then
        return
    end
    local Burst_1 = tbl_upv_1.Burst
    local v48 = CFrame.new(a1)
    Burst_1("Block_Spark", v48, (a2 and 1.2) or 0.7, Color3.fromRGB(205, 210, 220), true)
    local Sound_1 = Util_upv_1.Sound
    local v49 = (a2 and "Shield_Break") or "Impact_Metal"
    local tbl_13 = {Volume = 0}
    tbl_13.Volume = (a2 and 0.9) or 0.5
    Sound_1(v49, a1, tbl_13)
end
function tbl_upv_1.CharacterImpact(a1, a2, a3, a4)
    --[[
      name: CharacterImpact
      line: 494
      upvalues:
        tbl_upv_12 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local v50 = CFrame.lookAt(a1, a1 - (a2 or Vector3.new(0, 0, 1)))
    local v51 = a4
    local v52 = v51 and (tbl_upv_12[a4])
    tbl_upv_1.Burst("Impact_Hit", v50, (a3 and 1.6) or ((a4 and 1.15) or 0.7), a4, v52 ~= nil)
    if a4 ~= "headshot" then
        return
    end
    tbl_upv_1.CritStar(a1)
end
function tbl_upv_1.CritStar(a1)
    --[[
      name: CritStar
      line: 505
      upvalues:
        template (copy, index: 1)
        prep (copy, index: 2)
        u2 (ref,  index: 3)
        RunService_upv_1 (copy, index: 4)
    ]]
    local v53 = template("CritStar")
    if not v53 then
        return
    end
    local u10 = v53:Clone()
    prep(u10)
    u10:ScaleTo(0.25)
    u10:PivotTo(CFrame.lookAt(a1 + Vector3.new(0, 1.2000000476837158, 0), workspace.CurrentCamera.CFrame.Position))
    local FX_6 = workspace:FindFirstChild("FX")
    if FX_6 then
        u2 = FX_6
    end
    u10.Parent = u2
    local u11 = os.clock()
    local u12 = nil
    local v54 = RunService_upv_1.RenderStepped:Connect(
        function()
            --[[
              line: 517
              upvalues:
                u11 (copy, index: 1)
                u10 (copy, index: 2)
                u12 (ref,  index: 3)
                a1 (copy, index: 4)
            ]]
            local v55 = (os.clock() - u11) / 0.45
            if not (v55 >= 1) and u10.Parent then
                u10:ScaleTo((math.max(0.05, ((v55 < 0.3) and (0.25 + 0.65 * (v55 / 0.3))) or (0.9 - 0.2 * (v55 - 0.3)))))
                u10:PivotTo(CFrame.lookAt(a1 + Vector3.new(0, 1.2 + (v55 * 1.2), 0), workspace.CurrentCamera.CFrame.Position) * CFrame.Angles(0, 0, v55 * 2))
                for _, value_8 in u10:GetDescendants() do
                    if value_8:IsA("BasePart") then
                        value_8.Transparency = math.clamp((v55 - 0.55) / 0.45, 0, 1)
                    end
                end
            else
                u12:Disconnect()
                u10:Destroy()
            end
        end
    )
    u12 = v54
end
function tbl_upv_1.Trail(a1, a2)
    --[[
      name: Trail
      line: 537
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    if not a1 then
        return
    end
    local v56 = tbl_upv_1.WeaponColor(a1)
    for _, value_upv_9 in Util_upv_1.Drawn(a1):GetDescendants() do
        if value_upv_9:IsA("Trail") then
            value_upv_9.Lifetime = 0.18
            value_upv_9.LightEmission = 0.25
            value_upv_9.LightInfluence = 0.5
            value_upv_9.Color = ColorSequence.new(v56)
            value_upv_9.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(1, 1)})
            value_upv_9.WidthScale = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)})
            value_upv_9.Enabled = true
            local u13 = (value_upv_9:GetAttribute("Tok") or 0) + 1
            value_upv_9:SetAttribute("Tok", u13)
            task.delay(
                a2,
                function()
                    --[[
                      line: 554
                      upvalues:
                        value_upv_9 (copy, index: 1)
                        u13 (copy, index: 2)
                    ]]
                    if value_upv_9:GetAttribute("Tok") ~= u13 then
                        return
                    end
                    value_upv_9.Enabled = false
                end
            )
        end
    end
end
local u14 = nil
function tbl_upv_1.DashLines(a1)
    --[[
      name: DashLines
      line: 568
      upvalues:
        Players_upv_1 (copy, index: 1)
        u14 (ref,  index: 2)
        TweenService_upv_1 (copy, index: 3)
    ]]
    local v57 = Players_upv_1.LocalPlayer
    local v58 = v57 and (v57:FindFirstChildOfClass("PlayerGui"))
    if not v58 then
        return
    end
    v57 = u14
    if not (v57) or v57.Parent ~= v58 then
        local v59 = Instance.new("ScreenGui")
        v59.Name = "TribesDashLines"
        v59.IgnoreGuiInset = true
        v59.ResetOnSpawn = false
        v59.DisplayOrder = 3
        v59.Parent = v57
        u14 = v59
        v57 = v59
    end
    local v60 = Random.new()
    local v61 = TweenInfo.new(a1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    for n_1 = 1, 16 do
        local v62 = ((n_1 / 16) * math.pi) * 2 + v60:NextNumber(-0.12, 0.12)
        local v63 = Vector2.new(math.cos(v62), math.sin(v62))
        local v64 = v60:NextNumber(0.36, 0.44)
        local u15 = Instance.new("Frame")
        u15.Name = "Line"
        u15.AnchorPoint = Vector2.new(0.5, 0.5)
        u15.BorderSizePixel = 0
        u15.BackgroundColor3 = Color3.fromRGB(236, 240, 248)
        u15.BackgroundTransparency = 0.76
        u15.Size = UDim2.new(v60:NextNumber(0.07, 0.13), 0, 0, 2)
        u15.Rotation = math.deg(v62)
        u15.Position = UDim2.fromScale(0.5 + (v63.X * v64), 0.5 + (v63.Y * v64))
        u15.Parent = v57
        local v65 = v64 + v60:NextNumber(0.12, 0.2)
        local tbl_14 = {BackgroundTransparency = 1}
        tbl_14.Position = UDim2.fromScale(0.5 + (v63.X * v65), 0.5 + (v63.Y * v65))
        TweenService_upv_1:Create(u15, v61, tbl_14):Play()
        task.delay(
            a1 + 0.05,
            function()
                --[[
                  line: 603
                  upvalues:
                    u15 (copy, index: 1)
                ]]
                u15:Destroy()
            end
        )
    end
end
function tbl_upv_1.Slash(a1, a2, a3, a4, a5)
    --[[
      name: Slash
      line: 609
      upvalues:
        Util_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
        Quality_upv_1 (copy, index: 3)
        RunService_upv_1 (copy, index: 4)
    ]]
    if not a1 then
        return
    end
    local v66 = Util_upv_1.Drawn(a1:FindFirstChild("HumanoidRootPart"))
    if not v66 then
        return
    end
    local v67 = a4 or (Color3.fromRGB(226, 170, 100))
    local v68 = (a3 and 90) or (({-32, 212, 38, 148})[((a2 - 1) % 4) + 1])
    local u16 = ((a2 % 2 ~= 0) and 1) or -1
    local v69 = math.clamp((a5 or 9) * 0.42, 3, 5.5)
    local u17 = v69 * ((a3 and 1.2) or 1)
    local v70 = v66.CFrame * CFrame.new(0, 0.6, -0.6)
    local v71 = v70 * CFrame.Angles(math.rad((a3 and 0) or 22), 0, 0) * CFrame.Angles(0, 0, math.rad(v68))
    local u18 = math.rad((a3 and 150) or 130)
    local u19 = -u16 * u18 / 2
    local u20 = Instance.new("Part")
    u20.Name = "SlashArc"
    u20.Anchored = true
    u20.CanCollide = false
    u20.CanQuery = false
    u20.CanTouch = false
    u20.CastShadow = false
    u20.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    u20.CFrame = v71
    u20.Color = v67
    u20.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
    u20.Transparency = 1
    local FX_7 = workspace:FindFirstChild("FX")
    if FX_7 then
        u2 = FX_7
    end
    u20.Parent = u2
    local u21 = Instance.new("Attachment")
    u21.Parent = u20
    local u22 = Instance.new("Attachment")
    u22.Parent = u20
    local function place(a6, a7)
        --[[
          name: place
          line: 629
          upvalues:
            u17 (copy, index: 1)
            u16 (copy, index: 2)
        ]]
        a6.CFrame = CFrame.fromMatrix(Vector3.new(-u17 * math.sin(a7), 0, -u17 * math.cos(a7)), Vector3.new(-math.cos(a7), 0, math.sin(a7)) * u16, Vector3.new(0, 1, 0))
    end
    local u23 = (a3 and 1.35) or 1
    local function beam(a8, a9, a10, a11)
        --[[
          name: beam
          line: 635
          upvalues:
            u21 (copy, index: 1)
            u22 (copy, index: 2)
            u20 (copy, index: 3)
        ]]
        local v72 = Instance.new("Beam")
        v72.Attachment0 = u21
        v72.Attachment1 = u22
        v72.FaceCamera = true
        v72.Segments = 24
        v72.LightEmission = 0.25
        v72.LightInfluence = 0.35
        v72.Width0 = a8 * 0.15
        v72.Width1 = a8
        v72.Color = a9
        v72.Transparency = a10
        if a11 then
            v72.Texture = a11
            v72.TextureMode = Enum.TextureMode.Stretch
        end
        v72.Parent = u20
        return v72
    end
    local v73 = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.55, 0.55), NumberSequenceKeypoint.new(0.92, 0.05), NumberSequenceKeypoint.new(1, 0.15)})
    local v74 = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.6, 0.65), NumberSequenceKeypoint.new(1, 0.35)})
    local v75 = u23 * 0.9
    local v76 = ColorSequence.new(v67, v67:Lerp(Color3.new(1, 1, 1), 0.15))
    local u24 = Instance.new("Beam")
    u24.Attachment0 = u21
    u24.Attachment1 = u22
    u24.FaceCamera = true
    u24.Segments = 24
    u24.LightEmission = 0.25
    u24.LightInfluence = 0.35
    u24.Width0 = v75 * 0.15
    u24.Width1 = v75
    u24.Color = v76
    u24.Transparency = v73
    u24.Parent = u20
    local v77 = u23 * 2.8
    local v78 = ColorSequence.new(v67)
    local u25 = Instance.new("Beam")
    u25.Attachment0 = u21
    u25.Attachment1 = u22
    u25.FaceCamera = true
    u25.Segments = 24
    u25.LightEmission = 0.25
    u25.LightInfluence = 0.35
    u25.Width0 = v77 * 0.15
    u25.Width1 = v77
    u25.Color = v78
    u25.Transparency = v74
    u25.Texture = "rbxassetid://10525777446"
    u25.TextureMode = Enum.TextureMode.Stretch
    u25.Parent = u20
    local v79 = u23 * 1.6
    local v80 = ColorSequence.new(v67)
    local u26 = Instance.new("Beam")
    u26.Attachment0 = u21
    u26.Attachment1 = u22
    u26.FaceCamera = true
    u26.Segments = 24
    u26.LightEmission = 0.25
    u26.LightInfluence = 0.35
    u26.Width0 = v79 * 0.15
    u26.Width1 = v79
    u26.Color = v80
    u26.Transparency = v74
    u26.Parent = u20
    if not (Quality_upv_1.layers) then
        u26.Enabled = false
    end
    local u27 = (a3 and 0.16) or 0.12
    local u28 = u18 * 0.8
    local u29 = os.clock()
    u21.CFrame = CFrame.fromMatrix(Vector3.new(-u17 * math.sin(u19), 0, -u17 * math.cos(u19)), Vector3.new(-math.cos(u19), 0, math.sin(u19)) * u16, Vector3.new(0, 1, 0))
    u22.CFrame = CFrame.fromMatrix(Vector3.new(-u17 * math.sin(u19), 0, -u17 * math.cos(u19)), Vector3.new(-math.cos(u19), 0, math.sin(u19)) * u16, Vector3.new(0, 1, 0))
    local function update()
        --[[
          name: update
          line: 674
          upvalues:
            u29 (copy, index: 1)
            u27 (copy, index: 2)
            u19 (copy, index: 3)
            u16 (copy, index: 4)
            u18 (copy, index: 5)
            u28 (copy, index: 6)
            u21 (copy, index: 7)
            u17 (copy, index: 8)
            u22 (copy, index: 9)
            u24 (copy, index: 10)
            u25 (copy, index: 11)
            u26 (copy, index: 12)
            u23 (copy, index: 13)
        ]]
        local v81 = os.clock() - u29
        local v82 = math.min(1, v81 / u27)
        local v83 = 1 - (1 - v82) ^ 2
        local v84 = u19 + (u16 * u18) * v83
        local v85 = math.clamp((v81 - u27) / 0.14, 0, 1)
        local v86 = u19 + u16 * math.max(0, (u18 * v83) - (u28 * (1 - v85)))
        v81 = math.abs(v84 - v86)
        if v85 >= 1 or v81 < 0.02 and v82 >= 1 then
            return false
        end
        u21.CFrame = CFrame.fromMatrix(Vector3.new(-u17 * math.sin(v86), 0, -u17 * math.cos(v86)), Vector3.new(-math.cos(v86), 0, math.sin(v86)) * u16, Vector3.new(0, 1, 0))
        u22.CFrame = CFrame.fromMatrix(Vector3.new(-u17 * math.sin(v84), 0, -u17 * math.cos(v84)), Vector3.new(-math.cos(v84), 0, math.sin(v84)) * u16, Vector3.new(0, 1, 0))
        v84 = math.tan(v81 / 4) * 1.3333333333333333 * u17
        u24.CurveSize0 = v84
        u24.CurveSize1 = v84
        u25.CurveSize0 = v84
        u25.CurveSize1 = v84
        u26.CurveSize0 = v84
        u26.CurveSize1 = v84
        u24.Width1 = (u23 * 0.9) * (1 - (v85 * 0.6))
        u25.Width1 = (u23 * 2.8) * (1 - (v85 * 0.4))
        u26.Width1 = (u23 * 1.6) * (1 - (v85 * 0.5))
        return true
    end
    update()
    local u30 = nil
    local v87 = RunService_upv_1.RenderStepped:Connect(
        function()
            --[[
              line: 701
              upvalues:
                u20 (copy, index: 1)
                update (copy, index: 2)
                u30 (ref,  index: 3)
            ]]
            if (u20.Parent) and (update()) then
                return
            end
            u30:Disconnect()
            u20:Destroy()
        end
    )
    u30 = v87
end
function tbl_upv_1.GroundScuff(a1)
    --[[
      name: GroundScuff
      line: 709
      upvalues:
        Util_upv_1 (copy, index: 1)
        groundDecal (copy, index: 2)
    ]]
    local v88 = workspace:Raycast((a1 + Vector3.new(0, 2, 0)) + Vector3.new(0, 1.5, 0), Vector3.new(0, -7.5, 0), Util_upv_1.WorldParams(Util_upv_1.Targets()))
    local v89, v90
    if v88 then
        v89 = v88.Position
        v90 = v88.Normal
    else
        v89, v90 = nil, nil
    end
    if not v89 or not v90 then
        return
    end
    groundDecal(v89, v90, "rbxassetid://10430755572", Color3.fromRGB(70, 55, 40), 3, 4.2, 0.15, 0.35, 1.2)
    groundDecal(v89, v90, "rbxassetid://10871117278", Color3.fromRGB(190, 165, 130), 1.5, 8, 0.25, 0.35)
end
function tbl_upv_1.Muzzle(a1, a2, a3, a4)
    --[[
      name: Muzzle
      line: 720
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
        TweenService_upv_1 (copy, index: 3)
        Debris_upv_1 (copy, index: 4)
    ]]
    local CurrentCamera_3 = workspace.CurrentCamera
    local v91 = tbl_upv_1.NEAR < (((not CurrentCamera_3) and 0) or ((CurrentCamera_3.CFrame.Position - a1.Position).Magnitude))
    local v92 = (a2 and 1.4) or 1
    if not (v91) then
        local v93 = nil
        if not (a4) then
            local v94 = a1 * CFrame.new(0, 0, v92 * -0.7)
            local v95 = Color3.fromRGB(255, 170, 70)
            local v96 = Instance.new("Part")
            v96.Name = "MuzzleFlash"
            v96.Anchored = true
            v96.CanCollide = false
            v96.CanQuery = false
            v96.CanTouch = false
            v96.CastShadow = false
            v96.Size = Vector3.new(0.5, 0.5, 1.399999976158142) * v92
            v96.CFrame = v94
            v96.Color = v95
            v96.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
            v96.Transparency = 0.2
            v93 = workspace:FindFirstChild("FX")
            if v93 then
                u2 = v93
            end
            v96.Parent = u2
            local v97 = Instance.new("SpecialMesh")
            v97.MeshType = Enum.MeshType.Sphere
            v97.Parent = v96
            local v98 = Instance.new("PointLight")
            v98.Color = Color3.fromRGB(255, 160, 80)
            v98.Brightness = 1
            v98.Range = v92 * 10
            v98.Shadows = false
            v98.Parent = v96
            local tbl_15 = {Transparency = 1}
            tbl_15.Size = Vector3.new(0.8999999761581421, 0.8999999761581421, 2.200000047683716) * v92
            TweenService_upv_1:Create(v96, TweenInfo.new(0.07), tbl_15):Play()
            local tbl_16 = {Brightness = 0}
            TweenService_upv_1:Create(v98, TweenInfo.new(0.09), tbl_16):Play()
            Debris_upv_1:AddItem(v96, 0.12)
            tbl_upv_1.Puff(a1.Position, Color3.fromRGB(255, 190, 110), 5, v92 * 0.35, 18, 0.12, a1.LookVector)
        end
    end
    if a3 ~= false then
        local Puff_1 = tbl_upv_1.Puff
        local Position_1 = a1.Position
        local v99 = Color3.fromRGB(196, 192, 184)
        Puff_1(Position_1, v99, (v91 and 4) or 9, v92 * 1.1, 7, 1.7, a1.LookVector)
        local Puff_2 = tbl_upv_1.Puff
        local Position_2 = a1.Position
        local v100 = Color3.fromRGB(170, 166, 160)
        Puff_2(Position_2, v100, (v91 and 2) or 5, v92 * 1.5, 1.5, 2.4)
    end
end
local tbl_upv_17 = {FireBolt = true, Harpoon = true, Arrow = true, Knife = true, FireArrow = true, Javelin = true, Bolt = true}
local tbl_upv_18 = {}
tbl_upv_18.Arrow = {"Arrow_Flesh", "Arrow_Thunk"}
tbl_upv_18.Bolt = {"Arrow_Flesh", "Arrow_Thunk"}
tbl_upv_18.Ball = {"Hit_Melee_Heavy", "Impact_Dirt"}
tbl_upv_18.Pellet = {"Hit_Melee", "Impact_Dirt"}
tbl_upv_18.Knife = {"Knife_Hit", "Knife_Thunk"}
tbl_upv_18.Javelin = {"Spear_Hit", "Javelin_Hit"}
tbl_upv_18.Stone = {"Stone_Hit", "Impact_Stone"}
tbl_upv_18.FireArrow = {"Arrow_Flesh", "Arrow_Thunk"}
tbl_upv_18.FireBolt = {"Arrow_Flesh", "Arrow_Thunk"}
tbl_upv_18.Bolas = {"Stone_Hit", "Impact_Stone"}
tbl_upv_18.Harpoon = {"Harpoon_Hit", "Harpoon_Thunk"}
tbl_upv_18.Hatchet = {"Hatchet_Hit", "Hatchet_Thunk"}
local tbl_upv_19 = {Stone = 10, Bolas = 16, FireBomb = 6, Beehive = 5, Chakram = 30, Hatchet = 20, Knife = 24, SmokeBomb = 6, Flask = 6, Caltrops = 7}
local tbl_upv_20 = {Chakram = true, Bolas = true}
local tbl_upv_21 = {}
local tbl_upv_22 = {Stone = 5, Harpoon = 7, FireBolt = 5, Arrow = 6, FireArrow = 6, Bolas = 4, Bolt = 5, FireBomb = 3.6, Beehive = 3.6, Hatchet = 4.5, Chakram = 4, Javelin = 7, Knife = 4, SmokeBomb = 3.6, Flask = 3.6, Caltrops = 3.6}
local _ = {Knife = 0.1}
local u31 = nil
local u32 = nil
function tbl_upv_1.SetViewHandOff(a1, a2)
    --[[
      name: SetViewHandOff
      line: 809
      upvalues:
        u31 (ref, index: 1)
        u32 (ref, index: 2)
    ]]
    u31 = a1
    u32 = a2
end
local function setModelCFrame(a1, a2)
    --[[
      name: setModelCFrame
      line: 813
    ]]
    if a1:IsA("Model") then
        a1:PivotTo(a2)
    elseif a1:IsA("BasePart") then
        a1.CFrame = a2
    end
end
local function lowDetail(a1)
    --[[
      name: lowDetail
      line: 834
    ]]
    for _, value_10 in a1:GetDescendants() do
        if value_10:IsA("ParticleEmitter") or value_10:IsA("Trail") or value_10:IsA("Beam") or value_10:IsA("PointLight") then
            value_10.Enabled = false
        end
    end
end
function tbl_upv_1.MyKey(a1)
    --[[
      name: MyKey
      line: 854
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    return (("p%*:%*"):format(LocalPlayer_upv_1.UserId, a1))
end
local tbl_upv_23 = {}
local tbl_upv_24 = {}
task.spawn(
    function()
        --[[
          line: 901
          upvalues:
            tbl_upv_23 (copy, index: 1)
        ]]
        task.wait(3)
        local v101 = os.clock()
        for key_3, value_11 in tbl_upv_23 do
            if v101 - value_11.t > 2 then
                tbl_upv_23[key_3] = nil
            end
        end
    end
)
local u33 = 0
local tbl_upv_25 = {}
local u34 = 0
local function dropLine(a1, a2)
    --[[
      name: dropLine
      line: 931
      upvalues:
        tbl_upv_25 (copy, index: 1)
    ]]
    local v102 = tbl_upv_25[a1]
    if not v102 then
        return
    end
    local _ = v102.token
    task.delay(a2, function() end)
end
local u35 = nil
local u36 = nil
local function viewLineHand()
    --[[
      name: viewLineHand
      line: 956
      upvalues:
        u35 (ref,  index: 1)
        u36 (ref,  index: 2)
        RunService_upv_1 (copy, index: 3)
    ]]
    local CurrentCamera_4 = workspace.CurrentCamera
    if not CurrentCamera_4 then
        return nil
    end
    local v103 = u35
    if not (v103) or not (v103.Parent) then
        local v104 = Instance.new("Part")
        v104.Name = "TribesViewLineAnchor"
        v104.Anchored = true
        v104.CanCollide = false
        v104.CanQuery = false
        v104.CanTouch = false
        v104.CastShadow = false
        v104.Transparency = 1
        v104.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
        v104.Parent = CurrentCamera_4
        u35 = v104
        v103 = v104
    end
    if not (u36) then
        local v105 = RunService_upv_1.RenderStepped:Connect(
            function()
                --[[
                  line: 977
                  upvalues:
                    u35 (ref, index: 1)
                ]]
                local CurrentCamera_5 = workspace.CurrentCamera
                if not u35 or not CurrentCamera_5 then
                    return
                end
                u35.CFrame = CurrentCamera_5.CFrame * CFrame.new(0.3, -0.36, -0.7)
            end
        )
        u36 = v105
    end
    return v103
end
local function addLine(a1, a2, a3)
    --[[
      name: addLine
      line: 988
      upvalues:
        Util_upv_1 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        viewLineHand (copy, index: 3)
        tbl_upv_25 (copy, index: 4)
        u34 (ref,  index: 5)
    ]]
    if not a3 then
        return
    end
    local v106 = Util_upv_1.Drawn(a3)
    local v107
    if (v106) and (v106:IsA("Model")) then
        v107 = v106
    else
        v107 = a3
    end
    v106 = v107:FindFirstChild("RightHand") or (a3:FindFirstChild("RightHand"))
    if a3 == LocalPlayer_upv_1.Character then
        local v108 = Util_upv_1.InFirstPerson()
        if v108 then
            v106 = viewLineHand() or v106
        end
    end
    if a2:IsA("Model") then
        v107 = a2.PrimaryPart
    elseif a2:IsA("BasePart") then
        v107 = a2
    else
        v107 = nil
    end
    if not v106 then
        return
    end
    if v106:IsA("BasePart") and v107 then
        local v109 = tbl_upv_25[a1]
        if v109 then
            v109.beam:Destroy()
            v109.a0:Destroy()
            v109.a1:Destroy()
        end
        local v110 = Instance.new("Attachment")
        v110.Name = "HarpoonLineHand"
        v110.Parent = v106
        local v111 = Instance.new("Attachment")
        v111.Name = "HarpoonLineEnd"
        v111.Position = Vector3.new(0, 0, 4.599999904632568)
        v111.Parent = v107
        local v112 = Instance.new("Beam")
        v112.Name = "HarpoonLine"
        v112.Attachment0 = v110
        v112.Attachment1 = v111
        v112.FaceCamera = true
        v112.Width0 = 0.14
        v112.Width1 = 0.14
        v112.Segments = 1
        v112.Color = ColorSequence.new(Color3.fromRGB(196, 164, 112))
        v112.Transparency = NumberSequence.new(0)
        v112.LightEmission = 0
        v112.LightInfluence = 1
        v112.Parent = v107
        u34 = u34 + 1
        v107 = {}
        v107.a0 = v110
        v107.a1 = v111
        v107.beam = v112
        v107.token = u34
        tbl_upv_25[a1] = v107
        local v113 = tbl_upv_25[a1]
        if v113 then
            local _ = v113.token
            task.delay(3, function() end)
        end
        tbl_upv_25[a1] = v107
    end
end
tbl_upv_1.ParamsOverride = nil
local function fallbackModel(a1)
    --[[
      name: fallbackModel
      line: 915
      upvalues:
        prep (copy, index: 1)
    ]]
    local v114 = Instance.new("Part")
    local v115
    if a1 ~= "Ball" and a1 ~= "Pellet" and a1 ~= "Stone" then
        v115 = Vector3.new(0.20000000298023224, 0.20000000298023224, 2)
    else
        v115 = Vector3.new(0.30000001192092896, 0.30000001192092896, 0.30000001192092896)
    end
    v114.Size = v115
    v114.Material = Enum.Material.SmoothPlastic
    v114.Color = Color3.fromRGB(90, 85, 80)
    prep(v114)
    return v114
end
local function paramsFor(a1)
    --[[
      name: paramsFor
      line: 860
      upvalues:
        tbl_upv_24 (copy, index: 1)
        tbl_upv_23 (copy, index: 2)
        Util_upv_1 (copy, index: 3)
        LocalPlayer_upv_1 (copy, index: 4)
    ]]
    local v116 = a1 or tbl_upv_24
    local v117 = tbl_upv_23[v116]
    local v118 = os.clock()
    if v117 and v118 - v117.t < 1 then
        return v117.p
    end
    local tbl_26 = {}
    local v119 = nil
    if a1 then
        table.insert(tbl_26, a1)
        v119 = a1:GetAttribute("MatchId")
        local v120 = a1:GetAttribute("Team")
        if type(v119) == "string" then
            local v121 = nil
            if v119 ~= "" then
                for _, value_12 in Util_upv_1.Targets() do
                    if value_12:GetAttribute("MatchId") ~= v119 then
                        continue
                    end
                    if value_12:GetAttribute("Team") == v120 then
                        table.insert(tbl_26, value_12)
                    end
                end
                v121 = LocalPlayer_upv_1.Character
                if v121 and a1 ~= v121 and v121:GetAttribute("MatchId") == v119 and v121:GetAttribute("Team") == v120 then
                    table.insert(tbl_26, v121)
                end
            end
        end
    end
    local v122 = RaycastParams.new()
    v122.FilterType = Enum.RaycastFilterType.Exclude
    local tbl_27 = {workspace:FindFirstChild("FX"), workspace:FindFirstChild("Projectiles")}
    local tbl_28 = {}
    for _, value_13 in tbl_27 do
        if value_13 then
            table.insert(tbl_28, value_13)
        end
    end
    for _, value_14 in tbl_26 do
        table.insert(tbl_28, value_14)
    end
    v122.FilterDescendantsInstances = tbl_28
    v122.IgnoreWater = true
    tbl_upv_23[v116] = {p = v122, t = v118}
    return v122
end
function tbl_upv_1.Projectile(a1, a2, a3, a4, a5, a6, a7)
    --[[
      name: Projectile
      line: 1041
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        u33 (ref,  index: 3)
        Quality_upv_1 (copy, index: 4)
        template (copy, index: 5)
        takeFromPool (copy, index: 6)
        fallbackModel (copy, index: 7)
        lowDetail (copy, index: 8)
        u2 (ref,  index: 9)
        Ballistics_upv_1 (copy, index: 10)
        paramsFor (copy, index: 11)
        tbl_upv_19 (copy, index: 12)
        u31 (ref,  index: 13)
        Util_upv_1 (copy, index: 14)
        tbl_upv_21 (copy, index: 17)
        release (copy, index: 18)
        addLine (copy, index: 19)
    ]]
    local v123 = (a6 ~= nil) and (a6 == LocalPlayer_upv_1.Character)
    local v124 = not v123
    local v126
    if v124 then
        v126 = workspace.CurrentCamera
        v124 = tbl_upv_1.NEAR < (not workspace.CurrentCamera and 0 or (workspace.CurrentCamera.CFrame.Position - a3).Magnitude)
    end
    if not (v123) and Quality_upv_1.maxFlying <= u33 then
        return nil
    end
    local v125 = template("Projectiles/" .. a2)
    if v125 then
        v126 = takeFromPool("Projectiles/" .. a2, v125)
    else
        v126 = fallbackModel(a2)
    end
    local v127 = CFrame.lookAt(a3, a3 + a4)
    if v126:IsA("Model") then
        v126:PivotTo(v127)
    elseif v126:IsA("BasePart") then
        v126.CFrame = v127
    end
    if v124 or not (v123) and not (Quality_upv_1.layers) then
        lowDetail(v126)
    end
    v126:SetAttribute("CosKey", a1)
    local FX_8 = workspace:FindFirstChild("FX")
    if FX_8 then
        u2 = FX_8
    end
    v126.Parent = u2
    local tbl_29 = {view = 0, impactPlayed = false, born = 0, origin = 0, mine = 0, predict = 0, spin = 0, landed = false, far = 0, params = 0}
    tbl_29.key = a1
    tbl_29.kind = a2
    tbl_29.model = v126
    tbl_29.shot = Ballistics_upv_1.new(a3, a4, a5, 0)
    tbl_29.params = tbl_upv_1.ParamsOverride and tbl_upv_1.ParamsOverride(a6) or paramsFor(a6)
    tbl_29.born = os.clock()
    tbl_29.mine = v123
    tbl_29.far = v124
    tbl_29.spin = tbl_upv_19[a2] or 0
    tbl_29.predict = a7
    tbl_29.origin = a3
    local v129
    if v123 and u31 then
        Util_upv_1.InFirstPerson()
    end
    v129 = nil
    tbl_29.view = v129
    local view_1 = tbl_29.view
    if view_1 then
        for _, value_15 in v126:GetDescendants() do
            if not (value_15:IsA("Trail")) then
                continue
            end
            if value_15.Enabled then
                value_15.Enabled = false
                table.insert(view_1.trails, value_15)
            end
        end
    end
    local v130 = tbl_upv_21[a1]
    if v130 then
        if not (v130.landed) then
            u33 = u33 - 1
        end
        if v130.stopLoop then
            v130.stopLoop(0)
        end
        release(v130.model)
    end
    local v131 = ((a2 == "FireBomb") and "FireBomb_Fuse") or (((a2 == "Beehive") and "Bees_Loop") or (((a2 == "Hatchet") and "Hatchet_Spin") or nil))
    if v131 and not (v124) then
        local v132
        if v126:IsA("Model") then
            v132 = v126.PrimaryPart
        elseif v126:IsA("BasePart") then
            v132 = v126
        else
            v132 = nil
        end
        if v132 then
            tbl_29.stopLoop = Util_upv_1.Loop(v131, v132)
        end
    end
    tbl_upv_21[a1] = tbl_29
    u33 = u33 + 1
    if a2 == "Harpoon" and not (v124) then
        addLine(a1, v126, a6)
    end
    return tbl_29
end
function tbl_upv_1.Pellets(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11)
    --[[
      name: Pellets
      line: 1109
      upvalues:
        Combat_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    for key_4, value_16 in Combat_upv_1.PelletDirs(a4, a7, a8, a9) do
        tbl_upv_1.Projectile(("%*/%*"):format(a1, key_4), a2, a3, value_16 * a5, a6, a10, a11)
    end
end
local tbl_upv_30 = {}
local function fadeOut(a1, a2, a3)
    --[[
      name: fadeOut
      line: 821
      upvalues:
        TweenService_upv_1 (copy, index: 1)
        release (copy, index: 2)
    ]]
    for _, value_17 in a1:GetDescendants() do
        if value_17:IsA("ParticleEmitter") or value_17:IsA("Trail") or value_17:IsA("Beam") then
            value_17.Enabled = false
            continue
        end
        if value_17:IsA("PointLight") then
            local tbl_31 = {Brightness = 0}
            TweenService_upv_1:Create(value_17, TweenInfo.new(a2), tbl_31):Play()
        end
    end
    task.delay(
        a3 or (a2 + 0.6),
        function()
            --[[
              line: 829
              upvalues:
                release (copy, index: 1)
                a1 (copy, index: 2)
            ]]
            release(a1)
        end
    )
end
local function hitSound(a1, a2, a3)
    --[[
      name: hitSound
      line: 1117
      upvalues:
        tbl_upv_18 (copy, index: 1)
        tbl_upv_30 (copy, index: 2)
        Util_upv_1 (copy, index: 3)
    ]]
    local v133 = tbl_upv_18[a1]
    if not v133 then
        return
    end
    local v134 = a1 .. ((a2 and "b") or "w")
    local v135 = os.clock()
    if a1 == "Pellet" and v135 - (tbl_upv_30[v134] or 0) < 0.06 then
        return
    end
    tbl_upv_30[v134] = v135
    local Sound_2 = Util_upv_1.Sound
    local v136
    if a2 then
        v136 = v133[1]
    else
        v136 = v133[2]
    end
    Sound_2(v136, a3)
end
local function hideBody(a1)
    --[[
      name: hideBody
      line: 842
    ]]
    for _, value_18 in a1:GetDescendants() do
        if value_18:IsA("BasePart") then
            value_18.Transparency = 1
        end
    end
    if not a1:IsA("BasePart") then
        return
    end
    a1.Transparency = 1
end
local function landCosmetic(a1, a2, a3, a4, a5, a6, a7)
    --[[
      name: landCosmetic
      line: 1132
      upvalues:
        u33 (ref,  index: 1)
        tbl_upv_25 (copy, index: 2)
        u34 (ref,  index: 3)
        TweenService_upv_1 (copy, index: 4)
        Debris_upv_1 (copy, index: 5)
        Combat_upv_1 (copy, index: 6)
        tbl_upv_1 (copy, index: 7)
        tbl_upv_17 (copy, index: 8)
        fadeOut (copy, index: 9)
        hitSound (copy, index: 10)
        hideBody (copy, index: 11)
    ]]
    if not (a1.landed) then
        u33 = u33 - 1
    end
    a1.landed = true
    if a1.stopLoop then
        a1.stopLoop(0.1)
        a1.stopLoop = nil
    end
    local v144 = nil
    if a1.kind == "Harpoon" then
        local u37
        if tbl_upv_25[a1.key] then
            u34 = u34 + 1
            tbl_upv_25[a1.key].token = u34
            v144 = a1.key
            local v137 = (a5 and 0.75) or 0.2
            u37 = tbl_upv_25[v144]
            if u37 then
                local token_upv_1 = u37.token
                task.delay(
                    v137,
                    function()
                        --[[
                          line: 937
                          upvalues:
                            tbl_upv_25 (copy, index: 1)
                            v144 (copy, index: 2)
                            token_upv_1 (copy, index: 3)
                            u37 (copy, index: 4)
                            TweenService_upv_1 (copy, index: 5)
                            Debris_upv_1 (copy, index: 6)
                        ]]
                        local v138 = tbl_upv_25[v144]
                        if v138 and v138.token == token_upv_1 then
                            tbl_upv_25[v144] = nil
                        end
                        if u37.beam.Parent then
                            local tbl_32 = {Width0 = 0, Width1 = 0}
                            TweenService_upv_1:Create(u37.beam, TweenInfo.new(0.15), tbl_32):Play()
                        end
                        Debris_upv_1:AddItem(u37.beam, 0.2)
                        Debris_upv_1:AddItem(u37.a0, 0.2)
                        Debris_upv_1:AddItem(u37.a1, 0.2)
                    end
                )
            end
        end
    end
    if a5 and a1.mine and a6 then
        local v139 = nil
        if not (a1.impactPlayed) then
            v144 = nil
            local v141 = false
            v139 = a1.predict
            if v139 and type(v139.damage) == "number" then
                local v142 = v139.tuning or {}
                v141 = Combat_upv_1.IsHeadPart(a7)
                local v143 = v139.damage * Combat_upv_1.Falloff(v142, (a2 - a1.origin).Magnitude)
                v144 = v143 * (((not v141) and 1) or (v142.headshotMult or 1.5))
            end
            tbl_upv_1.PredictHit(a6, nil, a2, true, v144, v141)
        end
    end
    if a1.shot.vel.Magnitude > 0 then
        local _ = a1.shot.vel.Unit
    else
        v144 = Vector3.new(0, 0, 1)
    end
    local v145 = not a1.far
    if not (v145) then
        local _ = workspace.CurrentCamera
        v145 = (not workspace.CurrentCamera and 0 or (workspace.CurrentCamera.CFrame.Position - a2).Magnitude) <= tbl_upv_1.NEAR
    end
    local v146 = nil
    if tbl_upv_17[a1.kind] then
        v146 = a1.model
        local v147 = CFrame.lookAt(a2 - (v144 * 0.6), (a2 - (v144 * 0.6)) + v144)
        if v146:IsA("Model") then
            v146:PivotTo(v147)
        elseif v146:IsA("BasePart") then
            v146.CFrame = v147
        end
        fadeOut(a1.model, 0.2, 4)
        if (a1.impactPlayed) or not v145 then
            return
        end
        a1.impactPlayed = true
        if not (a5) then
            tbl_upv_1.Impact(a2, a3, a4, false, ((a1.kind ~= "Javelin") and 0.8) or 1.3)
        end
        hitSound(a1.kind, a5, a2)
    else
        if a1.kind ~= "Ball" and a1.kind ~= "Pellet" and a1.kind ~= "Stone" and a1.kind ~= "Bolas" and a1.kind ~= "Hatchet" then
            hideBody(a1.model)
            fadeOut(a1.model, 0.15)
            return
        end
        hideBody(a1.model)
        fadeOut(a1.model, 0.08)
        if (a1.impactPlayed) then
            return
        end
        if v145 then
            a1.impactPlayed = true
            local v148 = a1.kind == "Pellet"
            if not (a5) then
                tbl_upv_1.Impact(a2, a3, a4, false, (v148 and 0.45) or (((a1.kind ~= "Stone") and 0.8) or 0.9))
            end
            hitSound(a1.kind, a5, a2)
        end
    end
end
local u38 = false
local tbl_upv_33 = {}
local tbl_upv_34 = {}
local function bodyOf(a1)
    --[[
      name: bodyOf
      line: 170
      upvalues:
        u4 (copy, index: 1)
    ]]
    local v149 = u4[a1]
    if v149 then
        return v149
    end
    local v150
    if a1:IsA("Model") then
        v150 = a1:GetPivot()
    elseif a1:IsA("BasePart") then
        v150 = a1.CFrame
    else
        v150 = CFrame.identity
    end
    local tbl_35 = {}
    local tbl_36 = {}
    local v151 = a1:GetDescendants()
    table.insert(v151, a1)
    for _, value_19 in v151 do
        if value_19:IsA("BasePart") then
            table.insert(tbl_35, value_19)
            table.insert(tbl_36, v150:ToObjectSpace(value_19.CFrame))
        end
    end
    local tbl_37 = {}
    tbl_37.parts = tbl_35
    tbl_37.rels = tbl_36
    u4[a1] = tbl_37
    return tbl_37
end
RunService_upv_1.Heartbeat:Connect(
    function(a1)
        --[[
          line: 1191
          upvalues:
            u38 (ref,  index: 1)
            tbl_upv_33 (copy, index: 2)
            tbl_upv_34 (copy, index: 3)
            tbl_upv_21 (copy, index: 4)
            u33 (ref,  index: 5)
            Ballistics_upv_1 (copy, index: 6)
            Combat_upv_1 (copy, index: 7)
            landCosmetic (copy, index: 8)
            release (copy, index: 9)
            u31 (ref,  index: 10)
            tbl_upv_22 (copy, index: 11)
            tbl_upv_20 (copy, index: 12)
            bodyOf (copy, index: 13)
            Metrics_upv_1 (copy, index: 14)
        ]]
        local v152 = os.clock()
        u38 = not u38
        table.clear(tbl_upv_33)
        table.clear(tbl_upv_34)
        local v153, v154 = nil, nil
        local v155 = nil
        for key_6, value_20 in tbl_upv_21 do
            if value_20.landed then
                if os.clock() - value_20.born > 10 then
                    tbl_upv_21[key_6] = nil
                end
            else
                if not (value_20.model.Parent) then
                    tbl_upv_21[key_6] = nil
                    u33 = u33 - 1
                    continue
                end
                local v156, v157 = Ballistics_upv_1.Advance(value_20.shot, a1)
                v153 = nil
                if not (value_20.far) then
                    if value_20.mine then
                        v153 = workspace:Raycast(v156, v157, value_20.params)
                    else
                        local v158 = value_20.castFrom or v156
                        if u38 or (value_20.shot.pos - v158).Magnitude > 30 then
                            v153 = workspace:Raycast(v158, value_20.shot.pos - v158, value_20.params)
                            value_20.castFrom = value_20.shot.pos
                        elseif not (value_20.castFrom) then
                            value_20.castFrom = v156
                        end
                    end
                end
                if v153 then
                    local v159 = Combat_upv_1.FindCharacter(v153.Instance)
                    landCosmetic(value_20, v153.Position, v153.Normal, v153.Material.Name, v159 ~= nil, v159, v153.Instance)
                    continue
                end
                if Ballistics_upv_1.Expired(value_20.shot) then
                    if value_20.stopLoop then
                        value_20.stopLoop(0)
                        value_20.stopLoop = nil
                    end
                    release(value_20.model)
                    tbl_upv_21[key_6] = nil
                    u33 = u33 - 1
                elseif value_20.far then
                    if not (u38) then
                        continue
                    end
                    local vel_1 = value_20.shot.vel
                    v154 = value_20.shot.pos
                    local view_2 = value_20.view
                    if view_2 then
                        local v160 = os.clock()
                        local CurrentCamera_6 = workspace.CurrentCamera
                        if v160 < view_2.at then
                            v154 = value_20.shot.pos - Vector3.new(0, 10000, 0)
                        else
                            if view_2.t0 == 0 then
                                view_2.t0 = v160
                                value_20.spinT0 = v160
                                local v161 = u31 and (u31())
                                if v161 and CurrentCamera_6 then
                                    local CFrame_1 = CurrentCamera_6.CFrame
                                    view_2.p0 = CFrame_1:PointToObjectSpace(CFrame_1.Position + ((v161 - CFrame_1.Position) * (tbl_upv_22[value_20.kind] or 4)))
                                end
                                for _, value_21 in view_2.trails do
                                    value_21:Clear()
                                    value_21.Enabled = true
                                end
                            end
                            local v162 = math.clamp((v160 - view_2.t0) / view_2.dur, 0, 1)
                            local v163 = 1 - (1 - v162) * (1 - v162)
                            local p0_1 = view_2.p0
                            if p0_1 and CurrentCamera_6 then
                                local CFrame_2 = CurrentCamera_6.CFrame
                                local v164 = CFrame_2:PointToObjectSpace(value_20.shot.pos)
                                if v164.Z < -0.05 and p0_1.Z < -0.05 then
                                    local _ = -p0_1.Z
                                    local v169 = -v164.Z
                                    local v170 = -p0_1.Z + (-v164.Z - -p0_1.Z) * v163
                                    v154 = CFrame_2:PointToWorldSpace(Vector3.new((p0_1.X / -p0_1.Z + (v164.X / -v164.Z - p0_1.X / -p0_1.Z) * v163) * (-p0_1.Z + (-v164.Z - -p0_1.Z) * v163), (p0_1.Y / -p0_1.Z + (v164.Y / -v164.Z - p0_1.Y / -p0_1.Z) * v163) * (-p0_1.Z + (-v164.Z - -p0_1.Z) * v163), -(-p0_1.Z + (-v164.Z - -p0_1.Z) * v163)))
                                end
                            end
                            if v162 >= 1 then
                                value_20.view = nil
                            end
                        end
                    end
                    if not (vel_1.Magnitude > 0.01) then
                        continue
                    end
                    local v165 = CFrame.lookAt(v154, v154 + vel_1)
                    if value_20.spin > 0 then
                        local v166 = os.clock()
                        local v167 = (v166 - (value_20.spinT0 or (value_20.born))) * value_20.spin
                        if tbl_upv_20[value_20.kind] then
                            v155 = CFrame.Angles(0, v167, 0)
                        else
                            v155 = CFrame.Angles(-v167, 0, 0)
                        end
                        v165 = v165 * v155
                    end
                    local v168 = bodyOf(value_20.model)
                    for key_7, value_22 in v168.parts do
                        table.insert(tbl_upv_33, value_22)
                        table.insert(tbl_upv_34, v165 * v168.rels[key_7])
                    end
                else
                    local vel_1 = value_20.shot.vel
                    v154 = value_20.shot.pos
                    local view_2 = value_20.view
                    if view_2 then
                        local v160 = os.clock()
                        local CurrentCamera_6 = workspace.CurrentCamera
                        if v160 < view_2.at then
                            v154 = value_20.shot.pos - Vector3.new(0, 10000, 0)
                        else
                            if view_2.t0 == 0 then
                                view_2.t0 = v160
                                value_20.spinT0 = v160
                                local v161 = u31 and (u31())
                                if v161 and CurrentCamera_6 then
                                    local CFrame_1 = CurrentCamera_6.CFrame
                                    view_2.p0 = CFrame_1:PointToObjectSpace(CFrame_1.Position + ((v161 - CFrame_1.Position) * (tbl_upv_22[value_20.kind] or 4)))
                                end
                                for _, value_21 in view_2.trails do
                                    value_21:Clear()
                                    value_21.Enabled = true
                                end
                            end
                            local v162 = math.clamp((v160 - view_2.t0) / view_2.dur, 0, 1)
                            local v163 = 1 - (1 - v162) * (1 - v162)
                            local p0_1 = view_2.p0
                            if p0_1 and CurrentCamera_6 then
                                local CFrame_2 = CurrentCamera_6.CFrame
                                local v164 = CFrame_2:PointToObjectSpace(value_20.shot.pos)
                                if v164.Z < -0.05 and p0_1.Z < -0.05 then
                                    local _ = -p0_1.Z
                                    local v169 = -v164.Z
                                    local v170 = -p0_1.Z + (-v164.Z - -p0_1.Z) * v163
                                    v154 = CFrame_2:PointToWorldSpace(Vector3.new((p0_1.X / -p0_1.Z + (v164.X / -v164.Z - p0_1.X / -p0_1.Z) * v163) * (-p0_1.Z + (-v164.Z - -p0_1.Z) * v163), (p0_1.Y / -p0_1.Z + (v164.Y / -v164.Z - p0_1.Y / -p0_1.Z) * v163) * (-p0_1.Z + (-v164.Z - -p0_1.Z) * v163), -(-p0_1.Z + (-v164.Z - -p0_1.Z) * v163)))
                                end
                            end
                            if v162 >= 1 then
                                value_20.view = nil
                            end
                        end
                    end
                    if not (vel_1.Magnitude > 0.01) then
                        continue
                    end
                    local v165 = CFrame.lookAt(v154, v154 + vel_1)
                    if value_20.spin > 0 then
                        local v166 = os.clock()
                        local v167 = (v166 - (value_20.spinT0 or (value_20.born))) * value_20.spin
                        if tbl_upv_20[value_20.kind] then
                            v155 = CFrame.Angles(0, v167, 0)
                        else
                            v155 = CFrame.Angles(-v167, 0, 0)
                        end
                        v165 = v165 * v155
                    end
                    local v168 = bodyOf(value_20.model)
                    for key_7, value_22 in v168.parts do
                        table.insert(tbl_upv_33, value_22)
                        table.insert(tbl_upv_34, v165 * v168.rels[key_7])
                    end
                end
            end
        end
        if #tbl_upv_33 > 0 then
            workspace:BulkMoveTo(tbl_upv_33, tbl_upv_34, Enum.BulkMoveMode.FireCFrameChanged)
        end
        Metrics_upv_1.AddProj(os.clock() - v152, u33)
    end
)
function tbl_upv_1.ResolveProjectile(a1)
    --[[
      name: ResolveProjectile
      line: 1296
      upvalues:
        tbl_upv_21 (copy, index: 1)
        release (copy, index: 2)
        u33 (ref,  index: 3)
        landCosmetic (copy, index: 4)
        tbl_upv_17 (copy, index: 5)
        tbl_upv_1 (copy, index: 6)
    ]]
    local key_8 = a1.key
    if type(key_8) ~= "string" then
        return
    end
    local v169 = tbl_upv_21[key_8]
    local v170 = nil
    if a1.expired then
        if not v169 or (v169.landed) then
            return
        end
        if v169.stopLoop then
            v169.stopLoop(0)
            v169.stopLoop = nil
        end
        release(v169.model)
        tbl_upv_21[key_8] = nil
        u33 = u33 - 1
    else
        v170 = a1.position
        if typeof(v170) ~= "Vector3" then
            return
        end
        local v171 = a1.character ~= nil
        if v169 then
            if not (v169.landed) then
                landCosmetic(v169, v170, a1.normal, a1.material, v171)
            end
            local part_1 = a1.part
            local rel_1 = a1.rel
            local v172 = v169.model:GetAttribute("CosKey") == key_8
            if not v172 or not tbl_upv_17[v169.kind] or typeof(part_1) ~= "Instance" or not part_1:IsA("BasePart") or typeof(rel_1) ~= "CFrame" or not v169.model.Parent then
                return
            end
            local model_1 = v169.model
            local v173 = part_1.CFrame * rel_1
            if model_1:IsA("Model") then
                model_1:PivotTo(v173)
            elseif model_1:IsA("BasePart") then
                model_1.CFrame = v173
            end
            local v174
            if v169.model:IsA("Model") then
                v174 = v169.model.PrimaryPart
            elseif v169.model:IsA("BasePart") then
                v174 = v169.model
            else
                v174 = nil
            end
            if not v174 or part_1.Anchored then
                return
            end
            for _, value_23 in v169.model:GetDescendants() do
                if value_23:IsA("BasePart") then
                    value_23.Anchored = false
                    value_23.Massless = true
                end
            end
            if v169.model:IsA("BasePart") then
                v169.model.Anchored = false
            end
            local v175 = Instance.new("WeldConstraint")
            v175.Name = "StickWeld"
            v175.Part0 = part_1
            v175.Part1 = v174
            v175.Parent = v174
        else
            local CurrentCamera_7 = workspace.CurrentCamera
            if ((((not CurrentCamera_7) and 0) or ((CurrentCamera_7.CFrame.Position - v170).Magnitude)) <= tbl_upv_1.NEAR) then
                if v171 then
                    tbl_upv_1.CharacterImpact(v170, nil, false)
                elseif a1.kind ~= "FireBomb" and a1.kind ~= "SmokeBomb" and a1.kind ~= "Flask" and a1.kind ~= "Caltrops" then
                    if a1.kind ~= "Beehive" then
                        local Impact_1 = tbl_upv_1.Impact
                        local normal_1 = a1.normal
                        local material_1 = a1.material
                        local v176 = a1.kind ~= "Pellet"
                        Impact_1(v170, normal_1, material_1, v176, ((a1.kind ~= "Pellet") and 0.8) or 0.45)
                    end
                end
            end
        end
    end
end
function tbl_upv_1.Explosion(a1, a2, a3, a4)
    --[[
      name: Explosion
      line: 1362
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
        u2 (ref,  index: 3)
        TweenService_upv_1 (copy, index: 4)
        Debris_upv_1 (copy, index: 5)
        Quality_upv_1 (copy, index: 6)
        groundDecal (copy, index: 7)
        LocalPlayer_upv_1 (copy, index: 8)
    ]]
    local CurrentCamera_8 = workspace.CurrentCamera
    local v177 = tbl_upv_1.NEAR < (((not CurrentCamera_8) and 0) or ((CurrentCamera_8.CFrame.Position - a1).Magnitude))
    local Burst_2 = tbl_upv_1.Burst
    local v178 = CFrame.new(a1)
    local v179 = a2 / 9
    local v180
    if v177 then
        v180 = 0.5
    else
        v180 = 1
    end
    Burst_2("Explosion_Fire", v178, v179 * v180, Color3.fromRGB(245, 140, 50), true)
    Util_upv_1.Sound("FireBomb_Explode", a1)
    local v181 = a3 or (a2 * 0.8)
    local v182 = a4 or 2.2
    local v183 = Util_upv_1.WorldParams(Util_upv_1.Targets())
    local v184 = workspace:Raycast(a1 + Vector3.new(0, 1.5, 0), Vector3.new(0, -(a2 + 1.5), 0), v183)
    local v185
    if v184 then
        v178 = v184.Position
        v185 = v184.Normal
    else
        v178, v185 = nil, nil
    end
    local v186 = nil
    if not (v177) then
        local v187 = CFrame.new(a1)
        local v188, v189, v190 = Color3.fromRGB(245, 125, 40)
        v183 = Instance.new("Part")
        v183.Name = "ExplosionCore"
        v183.Anchored = true
        v183.CanCollide = false
        v183.CanQuery = false
        v183.CanTouch = false
        v183.CastShadow = false
        v183.Size = Vector3.new(1.5, 1.5, 1.5)
        v183.CFrame = v187
        v183.Color = v188
        v183.Material = v189 or (Enum.Material.SmoothPlastic)
        v183.Transparency = v190 or 0
        v186 = workspace:FindFirstChild("FX")
        if v186 then
            u2 = v186
        end
        v183.Parent = u2
        v183.Shape = Enum.PartType.Ball
        v183.Transparency = 0.3
        local v191 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tbl_38 = {Transparency = 1}
        tbl_38.Size = (Vector3.new(1, 1, 1) * a2) * 0.7
        tbl_38.Color = Color3.fromRGB(200, 70, 25)
        TweenService_upv_1:Create(v183, v191, tbl_38):Play()
        Debris_upv_1:AddItem(v183, 0.25)
        local v192 = Instance.new("PointLight")
        v192.Color = Color3.fromRGB(255, 140, 60)
        v192.Range = 16
        v192.Brightness = 1
        v192.Parent = v183
        local v193 = CFrame.new(a1)
        local v194 = Color3.new()
        local v195 = Instance.new("Part")
        v195.Name = "PuffFX"
        v195.Anchored = true
        v195.CanCollide = false
        v195.CanQuery = false
        v195.CanTouch = false
        v195.CastShadow = false
        v195.Size = Vector3.new(1, 1, 1)
        v195.CFrame = v193
        v195.Color = v194
        v195.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
        v195.Transparency = 1
        v183 = workspace:FindFirstChild("FX")
        if v183 then
            u2 = v183
        end
        v195.Parent = u2
        local v196 = Instance.new("ParticleEmitter")
        v196.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        v196.Color = ColorSequence.new(Color3.fromRGB(255, 170, 70), Color3.fromRGB(230, 90, 30))
        v196.LightEmission = 0.35
        v196.LightInfluence = 0.4
        v196.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0)})
        v196.Lifetime = NumberRange.new(0.6, 1.1)
        v196.Speed = NumberRange.new(10, 22)
        v196.SpreadAngle = Vector2.new(70, 70)
        v196.EmissionDirection = Enum.NormalId.Top
        v196.Acceleration = Vector3.new(0, -24, 0)
        v196.Rate = 0
        v196.Parent = v195
        v196:Emit((math.floor((20 * Quality_upv_1.particleScale) + 0.5)))
        Debris_upv_1:AddItem(v195, 1.3)
    end
    if v178 then
        local v197 = nil
        if v185 then
            if not (v177) then
                groundDecal(v178, v185, "rbxassetid://10871117278", Color3.fromRGB(235, 140, 70), 2, a2 * 2.4, 0.26, 0.3)
            end
            groundDecal(v178, v185, "rbxassetid://10430755572", Color3.fromRGB(60, 32, 22), v181 * 2, v181 * 2.1, 0.15, 0.25, v182)
            v179 = (v177 and 5) or 10
            for n_2 = 1, v179 do
                local v198 = ((n_2 / v179) * math.pi) * 2 + math.random() * 0.5
                local v199 = ((n_2 ~= 1) and (v181 * ((math.sqrt(math.random()) * 0.65) + 0.25))) or 0
                local v200 = CFrame.new(v178 + Vector3.new(math.cos(v198) * v199, 0.4, math.sin(v198) * v199))
                local v201 = Color3.new()
                local v202 = Instance.new("Part")
                v202.Name = "PuffFX"
                v202.Anchored = true
                v202.CanCollide = false
                v202.CanQuery = false
                v202.CanTouch = false
                v202.CastShadow = false
                v202.Size = Vector3.new(2, 0.5, 2)
                v202.CFrame = v200
                v202.Color = v201
                v202.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
                v202.Transparency = 1
                local FX_9 = workspace:FindFirstChild("FX")
                if FX_9 then
                    u2 = FX_9
                end
                v202.Parent = u2
                local u39 = Instance.new("ParticleEmitter")
                u39.Texture = "rbxasset://textures/particles/fire_main.dds"
                u39.Color = ColorSequence.new(Color3.fromRGB(255, 190, 80), Color3.fromRGB(235, 90, 30))
                u39.LightEmission = 0.35
                u39.LightInfluence = 0.3
                u39.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2.5), NumberSequenceKeypoint.new(0.4, 4.5), NumberSequenceKeypoint.new(1, 0)})
                u39.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(1, 1)})
                u39.Lifetime = NumberRange.new(0.6, 0.9)
                u39.Speed = NumberRange.new(3, 5)
                u39.SpreadAngle = Vector2.new(10, 10)
                u39.EmissionDirection = Enum.NormalId.Top
                u39.Rotation = NumberRange.new(-20, 20)
                u39.Rate = ((v177 and 0.6) or 1) * 14
                u39.Shape = Enum.ParticleEmitterShape.Box
                u39.Parent = v202
                task.delay(
                    v182,
                    function()
                        --[[
                          line: 1436
                          upvalues:
                            u39 (copy, index: 1)
                        ]]
                        u39.Enabled = false
                    end
                )
                Debris_upv_1:AddItem(v202, v182 + 1)
                local v203 = n_2
            end
            local v204 = Vector3.new(v181, 1, v181)
            local v203 = CFrame.new(v178 + Vector3.new(0, 1.5, 0))
            local v205 = Color3.new()
            local v206 = Instance.new("Part")
            v206.Name = "PuffFX"
            v206.Anchored = true
            v206.CanCollide = false
            v206.CanQuery = false
            v206.CanTouch = false
            v206.CastShadow = false
            v206.Size = v204
            v206.CFrame = v203
            v206.Color = v205
            v206.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
            v206.Transparency = 1
            v197 = workspace:FindFirstChild("FX")
            if v197 then
                u2 = v197
            end
            v206.Parent = u2
            local u40 = Instance.new("ParticleEmitter")
            u40.Texture = "rbxasset://textures/particles/smoke_main.dds"
            u40.Color = ColorSequence.new(Color3.fromRGB(80, 55, 45))
            u40.LightEmission = 0
            u40.LightInfluence = 1
            u40.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2), NumberSequenceKeypoint.new(1, 5)})
            u40.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 1)})
            u40.Lifetime = NumberRange.new(1.5, 2.2)
            u40.Speed = NumberRange.new(3, 5)
            u40.EmissionDirection = Enum.NormalId.Top
            u40.SpreadAngle = Vector2.new(8, 8)
            u40.Rate = 6
            u40.Parent = v206
            task.delay(
                v182,
                function()
                    --[[
                      line: 1456
                      upvalues:
                        u40 (copy, index: 1)
                    ]]
                    u40.Enabled = false
                end
            )
            Debris_upv_1:AddItem(v206, v182 + 2.5)
        end
    end
    local Character_1 = LocalPlayer_upv_1.Character
    v178 = Character_1 and (Character_1:FindFirstChild("HumanoidRootPart"))
    if v178 then
        local Magnitude_1 = (v178.Position - a1).Magnitude
        if not (Magnitude_1 < a2 * 4) then
            return
        end
        Util_upv_1.Shake(math.clamp(1.4 * (1 - (Magnitude_1 / (a2 * 4))), 0.2, 1.4), 0.45)
    end
end
function tbl_upv_1.SmokeCloud(a1, a2, a3)
    --[[
      name: SmokeCloud
      line: 1472
      upvalues:
        Combat_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
        tbl_upv_1 (copy, index: 3)
        Util_upv_1 (copy, index: 4)
    ]]
    Combat_upv_1.AddSmoke(a1, a2, a3)
    local v207 = Vector3.new(a2 * 1.5, a2 * 0.9, a2 * 1.5)
    local v208 = CFrame.new(a1)
    local v209 = Color3.new()
    local u41 = Instance.new("Part")
    u41.Name = "PuffFX"
    u41.Anchored = true
    u41.CanCollide = false
    u41.CanQuery = false
    u41.CanTouch = false
    u41.CastShadow = false
    u41.Size = v207
    u41.CFrame = v208
    u41.Color = v209
    u41.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
    u41.Transparency = 1
    local FX_10 = workspace:FindFirstChild("FX")
    if FX_10 then
        u2 = FX_10
    end
    u41.Parent = u2
    local u42 = Color3.fromRGB(176, 180, 186)
    local function emitter(a4, a5, a6, a7, a8)
        --[[
          name: emitter
          line: 1476
          upvalues:
            u42 (copy, index: 1)
            u41 (copy, index: 2)
        ]]
        local v210 = Instance.new("ParticleEmitter")
        v210.Name = a4
        v210.Texture = "rbxasset://textures/particles/smoke_main.dds"
        v210.Color = ColorSequence.new(u42)
        v210.LightEmission = 0
        v210.LightInfluence = 1
        v210.Shape = Enum.ParticleEmitterShape.Sphere
        v210.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
        v210.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, a5), NumberSequenceKeypoint.new(1, a6)})
        v210.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0.06), NumberSequenceKeypoint.new(0.75, 0.12), NumberSequenceKeypoint.new(1, 1)})
        v210.Lifetime = NumberRange.new(a7 * 0.8, a7)
        v210.Rate = a8
        v210.Speed = NumberRange.new(0.4, 1.4)
        v210.SpreadAngle = Vector2.new(180, 180)
        v210.Rotation = NumberRange.new(0, 360)
        v210.RotSpeed = NumberRange.new(-12, 12)
        v210.Drag = 1
        v210.Parent = u41
        return v210
    end
    local u43 = emitter("Body", a2 * 0.7, a2 * 0.95, 3.2, 34)
    local u44 = emitter("Low", a2 * 0.5, a2 * 0.7, 2.6, 16)
    u44.Acceleration = Vector3.new(0, -0.6000000238418579, 0)
    u43:Emit(30)
    u44:Emit(10)
    tbl_upv_1.Puff(a1, u42, 14, a2 * 0.4, 16, 0.8)
    Util_upv_1.Sound("Smoke_Pop", a1)
    task.delay(
        math.max(0.5, a3 - 2.6),
        function()
            --[[
              line: 1510
              upvalues:
                u43 (copy, index: 1)
                u44 (copy, index: 2)
            ]]
            u43.Enabled = false
            u44.Enabled = false
        end
    )
    task.delay(
        a3 + 1.5,
        function()
            --[[
              line: 1514
              upvalues:
                u41 (copy, index: 1)
            ]]
            u41:Destroy()
        end
    )
end
function tbl_upv_1.TrapSnap(a1)
    --[[
      name: TrapSnap
      line: 1520
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    tbl_upv_1.Burst("Impact_Sparks", CFrame.new(a1 + Vector3.new(0, 0.5, 0)), 1.4)
    tbl_upv_1.Burst("Impact_Dust", CFrame.lookAt(a1, a1 + Vector3.new(0, 1, 0)), 1.2)
    Util_upv_1.Sound("Trap_Snap", a1)
end
function tbl_upv_1.ChargeGlow(a1, a2, a3)
    --[[
      name: ChargeGlow
      line: 1530
      upvalues:
        Util_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        Quality_upv_1 (copy, index: 3)
    ]]
    if not a1 then
        return
    end
    local v211 = Util_upv_1.Drawn(a1) or a1
    local v212 = a3 or (tbl_upv_1.WeaponColor(a1))
    if a2 <= 0.01 then
        for _, value_24 in {a1, v211} do
            local CombatChargeHL_1 = value_24:FindFirstChild("CombatChargeHL")
            if CombatChargeHL_1 then
                CombatChargeHL_1:Destroy()
            end
            local v213 = value_24:FindFirstChild("Muzzle", true)
            local v214 = v213 and (v213:FindFirstChild("CombatGlow"))
            if v214 then
                v214:Destroy()
            end
        end
    else
        local v215 = v211:FindFirstChild("CombatChargeHL")
        local v216 = v211:FindFirstChild("Muzzle", true)
        local v217 = v216 and (v216:FindFirstChild("CombatGlow"))
        if not (v215) and Quality_upv_1.highlights then
            local v218 = Instance.new("Highlight")
            v218.Name = "CombatChargeHL"
            v218.DepthMode = Enum.HighlightDepthMode.Occluded
            v218.Adornee = v211
            v218.FillTransparency = 1
            v218.Parent = v211
            v215 = v218
        end
        if v215 then
            v215.OutlineColor = v212
            v215.OutlineTransparency = 1 - (a2 * (((a2 >= 1) and 0.9) or 0.6))
        end
        if not v216 or not v216:IsA("Attachment") then
            return
        end
        if v216 then
            v217 = v216
        else
            v215 = Instance.new("PointLight")
            v215.Name = "CombatGlow"
            v215.Range = 5
            v215.Shadows = false
            v215.Parent = v216
            v217 = v215
        end
        v217.Color = v212
        v217.Brightness = math.min(1, a2 * 0.8)
    end
end
function tbl_upv_1.ChargePing(a1, a2)
    --[[
      name: ChargePing
      line: 1583
      upvalues:
        Util_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
        TweenService_upv_1 (copy, index: 3)
        Debris_upv_1 (copy, index: 4)
        tbl_upv_1 (copy, index: 5)
    ]]
    local v219 = Util_upv_1.Drawn(a1)
    local v220 = v219 and (v219:FindFirstChild("Muzzle", true) or (v219:FindFirstChild("Tip", true)))
    if not v220 then
        return
    end
    if v220:IsA("Attachment") then
        local WorldCFrame_1 = v220.WorldCFrame
        local v221 = a2 or (Color3.fromRGB(245, 175, 60))
        local v222 = Instance.new("Part")
        v222.Name = "ChargePing"
        v222.Anchored = true
        v222.CanCollide = false
        v222.CanQuery = false
        v222.CanTouch = false
        v222.CastShadow = false
        v222.Size = Vector3.new(0.30000001192092896, 0.30000001192092896, 0.30000001192092896)
        v222.CFrame = WorldCFrame_1
        v222.Color = v221
        v222.Material = Enum.Material.ForceField or (Enum.Material.SmoothPlastic)
        v222.Transparency = 0
        local FX_11 = workspace:FindFirstChild("FX")
        if FX_11 then
            u2 = FX_11
        end
        v222.Parent = u2
        v222.Shape = Enum.PartType.Ball
        local tbl_39 = {Transparency = 1, Size = Vector3.new(1.7999999523162842, 1.7999999523162842, 1.7999999523162842)}
        TweenService_upv_1:Create(v222, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_39):Play()
        Debris_upv_1:AddItem(v222, 0.25)
        tbl_upv_1.Burst("Charge_Sparkle", v220.WorldCFrame, 1, a2, a2 ~= nil)
    end
end
local function torso(a1)
    --[[
      name: torso
      line: 1598
    ]]
    local v223 = a1:FindFirstChild("UpperTorso") or (a1:FindFirstChild("Torso") or (a1:FindFirstChild("HumanoidRootPart")))
    if v223 and v223:IsA("BasePart") then
        return v223
    end
    return nil
end
function tbl_upv_1.Heal(a1, a2)
    --[[
      name: Heal
      line: 1604
      upvalues:
        Util_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        Quality_upv_1 (copy, index: 3)
        Debris_upv_1 (copy, index: 4)
    ]]
    if not a1 then
        return
    end
    if a1:IsA("Model") then
        local v224 = Util_upv_1.Drawn(a1)
        local v225
        if (v224) and (v224:IsA("Model")) then
            v225 = v224
        else
            v225 = a1
        end
        local v226 = v225:FindFirstChild("UpperTorso") or (v225:FindFirstChild("Torso") or (v225:FindFirstChild("HumanoidRootPart")))
        local v227 = not (v226) or not (v226:IsA("BasePart")) or v226
        if not v227 then
            return
        end
        tbl_upv_1.Burst("Heal_Health", v227.CFrame)
        Util_upv_1.Sound("Herbs_Heal", v227)
        local v228 = Instance.new("Attachment")
        v228.Name = "CombatHealFX"
        v228.Parent = v227
        local u45 = Instance.new("ParticleEmitter")
        u45.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        u45.Color = ColorSequence.new(Color3.fromRGB(120, 220, 110))
        u45.LightEmission = 0.3
        u45.LightInfluence = 0.5
        u45.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0)})
        u45.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1)})
        u45.Lifetime = NumberRange.new(0.6, 1)
        u45.Speed = NumberRange.new(1.5, 3)
        u45.SpreadAngle = Vector2.new(40, 40)
        u45.EmissionDirection = Enum.NormalId.Top
        u45.Shape = Enum.ParticleEmitterShape.Cylinder
        u45.Rate = 16 * Quality_upv_1.particleScale
        u45.Parent = v228
        task.delay(
            a2,
            function()
                --[[
                  line: 1632
                  upvalues:
                    u45 (copy, index: 1)
                ]]
                u45.Enabled = false
            end
        )
        Debris_upv_1:AddItem(v228, a2 + 1.2)
    end
end
local tbl_upv_40 = {}
function tbl_upv_1.Status(a1, a2, a3)
    --[[
      name: Status
      line: 1640
      upvalues:
        Util_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        tbl_upv_40 (copy, index: 3)
        template (copy, index: 4)
        Debris_upv_1 (copy, index: 5)
    ]]
    if not a1 then
        return
    end
    if a1:IsA("Model") then
        local v229 = Util_upv_1.Drawn(a1)
        local tbl_upv_41
        if (v229) and (v229:IsA("Model")) then
            tbl_upv_41 = v229
        else
            tbl_upv_41 = a1
        end
        local v230 = tbl_upv_41:FindFirstChild("UpperTorso") or (tbl_upv_41:FindFirstChild("Torso") or (tbl_upv_41:FindFirstChild("HumanoidRootPart")))
        local u46 = not (v230) or not (v230:IsA("BasePart")) or v230
        if not u46 then
            return
        end
        if a2 == "Snare" then
            local Snare_1 = tbl_upv_1.Snare
            if (v229) and (v229:IsA("Model")) then
                v230 = v229
            else
                v230 = a1
            end
            Snare_1(v230, a3)
        elseif a2 == "Burn" then
            tbl_upv_41 = tbl_upv_40[a1]
            if not (tbl_upv_41) then
                tbl_upv_41 = {}
                tbl_upv_40[a1] = tbl_upv_41
                a1.Destroying:Once(
                    function()
                        --[[
                          line: 1660
                          upvalues:
                            tbl_upv_40 (copy, index: 1)
                            a1 (copy, index: 2)
                        ]]
                        tbl_upv_40[a1] = nil
                    end
                )
            end
            local v231 = tbl_upv_41[a2]
            if not (v231) or not (v231.inst.Parent) then
                local v232 = template("Status_Burn")
                if not v232 then
                    return
                end
                local v233 = v232:Clone()
                if v233:IsA("Attachment") then
                    v233.Parent = u46
                    v231 = {token = 0, inst = v233}
                    tbl_upv_41[a2] = v231
                else
                    v233:Destroy()
                    return
                end
            end
            u46 = v231
            u46.token = u46.token + 1
            local token_upv_2 = u46.token
            task.delay(
                a3,
                function()
                    --[[
                      line: 1683
                      upvalues:
                        u46 (copy, index: 1)
                        token_upv_2 (copy, index: 2)
                        Debris_upv_1 (copy, index: 3)
                        tbl_upv_41 (ref,  index: 4)
                        a2 (copy, index: 5)
                    ]]
                    if u46.token ~= token_upv_2 then
                        return
                    end
                    for _, value_25 in u46.inst:GetDescendants() do
                        if value_25:IsA("ParticleEmitter") then
                            value_25.Enabled = false
                        end
                    end
                    Debris_upv_1:AddItem(u46.inst, 1)
                    if tbl_upv_41[a2] == u46 then
                        tbl_upv_41[a2] = nil
                    end
                end
            )
        end
    end
end
local tbl_upv_42 = {}
function tbl_upv_1.Snare(a1, a2)
    --[[
      name: Snare
      line: 1701
      upvalues:
        tbl_upv_42 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    local u47 = (tbl_upv_42[a1] or 0) + 1
    tbl_upv_42[a1] = u47
    local CombatSnareFX_upv_1 = a1:FindFirstChild("CombatSnareFX")
    if CombatSnareFX_upv_1 then
        CombatSnareFX_upv_1:Destroy()
    end
    local LeftLowerLeg_1 = a1:FindFirstChild("LeftLowerLeg")
    local RightLowerLeg_1 = a1:FindFirstChild("RightLowerLeg")
    local _ = not (LeftLowerLeg_1) or not (LeftLowerLeg_1:IsA("BasePart")) or LeftLowerLeg_1
    LeftLowerLeg_1 = not (RightLowerLeg_1) or not (RightLowerLeg_1:IsA("BasePart")) or RightLowerLeg_1
    if not CombatSnareFX_upv_1 or not LeftLowerLeg_1 then
        return
    end
    local u48 = Instance.new("Model")
    u48.Name = "CombatSnareFX"
    local v234 = CombatSnareFX_upv_1.CFrame:PointToObjectSpace(LeftLowerLeg_1.Position)
    local v235 = CFrame.new(v234 / 2)
    local v236 = math.abs(v234.X) + CombatSnareFX_upv_1.Size.X + 0.16
    local v237 = Color3.fromRGB(196, 164, 112)
    for key_9, value_26 in {0.28, 0.05, -0.2} do
        local v238 = Vector3.new(v236, 0.1, CombatSnareFX_upv_1.Size.Z + 0.16)
        local v239 = v235 * CFrame.new(0, value_26, 0)
        local v240 = v239 * CFrame.Angles(0, 0, math.rad(((key_9 ~= 2) and 5) or -6))
        local v241 = Instance.new("Part")
        v241.Name = "Wrap" .. key_9
        v241.Size = v238
        v241.Color = v237
        v241.Material = Enum.Material.SmoothPlastic
        v241.CanCollide = false
        v241.CanQuery = false
        v241.CanTouch = false
        v241.Massless = true
        v241.CastShadow = false
        v241.CFrame = CombatSnareFX_upv_1.CFrame * v240
        local v242 = Instance.new("WeldConstraint")
        v242.Part0 = CombatSnareFX_upv_1
        v242.Part1 = v241
        v242.Parent = v241
        v241.Parent = u48
    end
    local function piece(a3, a4, a5, a6, a7)
        --[[
          name: piece
          line: 1717
          upvalues:
            CombatSnareFX_upv_1 (copy, index: 1)
            u48 (copy, index: 2)
        ]]
        local v243 = Instance.new("Part")
        v243.Name = a3
        v243.Size = a4
        v243.Color = a6
        v243.Material = Enum.Material.SmoothPlastic
        if a7 then
            v243.Shape = Enum.PartType.Ball
        end
        v243.CanCollide = false
        v243.CanQuery = false
        v243.CanTouch = false
        v243.Massless = true
        v243.CastShadow = false
        v243.CFrame = CombatSnareFX_upv_1.CFrame * a5
        local v244 = Instance.new("WeldConstraint")
        v244.Part0 = CombatSnareFX_upv_1
        v244.Part1 = v243
        v244.Parent = v243
        v243.Parent = u48
    end
    piece("StoneA", Vector3.new(0.46000000834465027, 0.46000000834465027, 0.46000000834465027), v235 * CFrame.new((v236 / 2) + 0.05, -0.05, 0.2), Color3.fromRGB(128, 124, 118), true)
    piece("StoneB", Vector3.new(0.46000000834465027, 0.46000000834465027, 0.46000000834465027), v235 * CFrame.new((-v236 / 2) - 0.05, 0.2, -0.2), Color3.fromRGB(96, 92, 88), true)
    u48.Parent = a1
    Util_upv_1.Sound("Stone_Hit", CombatSnareFX_upv_1)
    task.delay(
        a2,
        function()
            --[[
              line: 1751
              upvalues:
                tbl_upv_42 (copy, index: 1)
                a1 (copy, index: 2)
                u47 (copy, index: 3)
                u48 (copy, index: 4)
            ]]
            if tbl_upv_42[a1] ~= u47 then
                return
            end
            tbl_upv_42[a1] = nil
            u48:Destroy()
        end
    )
    a1.Destroying:Once(
        function()
            --[[
              line: 1757
              upvalues:
                tbl_upv_42 (copy, index: 1)
                a1 (copy, index: 2)
            ]]
            tbl_upv_42[a1] = nil
        end
    )
end
local tbl_upv_43 = {}
function tbl_upv_1.Reveal(a1, a2)
    --[[
      name: Reveal
      line: 1766
      upvalues:
        tbl_upv_43 (copy, index: 1)
        Quality_upv_1 (copy, index: 2)
        u2 (ref,  index: 3)
    ]]
    local u49 = (tbl_upv_43[a1] or 0) + 1
    tbl_upv_43[a1] = u49
    local v245 = Color3.fromRGB(240, 170, 60)
    local u50 = Instance.new("Folder")
    u50.Name = "CombatReveal"
    if Quality_upv_1.highlights then
        local v246 = Instance.new("Highlight")
        v246.Name = "Mark"
        v246.Adornee = a1
        v246.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        v246.FillColor = v245
        v246.FillTransparency = 0.78
        v246.OutlineColor = v245
        v246.OutlineTransparency = 0.1
        v246.Parent = u50
    end
    local Head_1 = a1:FindFirstChild("Head")
    if Head_1 and Head_1:IsA("BasePart") then
        local v247 = Instance.new("BillboardGui")
        v247.Name = "Pin"
        v247.Adornee = Head_1
        v247.AlwaysOnTop = true
        v247.Size = UDim2.fromOffset(18, 18)
        v247.StudsOffsetWorldSpace = Vector3.new(0, 2.5999999046325684, 0)
        v247.LightInfluence = 0
        local v248 = Instance.new("Frame")
        v248.AnchorPoint = Vector2.new(0.5, 0.5)
        v248.Position = UDim2.fromScale(0.5, 0.5)
        v248.Size = UDim2.fromOffset(11, 11)
        v248.Rotation = 45
        v248.BackgroundColor3 = v245
        v248.BorderSizePixel = 0
        local v249 = Instance.new("UIStroke")
        v249.Thickness = 1.5
        v249.Color = Color3.fromRGB(60, 40, 10)
        v249.Parent = v248
        v248.Parent = v247
        v247.Parent = u50
    end
    local FX_12 = workspace:FindFirstChild("FX")
    if FX_12 then
        u2 = FX_12
    end
    u50.Parent = u2
    task.delay(
        a2,
        function()
            --[[
              line: 1807
              upvalues:
                u50 (copy, index: 1)
                tbl_upv_43 (copy, index: 2)
                a1 (copy, index: 3)
                u49 (copy, index: 4)
            ]]
            u50:Destroy()
            if tbl_upv_43[a1] ~= u49 then
                return
            end
            tbl_upv_43[a1] = nil
        end
    )
    a1.Destroying:Once(
        function()
            --[[
              line: 1813
              upvalues:
                u50 (copy, index: 1)
            ]]
            u50:Destroy()
        end
    )
end
function tbl_upv_1.HornBlast(a1)
    --[[
      name: HornBlast
      line: 1819
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
        u2 (ref,  index: 3)
        TweenService_upv_1 (copy, index: 4)
        Debris_upv_1 (copy, index: 5)
    ]]
    local CurrentCamera_9 = workspace.CurrentCamera
    if tbl_upv_1.NEAR < (((not CurrentCamera_9) and 0) or ((CurrentCamera_9.CFrame.Position - a1).Magnitude)) then
        return
    end
    local v250 = workspace:Raycast(a1 + Vector3.new(0, 1.5, 0), Vector3.new(0, -9.5, 0), Util_upv_1.WorldParams(Util_upv_1.Targets()))
    local v251, v252
    if v250 then
        v251 = v250.Position
        v252 = v250.Normal
    else
        v251, v252 = nil, nil
    end
    local v253 = v251 or (a1 - Vector3.new(0, 2.799999952316284, 0))
    local v254 = v252 or Vector3.new(0, 1, 0)
    local v255 = CFrame.lookAt(v253 + (v254 * 0.15), v253 + (v254 * 1.15)) * CFrame.Angles(0, 1.5707963267948966, 0)
    local v256 = Color3.fromRGB(226, 190, 110)
    local v257 = Instance.new("Part")
    v257.Name = "HornRing"
    v257.Anchored = true
    v257.CanCollide = false
    v257.CanQuery = false
    v257.CanTouch = false
    v257.CastShadow = false
    v257.Size = Vector3.new(0.05999999865889549, 3, 3)
    v257.CFrame = v255
    v257.Color = v256
    v257.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
    v257.Transparency = 0.45
    local FX_13 = workspace:FindFirstChild("FX")
    if FX_13 then
        u2 = FX_13
    end
    v257.Parent = u2
    v257.Shape = Enum.PartType.Cylinder
    local tbl_44 = {Transparency = 1, Size = Vector3.new(0.05999999865889549, 34, 34)}
    TweenService_upv_1:Create(v257, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_44):Play()
    Debris_upv_1:AddItem(v257, 0.8)
end
local tbl_upv_45 = {}
local u51 = nil
local function stepRings(a1)
    --[[
      name: stepRings
      line: 1878
      upvalues:
        tbl_upv_45 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
        fadeOut (copy, index: 3)
        Debris_upv_1 (copy, index: 4)
        u31 (ref,  index: 5)
        u51 (ref,  index: 6)
    ]]
    local v258 = os.clock()
    local v259 = nil
    local v260 = nil
    for key_10, value_27 in tbl_upv_45 do
        if not (value_27.model.Parent) or v258 - value_27.born > 9 then
            tbl_upv_45[key_10] = nil
            if value_27.model.Parent then
                value_27.model:Destroy()
                continue
            end
        end
        v259 = value_27.speed * a1
        if value_27.back then
            local v261 = value_27.shooter and (value_27.shooter:FindFirstChild("HumanoidRootPart"))
            if not (v261) or not (v261:IsA("BasePart")) then
                local pos_1 = value_27.pos
                local v262 = tbl_upv_45[key_10]
                if not (v262) then
                    continue
                end
                tbl_upv_45[key_10] = nil
                if not (pos_1) then
                    fadeOut(v262.model, 0.3, 1.2)
                    Debris_upv_1:AddItem(v262.model, 2)
                    continue
                end
                local model_2 = v262.model
                local v263 = CFrame.new(pos_1)
                if model_2:IsA("Model") then
                    model_2:PivotTo(v263)
                    Util_upv_1.Sound("Knife_Thunk", pos_1)
                    fadeOut(v262.model, 0.3, 1.2)
                    Debris_upv_1:AddItem(v262.model, 2)
                    continue
                end
                if model_2:IsA("BasePart") then
                    model_2.CFrame = v263
                end
                Util_upv_1.Sound("Knife_Thunk", pos_1)
                fadeOut(v262.model, 0.3, 1.2)
                Debris_upv_1:AddItem(v262.model, 2)
            end
            local v264 = v261.Position + Vector3.new(0, 0.6000000238418579, 0) - value_27.pos
            if v264.Magnitude <= value_27.catch + v259 then
                local Position_3 = v261.Position
                local v265 = tbl_upv_45[key_10]
                if not (v265) then
                    continue
                end
                tbl_upv_45[key_10] = nil
                if not (v265.mine) then
                    v265.model:Destroy()
                    continue
                end
                if not (Util_upv_1.InFirstPerson()) then
                    Util_upv_1.Sound("Knife_Ready", Position_3 or (v265.pos))
                end
                v265.model:Destroy()
            else
                value_27.pos = value_27.pos + (v264.Unit * v259)
                local pos_2 = value_27.pos
                local view_3 = value_27.view
                if view_3 then
                    local CurrentCamera_10 = workspace.CurrentCamera
                    if v258 < view_3.at then
                        v259 = value_27.pos - Vector3.new(0, 10000, 0)
                    else
                        if view_3.t0 == 0 then
                            view_3.t0 = v258
                            value_27.spinT0 = v258
                            local v266 = u31 and (u31())
                            if v266 and CurrentCamera_10 then
                                local CFrame_3 = CurrentCamera_10.CFrame
                                view_3.p0 = CFrame_3:PointToObjectSpace(CFrame_3.Position + ((v266 - CFrame_3.Position) * 4))
                            end
                        end
                        local v267 = math.clamp((v258 - view_3.t0) / 0.12, 0, 1)
                        local v268 = 1 - (1 - v267) * (1 - v267)
                        local p0_2 = view_3.p0
                        if p0_2 and CurrentCamera_10 then
                            local CFrame_4 = CurrentCamera_10.CFrame
                            local v269 = CFrame_4:PointToObjectSpace(value_27.pos)
                            if v269.Z < -0.05 and p0_2.Z < -0.05 then
                                local _ = -p0_2.Z
                                local v274 = -v269.Z
                                local v275 = -p0_2.Z + (-v269.Z - -p0_2.Z) * v268
                                v259 = CFrame_4:PointToWorldSpace(Vector3.new((p0_2.X / -p0_2.Z + (v269.X / -v269.Z - p0_2.X / -p0_2.Z) * v268) * (-p0_2.Z + (-v269.Z - -p0_2.Z) * v268), (p0_2.Y / -p0_2.Z + (v269.Y / -v269.Z - p0_2.Y / -p0_2.Z) * v268) * (-p0_2.Z + (-v269.Z - -p0_2.Z) * v268), -(-p0_2.Z + (-v269.Z - -p0_2.Z) * v268)))
                            else
                                v259 = pos_2
                            end
                        else
                            v259 = pos_2
                        end
                        if v267 >= 1 then
                            value_27.view = nil
                        end
                    end
                else
                    v259 = pos_2
                end
                value_27.spinA = ((value_27.spinA or 0) + math.min(a1 * 30, 0.3490658503988659)) % math.tau
                local v270 = CFrame.Angles(0, value_27.spinA, 0)
                local v271 = value_27.view
                if not (v271) or not (v271.t0 > 0) then
                    v260 = 0
                    v271 = Vector3.new(value_27.dir.X, 0, value_27.dir.Z)
                    if not (v260 > 0) or not (v271.Magnitude > 0.001) then
                        local model_3 = value_27.model
                        local v272 = CFrame.new(v259) * v270
                        if model_3:IsA("Model") then
                            model_3:PivotTo(v272)
                            continue
                        end
                        if model_3:IsA("BasePart") then
                            model_3.CFrame = v272
                            continue
                        end
                    end
                    local model_4 = value_27.model
                    local v273 = CFrame.lookAt(v259, v259 + v271) * CFrame.Angles(v260, 0, 0) * v270
                    if model_4:IsA("Model") then
                        model_4:PivotTo(v273)
                        continue
                    end
                    if model_4:IsA("BasePart") then
                        model_4.CFrame = v273
                        continue
                    end
                end
                v260 = (1 - math.clamp((v258 - v271.t0) / 0.12, 0, 1)) * 1.3089969389957472
                v271 = Vector3.new(value_27.dir.X, 0, value_27.dir.Z)
                if not (v260 > 0) or not (v271.Magnitude > 0.001) then
                    local model_3 = value_27.model
                    local v272 = CFrame.new(v259) * v270
                    if model_3:IsA("Model") then
                        model_3:PivotTo(v272)
                        continue
                    end
                    if model_3:IsA("BasePart") then
                        model_3.CFrame = v272
                        continue
                    end
                end
                local model_4 = value_27.model
                local v273 = CFrame.lookAt(v259, v259 + v271) * CFrame.Angles(v260, 0, 0) * v270
                if model_4:IsA("Model") then
                    model_4:PivotTo(v273)
                    continue
                end
                if model_4:IsA("BasePart") then
                    model_4.CFrame = v273
                end
            end
        else
            value_27.pos = value_27.pos + (value_27.dir * v259)
            value_27.traveled = value_27.traveled + v259
            if value_27.range <= value_27.traveled then
                value_27.back = true
            end
            local pos_2 = value_27.pos
            local view_3 = value_27.view
            if view_3 then
                local CurrentCamera_10 = workspace.CurrentCamera
                if v258 < view_3.at then
                    v259 = value_27.pos - Vector3.new(0, 10000, 0)
                else
                    if view_3.t0 == 0 then
                        view_3.t0 = v258
                        value_27.spinT0 = v258
                        local v266 = u31 and (u31())
                        if v266 and CurrentCamera_10 then
                            local CFrame_3 = CurrentCamera_10.CFrame
                            view_3.p0 = CFrame_3:PointToObjectSpace(CFrame_3.Position + ((v266 - CFrame_3.Position) * 4))
                        end
                    end
                    local v267 = math.clamp((v258 - view_3.t0) / 0.12, 0, 1)
                    local v268 = 1 - (1 - v267) * (1 - v267)
                    local p0_2 = view_3.p0
                    if p0_2 and CurrentCamera_10 then
                        local CFrame_4 = CurrentCamera_10.CFrame
                        local v269 = CFrame_4:PointToObjectSpace(value_27.pos)
                        if v269.Z < -0.05 and p0_2.Z < -0.05 then
                            local _ = -p0_2.Z
                            local v274 = -v269.Z
                            local v275 = -p0_2.Z + (-v269.Z - -p0_2.Z) * v268
                            v259 = CFrame_4:PointToWorldSpace(Vector3.new((p0_2.X / -p0_2.Z + (v269.X / -v269.Z - p0_2.X / -p0_2.Z) * v268) * (-p0_2.Z + (-v269.Z - -p0_2.Z) * v268), (p0_2.Y / -p0_2.Z + (v269.Y / -v269.Z - p0_2.Y / -p0_2.Z) * v268) * (-p0_2.Z + (-v269.Z - -p0_2.Z) * v268), -(-p0_2.Z + (-v269.Z - -p0_2.Z) * v268)))
                        else
                            v259 = pos_2
                        end
                    else
                        v259 = pos_2
                    end
                    if v267 >= 1 then
                        value_27.view = nil
                    end
                end
            else
                v259 = pos_2
            end
            value_27.spinA = ((value_27.spinA or 0) + math.min(a1 * 30, 0.3490658503988659)) % math.tau
            local v270 = CFrame.Angles(0, value_27.spinA, 0)
            local v271 = value_27.view
            if not (v271) or not (v271.t0 > 0) then
                v260 = 0
                v271 = Vector3.new(value_27.dir.X, 0, value_27.dir.Z)
                if not (v260 > 0) or not (v271.Magnitude > 0.001) then
                    local model_3 = value_27.model
                    local v272 = CFrame.new(v259) * v270
                    if model_3:IsA("Model") then
                        model_3:PivotTo(v272)
                        continue
                    end
                    if model_3:IsA("BasePart") then
                        model_3.CFrame = v272
                        continue
                    end
                end
                local model_4 = value_27.model
                local v273 = CFrame.lookAt(v259, v259 + v271) * CFrame.Angles(v260, 0, 0) * v270
                if model_4:IsA("Model") then
                    model_4:PivotTo(v273)
                    continue
                end
                if model_4:IsA("BasePart") then
                    model_4.CFrame = v273
                    continue
                end
            end
            v260 = (1 - math.clamp((v258 - v271.t0) / 0.12, 0, 1)) * 1.3089969389957472
            v271 = Vector3.new(value_27.dir.X, 0, value_27.dir.Z)
            if not (v260 > 0) or not (v271.Magnitude > 0.001) then
                local model_3 = value_27.model
                local v272 = CFrame.new(v259) * v270
                if model_3:IsA("Model") then
                    model_3:PivotTo(v272)
                    continue
                end
                if model_3:IsA("BasePart") then
                    model_3.CFrame = v272
                    continue
                end
            end
            local model_4 = value_27.model
            local v273 = CFrame.lookAt(v259, v259 + v271) * CFrame.Angles(v260, 0, 0) * v270
            if model_4:IsA("Model") then
                model_4:PivotTo(v273)
                continue
            end
            if model_4:IsA("BasePart") then
                model_4.CFrame = v273
            end
        end
    end
    if next(tbl_upv_45) ~= nil or not u51 then
        return
    end
    u51:Disconnect()
    u51 = nil
end
function tbl_upv_1.Chakram(a1, a2, a3, a4, a5, a6, a7)
    --[[
      name: Chakram
      line: 1963
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        template (copy, index: 3)
        prep (copy, index: 4)
        u2 (ref,  index: 5)
        tbl_upv_45 (copy, index: 6)
        u31 (ref,  index: 7)
        Util_upv_1 (copy, index: 8)
        u51 (ref,  index: 10)
        RunService_upv_1 (copy, index: 11)
        stepRings (copy, index: 12)
    ]]
    local v274 = (a7 ~= nil) and (a7 == LocalPlayer_upv_1.Character)
    local v275 = nil
    if not (v274) then
        v275 = workspace.CurrentCamera
        if tbl_upv_1.NEAR * 2 < (((not v275) and 0) or ((v275.CFrame.Position - a2).Magnitude)) then
            return
        end
    end
    local v276 = template("Projectiles/Chakram")
    if v276 then
        v275 = v276:Clone()
    else
        v275 = Instance.new("Part")
        v275.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 2)
        v275.Material = Enum.Material.SmoothPlastic
        v275.Color = Color3.fromRGB(90, 85, 80)
    end
    prep(v275)
    local v277 = CFrame.new(a2)
    if v275:IsA("Model") then
        v275:PivotTo(v277)
    elseif v275:IsA("BasePart") then
        v275.CFrame = v277
    end
    local FX_14 = workspace:FindFirstChild("FX")
    if FX_14 then
        u2 = FX_14
    end
    v275.Parent = u2
    local v278 = tbl_upv_45[a1]
    if v278 then
        v278.model:Destroy()
    end
    local tbl_46 = {view = 0, back = false, traveled = 0}
    tbl_46.model = v275
    tbl_46.shooter = a7
    tbl_46.pos = a2
    tbl_46.dir = a3.Unit
    tbl_46.speed = a4
    tbl_46.range = a5
    tbl_46.catch = a6
    tbl_46.born = os.clock()
    tbl_46.mine = v274
    local v279
    if v274 and u31 then
        Util_upv_1.InFirstPerson()
    end
    v279 = nil
    tbl_46.view = v279
    tbl_upv_45[a1] = tbl_46
    if (u51) then
        return
    end
    u51 = RunService_upv_1.Heartbeat:Connect(stepRings)
end
function tbl_upv_1.ChakramTurn(a1, a2)
    --[[
      name: ChakramTurn
      line: 1999
      upvalues:
        tbl_upv_45 (copy, index: 1)
    ]]
    local v280 = tbl_upv_45[a1]
    if not v280 then
        return
    end
    v280.back = true
    if not ((v280.pos - a2).Magnitude > 3) then
        return
    end
    v280.pos = a2
end
local function endRing(a1, a2, a3)
    --[[
      name: endRing
      line: 1855
      upvalues:
        tbl_upv_45 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
        fadeOut (copy, index: 3)
        Debris_upv_1 (copy, index: 4)
    ]]
    local v281 = tbl_upv_45[a1]
    if not v281 then
        return
    end
    tbl_upv_45[a1] = nil
    if a2 then
        if v281.mine and not (Util_upv_1.InFirstPerson()) then
            Util_upv_1.Sound("Knife_Ready", a3 or (v281.pos))
        end
        v281.model:Destroy()
    else
        if a3 then
            local model_5 = v281.model
            local v282 = CFrame.new(a3)
            if model_5:IsA("Model") then
                model_5:PivotTo(v282)
            elseif model_5:IsA("BasePart") then
                model_5.CFrame = v282
            end
            Util_upv_1.Sound("Knife_Thunk", a3)
        end
        fadeOut(v281.model, 0.3, 1.2)
        Debris_upv_1:AddItem(v281.model, 2)
    end
end
function tbl_upv_1.ChakramEnd(a1, a2, a3)
    --[[
      name: ChakramEnd
      line: 2010
      upvalues:
        endRing (copy, index: 1)
    ]]
    endRing(a1, a2, a3)
end
function tbl_upv_1.FirePatch(a1, a2, a3)
    --[[
      name: FirePatch
      line: 2016
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Quality_upv_1 (copy, index: 2)
        u2 (ref,  index: 3)
        Debris_upv_1 (copy, index: 4)
        Util_upv_1 (copy, index: 5)
    ]]
    local CurrentCamera_11 = workspace.CurrentCamera
    if tbl_upv_1.NEAR * 1.5 < (((not CurrentCamera_11) and 0) or ((CurrentCamera_11.CFrame.Position - a1).Magnitude)) then
        return
    end
    local v283 = ((Quality_upv_1.layers) and 3) or 2
    for n_3 = 1, v283 do
        local v284 = ((n_3 / v283) * math.pi) * 2 + math.random()
        local v285 = ((n_3 ~= 1) and (a2 * (0.3 + (0.4 * math.random())))) or 0
        local v286 = CFrame.new(a1 + Vector3.new(math.cos(v284) * v285, 0.3, math.sin(v284) * v285))
        local v287 = Color3.new()
        local v288 = Instance.new("Part")
        v288.Name = "PuffFX"
        v288.Anchored = true
        v288.CanCollide = false
        v288.CanQuery = false
        v288.CanTouch = false
        v288.CastShadow = false
        v288.Size = Vector3.new(1.2000000476837158, 0.4000000059604645, 1.2000000476837158)
        v288.CFrame = v286
        v288.Color = v287
        v288.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
        v288.Transparency = 1
        local FX_15 = workspace:FindFirstChild("FX")
        if FX_15 then
            u2 = FX_15
        end
        v288.Parent = u2
        local u52 = Instance.new("ParticleEmitter")
        u52.Texture = "rbxasset://textures/particles/fire_main.dds"
        u52.Color = ColorSequence.new(Color3.fromRGB(255, 190, 80), Color3.fromRGB(235, 90, 30))
        u52.LightEmission = 0.35
        u52.LightInfluence = 0.3
        u52.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(0.4, 2.2), NumberSequenceKeypoint.new(1, 0)})
        u52.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(1, 1)})
        u52.Lifetime = NumberRange.new(0.5, 0.8)
        u52.Speed = NumberRange.new(2, 4)
        u52.SpreadAngle = Vector2.new(10, 10)
        u52.EmissionDirection = Enum.NormalId.Top
        u52.Rotation = NumberRange.new(-20, 20)
        u52.Rate = 12 * Quality_upv_1.particleScale
        u52.Shape = Enum.ParticleEmitterShape.Box
        u52.Parent = v288
        task.delay(
            a3,
            function()
                --[[
                  line: 2040
                  upvalues:
                    u52 (copy, index: 1)
                ]]
                u52.Enabled = false
            end
        )
        Debris_upv_1:AddItem(v288, a3 + 1)
    end
    Util_upv_1.Sound("FireBomb_Fuse", a1)
end
function tbl_upv_1.Wall(a1, a2, a3, a4)
    --[[
      name: Wall
      line: 2049
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    local CurrentCamera_12 = workspace.CurrentCamera
    if tbl_upv_1.NEAR * 1.5 < (((not CurrentCamera_12) and 0) or ((CurrentCamera_12.CFrame.Position - a1).Magnitude)) then
        return
    end
    local v289 = Color3.fromRGB(150, 108, 68)
    if a2 ~= "Hit" then
        local v290 = a1 - Vector3.new(0, (a4 / 2) - 0.3, 0)
        if a2 ~= "Place" then
            Util_upv_1.Sound("Impact_Wood", a1)
            if a2 == "Break" then
                Util_upv_1.Sound("Hit_Melee_Heavy", a1)
            end
            tbl_upv_1.Puff(v290, Color3.fromRGB(170, 150, 120), 10, 1.2, 6, 0.7)
            tbl_upv_1.Puff(a1, v289, ((a2 ~= "Break") and 8) or 16, 0.6, 11, 0.7)
        else
            Util_upv_1.Sound("Impact_Wood", a1)
            Util_upv_1.Sound("Trap_Set", a1)
            tbl_upv_1.Puff(v290, Color3.fromRGB(170, 150, 120), 12, 1.1, 7, 0.6)
        end
    else
        Util_upv_1.Sound("Impact_Wood", a1)
        tbl_upv_1.Puff(a1, v289, 5, 0.5, 6, 0.4)
    end
end
function tbl_upv_1.HealPool(a1, a2, a3)
    --[[
      name: HealPool
      line: 2078
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
        u2 (ref,  index: 3)
        TweenService_upv_1 (copy, index: 4)
        Debris_upv_1 (copy, index: 5)
        Quality_upv_1 (copy, index: 6)
    ]]
    local CurrentCamera_13 = workspace.CurrentCamera
    local v291 = tbl_upv_1.NEAR < (((not CurrentCamera_13) and 0) or ((CurrentCamera_13.CFrame.Position - a1).Magnitude))
    local u53 = Util_upv_1.WorldParams(Util_upv_1.Targets())
    local v292 = workspace:Raycast(a1 + Vector3.new(0, 1.5, 0), Vector3.new(0, -(a2 + 1.5), 0), u53)
    local v293, v294
    if v292 then
        v293 = v292.Position
        v294 = v292.Normal
    else
        v293, v294 = nil, nil
    end
    u53 = v293 or a1
    Util_upv_1.Sound("FireBomb_Shatter", u53)
    tbl_upv_1.Burst("Heal_Health", CFrame.new(u53 + Vector3.new(0, 1, 0)), 1.6)
    local v295 = v294 or Vector3.new(0, 1, 0)
    local u54 = CFrame.lookAt(u53 + (v295 * 0.12), u53 + (v295 * 1.12)) * CFrame.Angles(0, 1.5707963267948966, 0)
    local function disc(a4, a5, a6, a7, a8)
        --[[
          name: disc
          line: 2087
          upvalues:
            u54 (copy, index: 1)
            u2 (ref,  index: 2)
            TweenService_upv_1 (copy, index: 3)
            a3 (copy, index: 4)
            Debris_upv_1 (copy, index: 5)
        ]]
        local v296 = Vector3.new(0.08, a5, a5)
        local v297 = u54 * CFrame.new(a8, 0, 0)
        local v298 = Instance.new("Part")
        v298.Name = a4
        v298.Anchored = true
        v298.CanCollide = false
        v298.CanQuery = false
        v298.CanTouch = false
        v298.CastShadow = false
        v298.Size = v296
        v298.CFrame = v297
        v298.Color = a6
        v298.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
        v298.Transparency = a7 or 0
        local FX_16 = workspace:FindFirstChild("FX")
        if FX_16 then
            u2 = FX_16
        end
        v298.Parent = u2
        v298.Shape = Enum.PartType.Cylinder
        local tbl_47 = {Transparency = 1}
        TweenService_upv_1:Create(v298, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, math.max(0, a3 - 0.3)), tbl_47):Play()
        Debris_upv_1:AddItem(v298, a3 + 0.4)
        return v298
    end
    disc("HealPoolRim", a2 * 2, Color3.fromRGB(58, 132, 70), 0.55, 0)
    disc("HealPool", (a2 * 2) - 0.9, Color3.fromRGB(96, 178, 96), 0.72, 0.02)
    if v291 then
        return
    end
    local v299 = Vector3.new(a2 * 1.5, 0.4, a2 * 1.5)
    local v300 = CFrame.new(u53 + Vector3.new(0, 0.6000000238418579, 0))
    local v301 = Color3.new()
    local v302 = Instance.new("Part")
    v302.Name = "PuffFX"
    v302.Anchored = true
    v302.CanCollide = false
    v302.CanQuery = false
    v302.CanTouch = false
    v302.CastShadow = false
    v302.Size = v299
    v302.CFrame = v300
    v302.Color = v301
    v302.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
    v302.Transparency = 1
    local FX_17 = workspace:FindFirstChild("FX")
    if FX_17 then
        u2 = FX_17
    end
    v302.Parent = u2
    u53 = Instance.new("ParticleEmitter")
    u53.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    u53.Color = ColorSequence.new(Color3.fromRGB(120, 220, 110))
    u53.LightEmission = 0.3
    u53.LightInfluence = 0.5
    u53.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.34), NumberSequenceKeypoint.new(1, 0)})
    u53.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(1, 1)})
    u53.Lifetime = NumberRange.new(0.8, 1.3)
    u53.Speed = NumberRange.new(2, 4)
    u53.SpreadAngle = Vector2.new(12, 12)
    u53.EmissionDirection = Enum.NormalId.Top
    u53.Shape = Enum.ParticleEmitterShape.Box
    u53.Rate = 34 * Quality_upv_1.particleScale
    u53.Parent = v302
    task.delay(
        a3,
        function()
            --[[
              line: 2114
              upvalues:
                u53 (copy, index: 1)
            ]]
            u53.Enabled = false
        end
    )
    Debris_upv_1:AddItem(v302, a3 + 1.5)
end
local tbl_upv_48 = {}
local tbl_upv_49 = {}
local u55 = nil
local u56 = Color3.fromRGB(122, 104, 84)
local function caltropModel()
    --[[
      name: caltropModel
      line: 2132
      upvalues:
        template (copy, index: 1)
        prep (copy, index: 2)
        u2 (ref,  index: 3)
    ]]
    local v303 = template("Caltrop")
    if v303 then
        local v304 = v303:Clone()
        prep(v304)
        return v304
    else
        local v305 = Instance.new("Model")
        local v306 = CFrame.new(0, 0.12, 0)
        local v307 = Color3.fromRGB(70, 68, 66)
        local v308 = Instance.new("Part")
        v308.Name = "Root"
        v308.Anchored = true
        v308.CanCollide = false
        v308.CanQuery = false
        v308.CanTouch = false
        v308.CastShadow = false
        v308.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
        v308.CFrame = v306
        v308.Color = v307
        v308.Material = Enum.Material.Metal or (Enum.Material.SmoothPlastic)
        v308.Transparency = 0
        local FX_18 = workspace:FindFirstChild("FX")
        if FX_18 then
            u2 = FX_18
        end
        v308.Parent = u2
        v308.Parent = v305
        v305.PrimaryPart = v308
        for key_11, value_28 in {Vector3.new(0, 1, 0), Vector3.new(0.9399999976158142, -0.33000001311302185, 0), Vector3.new(-0.4699999988079071, -0.33000001311302185, 0.8199999928474426), Vector3.new(-0.4699999988079071, -0.33000001311302185, -0.8199999928474426)} do
            local v309 = CFrame.lookAt(v308.Position + (value_28 * 0.18), v308.Position + value_28)
            local v310 = Color3.fromRGB(86, 84, 82)
            local v311 = Instance.new("Part")
            v311.Name = "Point" .. key_11
            v311.Anchored = true
            v311.CanCollide = false
            v311.CanQuery = false
            v311.CanTouch = false
            v311.CastShadow = false
            v311.Size = Vector3.new(0.07000000029802322, 0.07000000029802322, 0.41999998688697815)
            v311.CFrame = v309
            v311.Color = v310
            v311.Material = Enum.Material.Metal or (Enum.Material.SmoothPlastic)
            v311.Transparency = 0
            local FX_19 = workspace:FindFirstChild("FX")
            if FX_19 then
                u2 = FX_19
            end
            v311.Parent = u2
            v311.Parent = v305
        end
        return v305
    end
end
local function stepCaltrops()
    --[[
      name: stepCaltrops
      line: 2151
      upvalues:
        tbl_upv_49 (copy, index: 1)
        u55 (ref,  index: 2)
    ]]
    local v312 = os.clock()
    for n_4 = #tbl_upv_49, 1, -1 do
        local v313 = tbl_upv_49[n_4]
        if not (v313.model.Parent) then
            table.remove(tbl_upv_49, n_4)
            continue
        end
        local v314 = math.clamp((v312 - v313.t0) / v313.dur, 0, 1)
        local v315 = 1 - (1 - v314) * (1 - v314)
        local v316 = 1 - v315
        v313.model:PivotTo((CFrame.new(v313.from:Lerp(v313.to.Position, v315) + Vector3.new(0, ((v313.hop * 4) * v314) * (1 - v314), 0)) * v313.to.Rotation) * CFrame.Angles(v313.tumble.X * v316, v313.tumble.Y * v316, v313.tumble.Z * v316))
        if v314 >= 1 then
            table.remove(tbl_upv_49, n_4)
        end
    end
    if #tbl_upv_49 ~= 0 or not u55 then
        return
    end
    u55:Disconnect()
    u55 = nil
end
local function caltropsGone(a1, a2)
    --[[
      name: caltropsGone
      line: 2175
      upvalues:
        tbl_upv_48 (copy, index: 1)
        TweenService_upv_1 (copy, index: 2)
        Debris_upv_1 (copy, index: 3)
    ]]
    local v317 = tbl_upv_48[a1]
    if not v317 then
        return
    end
    tbl_upv_48[a1] = nil
    for _, value_29 in v317.items do
        if not (value_29.Parent) then
            continue
        end
        local v318 = ((value_29:IsA("BasePart")) and {value_29}) or (value_29:GetDescendants())
        for v320, value_30 in v318 do
            if value_30:IsA("BasePart") then
                local v319 = TweenInfo.new(a2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                local tbl_50 = {Transparency = 1}
                tbl_50.CFrame = value_30.CFrame - Vector3.new(0, 0.25, 0)
                TweenService_upv_1:Create(value_30, v319, tbl_50):Play()
                continue
            end
            if value_30:IsA("SurfaceGui") then
                value_30.Enabled = false
            end
        end
        Debris_upv_1:AddItem(value_29, a2 + 0.1)
    end
end
function tbl_upv_1.Caltrops(a1)
    --[[
      name: Caltrops
      line: 2200
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_48 (copy, index: 2)
        caltropsGone (copy, index: 3)
        Util_upv_1 (copy, index: 4)
        u2 (ref,  index: 5)
        TweenService_upv_1 (copy, index: 6)
        u56 (copy, index: 7)
        Quality_upv_1 (copy, index: 8)
        caltropModel (copy, index: 9)
        tbl_upv_49 (copy, index: 10)
        u55 (ref,  index: 11)
        RunService_upv_1 (copy, index: 12)
        stepCaltrops (copy, index: 13)
    ]]
    local num_upv_1 = tonumber(a1.id)
    local position_1 = a1.position
    if not num_upv_1 or typeof(position_1) ~= "Vector3" then
        return
    end
    local v320 = tonumber(a1.radius) or 3.5
    local v321 = tonumber(a1.duration) or 15
    local v322
    if typeof(a1.from) ~= "Vector3" then
        v322 = position_1
    else
        v322 = a1.from
    end
    local v323 = Random.new(tonumber(a1.seed) or num_upv_1)
    local CurrentCamera_14 = workspace.CurrentCamera
    local v324 = tbl_upv_1.NEAR < (((not CurrentCamera_14) and 0) or ((CurrentCamera_14.CFrame.Position - position_1).Magnitude))
    if tbl_upv_48[num_upv_1] then
        caltropsGone(num_upv_1, 0)
    end
    local tbl_upv_51 = {}
    tbl_upv_48[num_upv_1] = {items = tbl_upv_51, token = num_upv_1}
    local v325 = a1.attacker
    local v326 = (typeof(v325) == "Instance") and (Util_upv_1.IsEnemy(v325))
    if v326 then
        v325 = Color3.fromRGB(196, 70, 64)
    else
        v325 = Color3.fromRGB(70, 132, 196)
    end
    local v327 = workspace:Raycast((position_1 + Vector3.new(0, 0.5, 0)) + Vector3.new(0, 1.5, 0), Vector3.new(0, -4.5, 0), Util_upv_1.WorldParams(Util_upv_1.Targets()))
    local v328, v329
    if v327 then
        v328 = v327.Position
        v329 = v327.Normal
    else
        v328, v329 = nil, nil
    end
    local u57 = v328 or position_1
    local u58 = v329 or Vector3.new(0, 1, 0)
    local u59 = CFrame.lookAt(u57 + (u58 * 0.06), u57 + (u58 * 1.06)) * CFrame.Angles(0, 1.5707963267948966, 0)
    local function disc_2(a2, a3, a4, a5, a6)
        --[[
          name: disc
          line: 2225
          upvalues:
            u59 (copy, index: 1)
            u2 (ref,  index: 2)
            TweenService_upv_1 (copy, index: 3)
            tbl_upv_51 (copy, index: 4)
        ]]
        local v330 = Vector3.new(0.05, a3, a3)
        local v331 = u59 * CFrame.new(a6, 0, 0)
        local v332 = Instance.new("Part")
        v332.Name = a2
        v332.Anchored = true
        v332.CanCollide = false
        v332.CanQuery = false
        v332.CanTouch = false
        v332.CastShadow = false
        v332.Size = v330
        v332.CFrame = v331
        v332.Color = a4
        v332.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
        v332.Transparency = 1
        local FX_20 = workspace:FindFirstChild("FX")
        if FX_20 then
            u2 = FX_20
        end
        v332.Parent = u2
        v332.Shape = Enum.PartType.Cylinder
        local tbl_52 = {}
        tbl_52.Transparency = a5
        TweenService_upv_1:Create(v332, TweenInfo.new(0.25), tbl_52):Play()
        table.insert(tbl_upv_51, v332)
    end
    disc_2("CaltropsRing", v320 * 2, v325, 0.72, 0)
    disc_2("CaltropsDirt", (v320 * 2) - 0.5, u56, 0.82, 0.01)
    v325 = (v324 and 10) or ((Quality_upv_1.layers and 18) or 13)
    local v333 = os.clock()
    local v334, v335 = nil, nil
    for n_5 = 1, v325 do
        local v336 = n_5 * 2.39996 + v323:NextNumber(-0.35, 0.35)
        local v337 = (v320 * 0.92) * math.sqrt((n_5 - 0.4) / v325) * v323:NextNumber(0.88, 1.04)
        local v338 = u57 + Vector3.new(math.cos(v336) * v337, 0, math.sin(v336) * v337)
        local v339 = workspace:Raycast((v338 + Vector3.new(0, 1, 0)) + Vector3.new(0, 1.5, 0), Vector3.new(0, -4.5, 0), Util_upv_1.WorldParams(Util_upv_1.Targets()))
        if v339 then
            v334 = v339.Position
            v335 = v339.Normal
        else
            v334, v335 = nil, nil
        end
        local v340 = v334 or v338
        v334 = v335 or u58
        v335 = v323:NextNumber(0, math.tau)
        local v341 = Vector3.new(math.cos(v335), 0, math.sin(v335))
        local v342 = v341 - v334 * v341:Dot(v334)
        v335 = CFrame.lookAt(v340, v340 + (((v342.Magnitude < 0.05) and Vector3.new(1, 0, 0)) or v342).Unit, v334) * CFrame.Angles(0, 0, math.rad(v323:NextNumber(-8, 8)))
        local v343 = caltropModel()
        v334 = v323:NextNumber(0.9, 1.12)
        if v343:IsA("Model") and v334 ~= 1 then
            v343:ScaleTo(v334)
        end
        v343:PivotTo(CFrame.new(v322) * v335.Rotation)
        v334 = workspace:FindFirstChild("FX")
        if v334 then
            u2 = v334
        end
        v343.Parent = u2
        table.insert(tbl_upv_51, v343)
        if v324 then
            v343:PivotTo(v335)
        else
            table.insert(tbl_upv_49, {model = v343, from = v322, to = v335, t0 = v333 + v323:NextNumber(0, 0.03), dur = 0.14 + (0.16 * (v337 / math.max(v320, 0.1))) + v323:NextNumber(0, 0.04), hop = 0.5 + v323:NextNumber(0, 0.9), tumble = Vector3.new(v323:NextNumber(-7, 7), v323:NextNumber(-5, 5), v323:NextNumber(-7, 7))})
        end
    end
    if not (v324) then
        if not (u55) then
            u55 = RunService_upv_1.Heartbeat:Connect(stepCaltrops)
        end
        Util_upv_1.Sound("Caltrops_Scatter", v322)
        tbl_upv_1.Puff(v322, Color3.fromRGB(150, 132, 108), 7, 0.7, 7, 0.45)
        task.delay(
            0.22,
            function()
                --[[
                  line: 2278
                  upvalues:
                    tbl_upv_48 (copy, index: 1)
                    num_upv_1 (copy, index: 2)
                    num_upv_1 (copy, index: 3)
                    tbl_upv_1 (copy, index: 4)
                    u57 (copy, index: 5)
                    u58 (copy, index: 6)
                ]]
                if not tbl_upv_48[num_upv_1] or tbl_upv_48[num_upv_1].token ~= num_upv_1 then
                    return
                end
                tbl_upv_1.Puff(u57 + (u58 * 0.3), Color3.fromRGB(150, 132, 108), 9, 1.1, 4, 0.55)
            end
        )
    end
    task.delay(
        v321,
        function()
            --[[
              line: 2284
              upvalues:
                tbl_upv_48 (copy, index: 1)
                num_upv_1 (copy, index: 2)
                num_upv_1 (copy, index: 3)
                caltropsGone (copy, index: 4)
            ]]
            local v344 = tbl_upv_48[num_upv_1]
            if not v344 or v344.token ~= num_upv_1 then
                return
            end
            caltropsGone(num_upv_1, 0.45)
        end
    )
end
function tbl_upv_1.CaltropsEnd(a1)
    --[[
      name: CaltropsEnd
      line: 2292
      upvalues:
        caltropsGone (copy, index: 1)
    ]]
    caltropsGone(a1, 0.35)
end
function tbl_upv_1.CaltropStep(a1)
    --[[
      name: CaltropStep
      line: 2297
      upvalues:
        Util_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local v345 = Util_upv_1.Drawn(a1)
    local v346
    if (v345) and (v345:IsA("Model")) then
        v346 = v345
    else
        v346 = a1
    end
    local v347 = v346:FindFirstChild("RightFoot") or (v346:FindFirstChild("LeftFoot") or (v346:FindFirstChild("HumanoidRootPart")))
    if not v347 then
        return
    end
    if v347:IsA("BasePart") then
        Util_upv_1.Sound("Caltrops_Step", v347)
        local CurrentCamera_15 = workspace.CurrentCamera
        if (((not CurrentCamera_15) and 0) or ((CurrentCamera_15.CFrame.Position - v347.Position).Magnitude)) <= tbl_upv_1.NEAR then
            tbl_upv_1.Burst("Block_Spark", CFrame.new(v347.Position - Vector3.new(0, 0.30000001192092896, 0)), 0.45, Color3.fromRGB(196, 150, 110))
        end
    end
end
function tbl_upv_1.Death(a1, a2, a3, a4)
    --[[
      name: Death
      line: 2310
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    tbl_upv_1.Burst("Death_Burst", CFrame.new(a1))
    Util_upv_1.Sound("Death_Poof", a1)
    tbl_upv_1.KillFlourish(a1, a3, a2 == true, a4 == true)
    if not a2 then
        return
    end
    Util_upv_1.Shake(0.5, 0.25)
end
local function fling(a1, a2, a3, a4, a5, a6)
    --[[
      name: fling
      line: 2324
      upvalues:
        u2 (ref,  index: 1)
        RunService_upv_1 (copy, index: 2)
    ]]
    local tbl_upv_53 = {}
    for key_12, value_31 in a2 do
        local v348 = Vector3.new(math.random() - 0.5, 0, math.random() - 0.5)
        tbl_upv_53[key_12] = ((((not (v348.Magnitude > 0.01)) and Vector3.new(1, 0, 0)) or (v348.Unit)) * a3) * (0.6 + (math.random() * 0.6)) + Vector3.new(0, a4 * (0.7 + (math.random() * 0.6)), 0)
        value_31.CFrame = CFrame.new(a1) * CFrame.Angles(math.random() * 6, math.random() * 6, math.random() * 6)
        local FX_21 = workspace:FindFirstChild("FX")
        if FX_21 then
            u2 = FX_21
        end
        value_31.Parent = u2
    end
    local u60 = os.clock()
    local u61 = nil
    local v349 = RunService_upv_1.RenderStepped:Connect(
        function()
            --[[
              line: 2335
              upvalues:
                u60 (copy, index: 1)
                a5 (copy, index: 2)
                u61 (ref,  index: 3)
                a2 (copy, index: 4)
                a1 (copy, index: 5)
                tbl_upv_53 (copy, index: 6)
                a6 (copy, index: 7)
            ]]
            local v350 = os.clock() - u60
            if a5 <= v350 then
                u61:Disconnect()
                for _, value_32 in a2 do
                    value_32:Destroy()
                end
            else
                local v351 = nil
                for key_13, value_33 in a2 do
                    local v352 = a1 + (tbl_upv_53[key_13] * v350) + Vector3.new(0, (-30 * v350) * v350, 0)
                    if a6 then
                        v351 = CFrame.Angles((v350 * 9) + key_13, v350 * 7, 0)
                    else
                        v351 = value_33.CFrame.Rotation
                    end
                    value_33.CFrame = CFrame.new(v352) * v351
                    value_33.Transparency = math.clamp((v350 / a5 - 0.5) / 0.5, 0, 1)
                end
            end
        end
    )
    u61 = v349
end
local tbl_upv_54 = {Crossbow = "feathers", Axe = "stars", Sword = "slash", Spear = "slash", Knives = "feathers", Club = "stars", Gauntlets = "stars", Blunderbuss = "powder", Bow = "feathers", Musket = "powder", Fists = "stars", Katana = "slash", Javelin = "feathers", Trap = "sparks", Bomb = "embers", Sling = "chips", Scythe = "slash", Dagger = "slash", Pistol = "powder", Hatchets = "stars"}
function tbl_upv_1.KillFlourish(a1, a2, a3, a4)
    --[[
      name: KillFlourish
      line: 2362
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_54 (copy, index: 2)
        Combat_upv_1 (copy, index: 3)
        u2 (ref,  index: 4)
        fling (copy, index: 5)
        Util_upv_1 (copy, index: 6)
        groundDecal (copy, index: 7)
        RunService_upv_1 (copy, index: 8)
        TweenService_upv_1 (copy, index: 9)
        Debris_upv_1 (copy, index: 10)
    ]]
    local CurrentCamera_16 = workspace.CurrentCamera
    if tbl_upv_1.NEAR < (((not CurrentCamera_16) and 0) or ((CurrentCamera_16.CFrame.Position - a1).Magnitude)) then
        return
    end
    local v353 = tbl_upv_54[Combat_upv_1.Kind(a2) or ""] or "none"
    local v354 = a1 + Vector3.new(0, 1.5, 0)
    local v355 = (a3 and 1.25) or 1
    if v353 == "feathers" then
        local tbl_55 = {}
        for n_6 = 1, 7 do
            local v356
            if n_6 % 3 ~= 0 then
                v356 = Color3.fromRGB(178, 58, 44)
            else
                v356 = Color3.fromRGB(220, 208, 186)
            end
            local v357 = CFrame.new(v354)
            local v358 = Instance.new("Part")
            v358.Name = "KillFeather"
            v358.Anchored = true
            v358.CanCollide = false
            v358.CanQuery = false
            v358.CanTouch = false
            v358.CastShadow = false
            v358.Size = Vector3.new(0.05999999865889549, 0.699999988079071, 0.2199999988079071) * v355
            v358.CFrame = v357
            v358.Color = v356
            v358.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
            v358.Transparency = 0
            local FX_22 = workspace:FindFirstChild("FX")
            if FX_22 then
                u2 = FX_22
            end
            v358.Parent = u2
            table.insert(tbl_55, v358)
        end
        fling(v354, tbl_55, 9, 10, 0.9, true)
        Util_upv_1.Sound("Arrow_Flesh", a1, {PlaybackSpeed = 0.8, Volume = 0.6})
    elseif v353 == "powder" then
        tbl_upv_1.Puff(v354, Color3.fromRGB(70, 64, 60), 14, v355 * 1.6, 14, 1.1)
        tbl_upv_1.Burst("Impact_Sparks", CFrame.new(v354), v355 * 1.3, Color3.fromRGB(255, 150, 60), true)
        groundDecal(a1 - Vector3.new(0, 2.799999952316284, 0), Vector3.new(0, 1, 0), "rbxassetid://10871117278", Color3.fromRGB(60, 50, 44), 2, v355 * 9, 0.3, 0.3)
    elseif v353 == "stars" then
        local tbl_upv_56 = {}
        for n_7 = 1, 4 do
            local v359 = CFrame.new(v354)
            local v360 = Color3.fromRGB(250, 205, 70)
            local v361 = Instance.new("Part")
            v361.Name = "BonkStar"
            v361.Anchored = true
            v361.CanCollide = false
            v361.CanQuery = false
            v361.CanTouch = false
            v361.CastShadow = false
            v361.Size = Vector3.new(0.5, 0.5, 0.11999999731779099) * v355
            v361.CFrame = v359
            v361.Color = v360
            v361.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
            v361.Transparency = 0
            local FX_23 = workspace:FindFirstChild("FX")
            if FX_23 then
                u2 = FX_23
            end
            v361.Parent = u2
            v361.Shape = Enum.PartType.Block
            table.insert(tbl_upv_56, v361)
            local u62 = n_7
        end
        local u63 = a1 + Vector3.new(0, 2.5999999046325684, 0)
        local u64 = os.clock()
        local u62 = nil
        local v362 = RunService_upv_1.RenderStepped:Connect(
            function()
                --[[
                  line: 2392
                  upvalues:
                    u64 (copy, index: 1)
                    u62 (ref,  index: 2)
                    tbl_upv_56 (copy, index: 3)
                    u63 (copy, index: 4)
                ]]
                local v363 = os.clock() - u64
                if v363 > 0.9 then
                    u62:Disconnect()
                    for _, value_34 in tbl_upv_56 do
                        value_34:Destroy()
                    end
                else
                    for key_14, value_35 in tbl_upv_56 do
                        local v364 = v363 * 9 + (key_14 * math.pi) / 2
                        value_35.CFrame = CFrame.new(u63 + Vector3.new(math.cos(v364) * 1.3, (math.sin((v363 * 12) + key_14) * 0.15) + 0.2, math.sin(v364) * 1.3)) * CFrame.Angles(0, 0, v364 * 2)
                        value_35.Transparency = math.clamp((v363 - 0.6) / 0.3, 0, 1)
                    end
                end
            end
        )
        u62 = v362
        Util_upv_1.Sound("Hit_Punch", a1, {PlaybackSpeed = 0.75})
    elseif v353 == "slash" then
        for n_8 = -1, 1, 2 do
            local v365 = Vector3.new(0.25, v355 * 4.5, 0.1)
            local v366 = CFrame.lookAt(v354, workspace.CurrentCamera.CFrame.Position) * CFrame.Angles(0, 0, math.rad(n_8 * 40))
            local v367 = Color3.fromRGB(215, 70, 50)
            local v368 = Instance.new("Part")
            v368.Name = "KillSlash"
            v368.Anchored = true
            v368.CanCollide = false
            v368.CanQuery = false
            v368.CanTouch = false
            v368.CastShadow = false
            v368.Size = v365
            v368.CFrame = v366
            v368.Color = v367
            v368.Material = Enum.Material.SmoothPlastic or (Enum.Material.SmoothPlastic)
            v368.Transparency = 0
            local FX_24 = workspace:FindFirstChild("FX")
            if FX_24 then
                u2 = FX_24
            end
            v368.Parent = u2
            v368.Transparency = 0.1
            local v369 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tbl_57 = {Transparency = 1}
            tbl_57.Size = Vector3.new(0.05, v355 * 6, 0.1)
            TweenService_upv_1:Create(v368, v369, tbl_57):Play()
            Debris_upv_1:AddItem(v368, 0.4)
        end
    elseif v353 == "chips" then
        local tbl_58 = {}
        for _ = 1, 6 do
            local v370 = CFrame.new(v354)
            local v371 = Color3.fromRGB(128, 124, 118)
            local v372 = Instance.new("Part")
            v372.Name = "KillChip"
            v372.Anchored = true
            v372.CanCollide = false
            v372.CanQuery = false
            v372.CanTouch = false
            v372.CastShadow = false
            v372.Size = Vector3.new(0.30000001192092896, 0.30000001192092896, 0.30000001192092896) * v355
            v372.CFrame = v370
            v372.Color = v371
            v372.Material = Enum.Material.Slate or (Enum.Material.SmoothPlastic)
            v372.Transparency = 0
            local FX_25 = workspace:FindFirstChild("FX")
            if FX_25 then
                u2 = FX_25
            end
            v372.Parent = u2
            table.insert(tbl_58, v372)
        end
        fling(v354, tbl_58, 8, 9, 0.8, true)
    elseif v353 == "embers" then
        tbl_upv_1.Burst("Impact_Sparks", CFrame.new(v354), v355 * 1.5, Color3.fromRGB(255, 140, 50), true)
    elseif v353 == "sparks" then
        tbl_upv_1.Burst("Impact_Sparks", CFrame.new(a1), v355 * 1.2)
    end
    if not a4 then
        return
    end
    tbl_upv_1.CritStar(a1 + Vector3.new(0, 1.5, 0))
end
local u65 = nil
local u66 = nil
local u67 = nil
local u68 = nil
local function beamProjectile(a1, a2, a3, a4)
    --[[
      name: beamProjectile
      line: 2438
    ]]
    local v373 = (((a1 * 0.5) * a4) * a4) + (a2 * a4) + a3
    local v374 = v373 - (((a1 * a4) * a4) + (a2 * a4)) / 3
    local v375 = ((((((a1 * 0.125) * a4) * a4) + ((a2 * 0.5) * a4)) + a3) - ((a3 + v373) * 0.125)) / 0.375 - v374
    local Unit_3 = (a3 - v373).Unit
    local Unit_4 = (v375 - a3).Unit
    local Unit_5 = Unit_4:Cross(Unit_3).Unit
    local Unit_6 = (v374 - v373).Unit
    local Unit_7 = Unit_6:Cross(Unit_3).Unit
    local Unit_8 = Unit_5:Cross(Unit_4).Unit
    return (v375 - a3).Magnitude, -(v374 - v373).Magnitude, CFrame.fromMatrix(a3, Unit_4, Unit_5, Unit_8), (CFrame.fromMatrix(v373, Unit_6, Unit_7, Unit_8))
end
function tbl_upv_1.Trajectory(a1, a2, a3, a4, a5)
    --[[
      name: Trajectory
      line: 2456
      upvalues:
        u65 (ref,  index: 1)
        u66 (ref,  index: 2)
        u2 (ref,  index: 3)
        u67 (ref,  index: 4)
        u68 (ref,  index: 5)
        Ballistics_upv_1 (copy, index: 6)
        Util_upv_1 (copy, index: 7)
        beamProjectile (copy, index: 8)
    ]]
    if a1 and a2 and a3 then
        local v376 = nil
        if not (u65) then
            local v377 = Instance.new("Attachment")
            v377.Name = "CombatTrajA"
            v377.Parent = workspace.Terrain
            local v378 = Instance.new("Attachment")
            v378.Name = "CombatTrajB"
            v378.Parent = workspace.Terrain
            local v379 = Instance.new("Beam")
            v379.Attachment0 = v377
            v379.Attachment1 = v378
            v379.Width0 = 0.2
            v379.Width1 = 0.2
            v379.Segments = 48
            v379.FaceCamera = true
            v379.LightEmission = 0.2
            v379.LightInfluence = 0.4
            v379.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(0.15, 0.3), NumberSequenceKeypoint.new(1, 0.2)})
            v379.Parent = workspace.Terrain
            local v380 = Instance.new("Part")
            v380.Name = "CombatTrajLanding"
            v380.Shape = Enum.PartType.Cylinder
            v380.Size = Vector3.new(0.11999999731779099, 3, 3)
            v380.Material = Enum.Material.SmoothPlastic
            v380.Transparency = 0.5
            v380.Anchored = true
            v380.CanCollide = false
            v380.CanQuery = false
            v380.CanTouch = false
            v380.CastShadow = false
            v376 = workspace:FindFirstChild("FX")
            if v376 then
                u2 = v376
            end
            v380.Parent = u2
            u66 = v380
            u65 = v379
            u67 = v377
            u68 = v378
        end
        local v381 = Ballistics_upv_1.new(a1, a2, a3, 0)
        local v382 = Util_upv_1.WorldParams(Util_upv_1.Teammates())
        local v383 = 3
        local v384 = 0
        local v385 = nil
        local v386, v387, v388 = nil, nil, nil
        for _ = 1, 90 do
            v386, v387 = Ballistics_upv_1.Advance(v381, 0.03333333333333333)
            v384 = v384 + 0.03333333333333333
            v388 = workspace:Raycast(v386, v387, v382)
            if v388 then
                v383, v385 = v384 - 0.03333333333333333 * (1 - ((v388.Position - v386).Magnitude / math.max(0.001, v387.Magnitude))), v388.Position
                break
            else
                continue
            end
        end
        local v389, v390, v391
        local v392, v393
        v392, v389, v393, v390, v391 = pcall(beamProjectile, Vector3.new(0, -a3, 0), a2, a1, math.max(0.05, v383))
        if v392 then
            u67.WorldCFrame = v390
            u68.WorldCFrame = v391
            u65.CurveSize0 = v389
            u65.CurveSize1 = v393
            local v394 = a4 or (Color3.fromRGB(255, 190, 90))
            u65.Color = ColorSequence.new(v394)
            u65.Enabled = true
            if u66 then
                local v395 = nil
                if not (u66.Parent) then
                    v395 = workspace:FindFirstChild("FX")
                    if v395 then
                        u2 = v395
                    end
                    u66.Parent = u2
                end
                if v385 then
                    local v396 = a5 or 3
                    u66.Size = Vector3.new(0.12, v396, v396)
                    u66.Color = a4 or Color3.fromRGB(255, 190, 90)
                    u66.Transparency = 0.5
                    u66.CFrame = CFrame.new(v385 + Vector3.new(0, 0.07999999821186066, 0)) * CFrame.Angles(0, 0, 1.5707963267948966)
                    return
                end
                u66.Transparency = 1
            end
        else
            u65.Enabled = false
        end
    else
        if u65 then
            u65.Enabled = false
        end
        if u66 then
            u66.Transparency = 1
        end
    end
end
return tbl_upv_1