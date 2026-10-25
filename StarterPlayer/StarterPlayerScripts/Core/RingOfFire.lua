local ContentProvider_upv_1 = game:GetService("ContentProvider")
local Lighting_upv_1 = game:GetService("Lighting")
local Players_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local TweenService_upv_1 = game:GetService("TweenService")
local Workspace_upv_1 = game:GetService("Workspace")
local tbl_1 = {}
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local tbl_upv_2 = {{height = 16, transparency = 0.3, speed = 0.045, tile = 34}, {height = 10.5, transparency = 0.38, speed = -0.07, tile = 21}}
local u1 = nil
local u2 = nil
local tbl_upv_3 = {}
local tbl_upv_4 = {}
local tbl_upv_5 = {}
local tbl_upv_6 = {}
local tbl_upv_7 = {}
local tbl_upv_8 = {}
local tbl_upv_9 = {}
local tbl_upv_10 = {}
local u3 = nil
local tbl_upv_11 = {}
local u4 = false
local u5 = -1
local u6 = 0
local u7 = 0
local u8 = -1
local u9 = -1
local u10 = nil
local u11 = false
local u12 = RaycastParams.new()
u12.FilterType = Enum.RaycastFilterType.Include
u12.RespectCanCollide = true
local u13 = "pending"
local function num(a1, a2, a3)
    --[[
      name: num
      line: 88
    ]]
    local v1 = a1:GetAttribute(a2)
    if type(v1) == "number" and v1 == v1 then
        return v1
    end
    return a3
end
local function styleBeams()
    --[[
      name: styleBeams
      line: 93
      upvalues:
        tbl_upv_8 (copy, index: 1)
        u13 (ref,  index: 2)
        tbl_upv_6 (copy, index: 3)
        tbl_upv_7 (copy, index: 4)
    ]]
    for key_1, value_1 in tbl_upv_8 do
        local v2 = value_1.visible and (u13 == "ok")
        for _, value_2 in tbl_upv_6 do
            value_2[key_1].Enabled = v2
        end
        tbl_upv_7[key_1].Enabled = value_1.visible
    end
end
local function emitter(a1, a2)
    --[[
      name: emitter
      line: 103
    ]]
    local v3 = Instance.new("ParticleEmitter")
    for key_2, value_3 in a2 do
        v3[key_2] = value_3
    end
    v3.Parent = a1
    return v3
end
local function invisiblePart(a1)
    --[[
      name: invisiblePart
      line: 112
    ]]
    local v4 = Instance.new("Part")
    v4.Name = a1
    v4.Anchored = true
    v4.CanCollide = false
    v4.CanQuery = false
    v4.CanTouch = false
    v4.CastShadow = false
    v4.Transparency = 1
    v4.Size = Vector3.new(8, 1, 1.5)
    return v4
end
local function clear()
    --[[
      name: clear
      line: 212
      upvalues:
        u1 (ref,  index: 1)
        u2 (ref,  index: 2)
        tbl_upv_3 (copy, index: 3)
        tbl_upv_4 (copy, index: 4)
        tbl_upv_5 (copy, index: 5)
        tbl_upv_6 (copy, index: 6)
        tbl_upv_7 (copy, index: 7)
        tbl_upv_8 (copy, index: 8)
        tbl_upv_9 (copy, index: 9)
        tbl_upv_10 (copy, index: 10)
        u5 (ref,  index: 11)
        u9 (ref,  index: 12)
        u8 (ref,  index: 13)
    ]]
    if u1 then
        u1:Destroy()
    end
    u1 = nil
    u2 = nil
    table.clear(tbl_upv_3)
    table.clear(tbl_upv_4)
    table.clear(tbl_upv_5)
    table.clear(tbl_upv_6)
    table.clear(tbl_upv_7)
    table.clear(tbl_upv_8)
    table.clear(tbl_upv_9)
    table.clear(tbl_upv_10)
    u5 = -1
    u9 = -1
    u8 = -1
end
local function makeBeam(a1, a2, a3)
    --[[
      name: makeBeam
      line: 231
    ]]
    local v5 = Instance.new("Beam")
    v5.Name = a3
    v5.Attachment0 = a1
    v5.Attachment1 = a2
    v5.FaceCamera = false
    v5.Segments = 1
    return v5
end
local function makeSegment(a1)
    --[[
      name: makeSegment
      line: 125
    ]]
    local v6 = Instance.new("Part")
    v6.Name = "RingSegment"
    v6.Anchored = true
    v6.CanCollide = false
    v6.CanQuery = false
    v6.CanTouch = false
    v6.CastShadow = false
    v6.Transparency = 1
    v6.Size = Vector3.new(8, 1, 1.5)
    local tbl_12 = {Drag = 1, ZOffset = 1, LightInfluence = 0, Texture = "rbxassetid://109193145976179", LightEmission = 0.35, Name = "Licks"}
    tbl_12.Shape = Enum.ParticleEmitterShape.Box
    tbl_12.EmissionDirection = Enum.NormalId.Top
    tbl_12.Orientation = Enum.ParticleOrientation.FacingCameraWorldUp
    tbl_12.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 236, 214)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 190, 150)), ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 120, 90))})
    tbl_12.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(0.18, 0.05), NumberSequenceKeypoint.new(0.7, 0.25), NumberSequenceKeypoint.new(1, 1)})
    tbl_12.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 4), NumberSequenceKeypoint.new(0.35, 7, 1.5), NumberSequenceKeypoint.new(1, 2.5)})
    tbl_12.Squash = NumberSequence.new(-0.35)
    tbl_12.Lifetime = NumberRange.new(0.8, 1.25)
    tbl_12.Speed = NumberRange.new(6, 10)
    tbl_12.SpreadAngle = Vector2.new(5, 5)
    tbl_12.Rotation = NumberRange.new(-8, 8)
    tbl_12.RotSpeed = NumberRange.new(-10, 10)
    local v7 = Instance.new("ParticleEmitter")
    for key_3, value_4 in tbl_12 do
        v7[key_3] = value_4
    end
    v7.Parent = v6
    local tbl_13 = {Acceleration = Vector3.new(0, 1.5, 0), Drag = 0.6, LightInfluence = 0, LightEmission = 0.4, Name = "Embers"}
    tbl_13.Shape = Enum.ParticleEmitterShape.Box
    tbl_13.EmissionDirection = Enum.NormalId.Top
    tbl_13.Color = ColorSequence.new(Color3.fromRGB(255, 150, 60), Color3.fromRGB(230, 70, 30))
    tbl_13.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.8, 0.2), NumberSequenceKeypoint.new(1, 1)})
    tbl_13.Size = NumberSequence.new(0.25, 0.08)
    tbl_13.Lifetime = NumberRange.new(1.6, 2.8)
    tbl_13.Speed = NumberRange.new(10, 18)
    tbl_13.SpreadAngle = Vector2.new(22, 22)
    local v8 = Instance.new("ParticleEmitter")
    for key_4, value_5 in tbl_13 do
        v8[key_4] = value_5
    end
    v8.Parent = v6
    tbl_13 = Instance.new("Part")
    tbl_13.Name = "RingSmoke"
    tbl_13.Anchored = true
    tbl_13.CanCollide = false
    tbl_13.CanQuery = false
    tbl_13.CanTouch = false
    tbl_13.CastShadow = false
    tbl_13.Transparency = 1
    tbl_13.Size = Vector3.new(8, 1, 1.5)
    local tbl_14 = {LightInfluence = 1, LightEmission = 0, Drag = 0.35, ZOffset = -1, Name = "Smoke", Texture = "rbxassetid://8030839542"}
    tbl_14.Shape = Enum.ParticleEmitterShape.Box
    tbl_14.EmissionDirection = Enum.NormalId.Top
    tbl_14.Color = ColorSequence.new(Color3.fromRGB(70, 55, 48), Color3.fromRGB(46, 40, 38))
    tbl_14.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0.55), NumberSequenceKeypoint.new(0.7, 0.7), NumberSequenceKeypoint.new(1, 1)})
    tbl_14.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 7), NumberSequenceKeypoint.new(1, 16)})
    tbl_14.Lifetime = NumberRange.new(2.6, 3.6)
    tbl_14.Speed = NumberRange.new(5, 7)
    tbl_14.SpreadAngle = Vector2.new(12, 12)
    tbl_14.Rotation = NumberRange.new(-180, 180)
    tbl_14.RotSpeed = NumberRange.new(-15, 15)
    local v9 = Instance.new("ParticleEmitter")
    for key_5, value_6 in tbl_14 do
        v9[key_5] = value_6
    end
    v9.Parent = tbl_13
    v6.Parent = a1
    tbl_13.Parent = a1
    tbl_14 = {visible = true}
    tbl_14.part = v6
    tbl_14.smokePart = tbl_13
    tbl_14.licks = v7
    tbl_14.embers = v8
    tbl_14.smoke = v9
    return tbl_14
end
local function build(a1, a2)
    --[[
      name: build
      line: 241
      upvalues:
        u2 (ref,  index: 1)
        tbl_upv_2 (copy, index: 2)
        tbl_upv_3 (copy, index: 3)
        tbl_upv_5 (copy, index: 4)
        tbl_upv_6 (copy, index: 5)
        tbl_upv_4 (copy, index: 6)
        tbl_upv_7 (copy, index: 7)
        tbl_upv_8 (copy, index: 8)
        makeSegment (copy, index: 9)
        tbl_upv_9 (copy, index: 10)
        tbl_upv_10 (copy, index: 11)
        Workspace_upv_1 (copy, index: 12)
        u1 (ref,  index: 13)
        styleBeams (copy, index: 14)
    ]]
    local v10 = Instance.new("Folder")
    v10.Name = "CoreRingOfFire"
    local v11 = Instance.new("Part")
    v11.Name = "RingAnchor"
    v11.Anchored = true
    v11.CanCollide = false
    v11.CanQuery = false
    v11.CanTouch = false
    v11.CastShadow = false
    v11.Transparency = 1
    v11.Size = Vector3.new(8, 1, 1.5)
    v11.Size = Vector3.new(1, 1, 1)
    v11.CFrame = CFrame.new(a2)
    v11.Parent = v10
    u2 = v11
    for key_6, value_7 in tbl_upv_2 do
        local tbl_15 = {}
        for n_1 = 1, a1 do
            local v12 = Instance.new("Attachment")
            v12.Name = ("L%*_%*"):format(key_6, n_1)
            v12.Parent = v11
            tbl_15[n_1] = v12
        end
        tbl_upv_3[key_6] = tbl_15
        local tbl_16 = {}
        for n_2 = 1, a1 do
            local v13 = ("Wall%*_%*"):format(key_6, n_2)
            local v14 = Instance.new("Beam")
            v14.Name = v13
            v14.Attachment0 = tbl_15[n_2]
            v14.Attachment1 = tbl_15[(n_2 % a1) + 1]
            v14.FaceCamera = false
            v14.Segments = 1
            v14.Width0 = value_7.height
            v14.Width1 = value_7.height
            v14.Texture = "rbxassetid://82559613851503"
            v14.TextureMode = Enum.TextureMode.Wrap
            v14.TextureLength = value_7.tile
            v14.TextureSpeed = value_7.speed
            v14.Color = ColorSequence.new(Color3.fromRGB(255, 240, 228))
            v14.Transparency = NumberSequence.new(value_7.transparency)
            v14.LightEmission = 0.25
            v14.LightInfluence = 0
            v14.Brightness = 1
            v14.ZOffset = key_6 - 1
            v14.Enabled = false
            v14.Parent = v11
            tbl_16[n_2] = v14
            table.insert(tbl_upv_5, v14)
        end
        tbl_upv_6[key_6] = tbl_16
    end
    for n_3 = 1, a1 do
        local v15 = Instance.new("Attachment")
        v15.Name = ("S_%*"):format(n_3)
        v15.Parent = v11
        tbl_upv_4[n_3] = v15
    end
    for n_4 = 1, a1 do
        local v16 = ("Scorch%*"):format(n_4)
        local v17 = Instance.new("Beam")
        v17.Name = v16
        v17.Attachment0 = tbl_upv_4[n_4]
        v17.Attachment1 = tbl_upv_4[(n_4 % a1) + 1]
        v17.FaceCamera = false
        v17.Segments = 1
        v17.Width0 = 3
        v17.Width1 = 3
        v17.Color = ColorSequence.new(Color3.fromRGB(36, 28, 25))
        v17.Transparency = NumberSequence.new(0.12)
        v17.LightEmission = 0
        v17.LightInfluence = 1
        v17.Parent = v11
        tbl_upv_7[n_4] = v17
    end
    for _ = 1, a1 do
        table.insert(tbl_upv_8, (makeSegment(v10)))
        table.insert(tbl_upv_9, 0)
        table.insert(tbl_upv_10, false)
    end
    v10.Parent = Workspace_upv_1
    u1 = v10
    styleBeams()
end
local function setTint(a1)
    --[[
      name: setTint
      line: 326
      upvalues:
        u11 (ref,  index: 1)
        u10 (ref,  index: 2)
        Lighting_upv_1 (copy, index: 3)
        TweenService_upv_1 (copy, index: 4)
    ]]
    if a1 == u11 then
        return
    end
    u11 = a1
    if not (u10) then
        local v18 = Instance.new("ColorCorrectionEffect")
        v18.Name = "CoreRingHeat"
        v18.TintColor = Color3.new(1, 1, 1)
        v18.Enabled = false
        v18.Parent = Lighting_upv_1
        u10 = v18
    end
    local u14 = u10
    u14.Enabled = true
    local v19 = TweenInfo.new(0.4)
    local tbl_17 = {TintColor = 0, Saturation = 0}
    local v20
    if a1 then
        v20 = Color3.fromRGB(255, 226, 206)
    else
        v20 = Color3.new(1, 1, 1)
    end
    tbl_17.TintColor = v20
    tbl_17.Saturation = (a1 and 0.08) or 0
    local v21 = TweenService_upv_1:Create(u10, v19, tbl_17)
    v21.Completed:Connect(
        function(a2)
            --[[
              line: 345
              upvalues:
                u11 (ref,  index: 1)
                u14 (copy, index: 2)
            ]]
            if a2 ~= Enum.PlaybackState.Completed or (u11) then
                return
            end
            u14.Enabled = false
        end
    )
    v21:Play()
end
local function sampleGround(a1, a2, a3)
    --[[
      name: sampleGround
      line: 354
      upvalues:
        Workspace_upv_1 (copy, index: 1)
        u12 (copy, index: 2)
    ]]
    local v22 = Workspace_upv_1:Raycast(Vector3.new(a2, a1.Y + 110, a3), Vector3.new(0, -150, 0), u12)
    if not v22 then
        return 0, false
    end
    local v23 = v22.Position.Y - a1.Y
    if v23 <= 6 then
        return math.max(v23, -12), false
    end
    local Instance_1 = v22.Instance
    if Instance_1:IsA("BasePart") and v22.Normal.Y > 0.8 then
        local Size_1 = Instance_1.Size
        local tbl_18 = {Size_1.X, Size_1.Y, Size_1.Z}
        table.sort(tbl_18)
        if tbl_18[2] >= 14 then
            return v23, false
        end
    end
    return v23, true
end
local function sampleAll(a1, a2, a3, a4)
    --[[
      name: sampleAll
      line: 375
      upvalues:
        u12 (copy, index: 1)
        sampleGround (copy, index: 2)
        tbl_upv_9 (copy, index: 3)
        tbl_upv_10 (copy, index: 4)
    ]]
    local Map_1 = a1:FindFirstChild("Map")
    u12.FilterDescendantsInstances = (Map_1 and {Map_1}) or {}
    local v24 = table.create(a4, false)
    for n_5 = 1, a4 do
        local v25 = ((n_5 - 1) / a4) * 2 * math.pi
        local v26, v27 = sampleGround(a2, a2.X + (math.cos(v25) * a3), a2.Z + (math.sin(v25) * a3))
        tbl_upv_9[n_5] = v26
        v24[n_5] = v27
    end
    for n_6 = 1, a4 do
        local v28 = ((n_6 - 0.5) / a4) * 2 * math.pi
        local _, v29 = sampleGround(a2, a2.X + (math.cos(v28) * a3), a2.Z + (math.sin(v28) * a3))
        tbl_upv_10[n_6] = v29 or (v24[n_6] or (v24[(n_6 % a4) + 1]))
    end
end
local function layout(a1, a2, a3)
    --[[
      name: layout
      line: 393
      upvalues:
        u1 (ref,  index: 1)
        clear (copy, index: 2)
        build (copy, index: 3)
        tbl_upv_8 (copy, index: 4)
        u2 (ref,  index: 5)
        u7 (ref,  index: 6)
        u8 (ref,  index: 7)
        sampleAll (copy, index: 8)
        tbl_upv_10 (copy, index: 9)
        styleBeams (copy, index: 10)
        tbl_upv_2 (copy, index: 11)
        tbl_upv_3 (copy, index: 12)
        tbl_upv_9 (copy, index: 13)
        tbl_upv_4 (copy, index: 14)
        Workspace_upv_1 (copy, index: 15)
        u9 (ref,  index: 16)
        LocalPlayer_upv_1 (copy, index: 17)
        setTint (copy, index: 18)
    ]]
    local v30 = a1:GetAttribute("RingCenterX")
    local v31
    if type(v30) == "number" and v30 == v30 then
        v31 = v30
    else
        v31 = 0
    end
    local v32 = a1:GetAttribute("RingCenterY")
    if type(v32) == "number" and v32 == v32 then
        v30 = v32
    else
        v30 = 0
    end
    local v33 = a1:GetAttribute("RingCenterZ")
    if type(v33) == "number" and v33 == v33 then
        v32 = v33
    else
        v32 = 0
    end
    local v34 = Vector3.new(v31, v30, v32)
    if not (u1) or not (u1.Parent) then
        clear()
        local v35 = a1:GetAttribute("RingStartRadius")
        if type(v35) == "number" and v35 == v35 then
            v32 = v35
        else
            v32 = a2
        end
        build(math.clamp(math.floor((math.tau * math.max(a2, v32) / 10) + 0.5), 16, 48), v34)
        a3 = true
    end
    local v36 = #tbl_upv_8
    if (u2.Position - v34).Magnitude > 0.01 then
        u2.CFrame = CFrame.new(v34)
    end
    v30 = os.clock()
    v32 = false
    if v30 - u7 >= 0.1 then
        local v37 = true
        if math.abs(a2 - u8) > 0.25 then
            v32 = v37
        else
            v32 = 1 <= v30 - u7
        end
    end
    if a3 or v32 then
        u7 = v30
        u8 = a2
        sampleAll(a1, v34, a2, v36)
        v33 = false
        for key_7, value_8 in tbl_upv_8 do
            local v38 = not tbl_upv_10[key_7]
            if value_8.visible ~= v38 then
                value_8.visible = v38
                value_8.licks.Enabled = v38
                value_8.embers.Enabled = v38
                value_8.smoke.Enabled = v38
                v33 = true
            end
        end
        if v33 or a3 then
            styleBeams()
        end
    end
    for key_8, value_9 in tbl_upv_2 do
        local v39 = tbl_upv_3[key_8]
        for n_7 = 1, v36 do
            local v40 = ((n_7 - 1) / v36) * 2 * math.pi
            local v41 = math.cos(v40)
            local v42 = math.sin(v40)
            v39[n_7].CFrame = CFrame.fromMatrix(Vector3.new(v41 * a2, tbl_upv_9[n_7] + ((value_9.height * 0.5) - 0.6), v42 * a2), Vector3.new(-v42, 0, v41), Vector3.new(0, 1, 0))
        end
    end
    local v43 = a2 + 1.5 + 0.3
    for n_8 = 1, v36 do
        local v44 = ((n_8 - 1) / v36) * 2 * math.pi
        local v45 = math.cos(v44)
        local v46 = math.sin(v44)
        tbl_upv_4[n_8].CFrame = CFrame.fromMatrix(Vector3.new(v45 * v43, tbl_upv_9[n_8] + 0.12, v46 * v43), Vector3.new(-v46, 0, v45), Vector3.new(v45, 0, v46))
        local v47 = n_8
    end
    local v48 = a2 * 2 * math.sin(math.pi / v36)
    local v49 = a2 * math.cos(math.pi / v36)
    local v50 = table.create(v36 * 2)
    local v47 = table.create(v36 * 2)
    for key_9, value_10 in tbl_upv_8 do
        local v51 = ((key_9 - 0.5) / v36) * 2 * math.pi
        local v52 = math.cos(v51)
        local v53 = math.sin(v51)
        local v54 = v34 + Vector3.new(v52 * v49, ((tbl_upv_9[key_9] + tbl_upv_9[(key_9 % v36) + 1]) * 0.5) + 0.6, v53 * v49)
        local v55 = CFrame.fromMatrix(Vector3.new(0, 0, 0), Vector3.new(-v53, 0, v52), Vector3.new(0, 1, 0))
        table.insert(v50, value_10.part)
        table.insert(v47, v55 + v54)
        table.insert(v50, value_10.smokePart)
        table.insert(v47, (v55 + v54) + Vector3.new(0, 11, 0))
    end
    Workspace_upv_1:BulkMoveTo(v50, v47, Enum.BulkMoveMode.FireCFrameChanged)
    if math.abs(v48 - u9) > 0.4 then
        u9 = v48
        for _, value_11 in tbl_upv_8 do
            value_11.part.Size = Vector3.new(v48, 1, 1.5)
            value_11.smokePart.Size = Vector3.new(v48, 1, 2)
            value_11.licks.Rate = v48 * 0.8
            value_11.embers.Rate = v48 * 0.08
            value_11.smoke.Rate = v48 * 0.12
        end
    end
    local Character_1 = LocalPlayer_upv_1.Character
    local v56 = Character_1 and (Character_1:FindFirstChild("HumanoidRootPart"))
    if not v56 then
        return
    end
    if v56:IsA("BasePart") then
        local v57 = (a2 < Vector2.new(v56.Position.X - v34.X, v56.Position.Z - v34.Z).Magnitude) and (LocalPlayer_upv_1:GetAttribute("Alive") == true)
        setTint(v57)
    end
end
local function currentRadius(a1)
    --[[
      name: currentRadius
      line: 308
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    local v58 = a1:GetAttribute("RingRadius")
    local v59
    if type(v58) == "number" and v58 == v58 then
        v59 = v58
    else
        v59 = 0
    end
    if v59 <= 0 then
        return 0
    end
    local v60 = a1:GetAttribute("RingStartRadius")
    if type(v60) == "number" and v60 == v60 then
        v58 = v60
    else
        v58 = v59
    end
    local v61 = a1:GetAttribute("RingMinRadius")
    if type(v61) == "number" and v61 == v61 then
        v60 = v61
    else
        v60 = v59
    end
    local v62 = a1:GetAttribute("RingShrinkStart")
    if type(v62) == "number" and v62 == v62 then
        v61 = v62
    else
        v61 = 0
    end
    local v63 = a1:GetAttribute("RingShrinkEnd")
    if type(v63) == "number" and v63 == v63 then
        v62 = v63
    else
        v62 = 0
    end
    if v61 < v62 then
        return (math.clamp(v58 + ((v60 - v58) * math.clamp((Workspace_upv_1:GetServerTimeNow() - v61) / (v62 - v61), 0, 1)), v59 - 3, v59 + 3))
    end
    return v59
end
local function step()
    --[[
      name: step
      line: 481
      upvalues:
        u3 (ref,  index: 1)
        currentRadius (copy, index: 2)
        u4 (ref,  index: 3)
        clear (copy, index: 4)
        setTint (copy, index: 5)
        u5 (ref,  index: 6)
        u6 (ref,  index: 7)
        layout (copy, index: 8)
    ]]
    local v64
    if (u3) and (u3.Parent) then
        v64 = currentRadius(u3)
    else
        v64 = 0
    end
    if not (v64 <= 0) and u3 then
        u4 = true
        local v65 = os.clock()
        local v66 = math.abs(v64 - u5) >= 0.05
        local v67 = v65 - u6
        local v68
        if v66 then
            v68 = 0.03333333333333333
        else
            v68 = 0.1
        end
        if not (v67 < v68) then
            u6 = v65
            u5 = v64
            layout(u3, v64, false)
        end
        return
    end
    if not u4 then
        return
    end
    u4 = false
    clear()
    setTint(false)
end
local function bindArena()
    --[[
      name: bindArena
      line: 503
      upvalues:
        tbl_upv_11 (copy, index: 1)
        u3 (ref,  index: 2)
        clear (copy, index: 3)
        u4 (ref,  index: 4)
        setTint (copy, index: 5)
        LocalPlayer_upv_1 (copy, index: 6)
        Workspace_upv_1 (copy, index: 7)
    ]]
    for _, value_12 in tbl_upv_11 do
        value_12:Disconnect()
    end
    table.clear(tbl_upv_11)
    u3 = nil
    clear()
    u4 = false
    setTint(false)
    local v69 = LocalPlayer_upv_1:GetAttribute("State") == "Match"
    local u15
    if v69 then
        u15 = LocalPlayer_upv_1:GetAttribute("MatchId")
    else
        u15 = LocalPlayer_upv_1:GetAttribute("Spectating")
    end
    if type(u15) ~= "string" then
        return
    end
    if u15 ~= "" then
        local Arenas_1 = Workspace_upv_1:FindFirstChild("Arenas")
        local v70 = Arenas_1 and (Arenas_1:FindFirstChild(u15))
        if v70 then
            u3 = v70
        elseif Arenas_1 then
            table.insert(
                tbl_upv_11,
                Arenas_1.ChildAdded:Connect(
                    function(a1)
                        --[[
                          line: 523
                          upvalues:
                            u15 (copy, index: 1)
                            u3 (ref,  index: 2)
                        ]]
                        if a1.Name ~= u15 then
                            return
                        end
                        u3 = a1
                    end
                )
            )
        end
    end
end
function tbl_1.Start()
    --[[
      name: Start
      line: 531
      upvalues:
        u13 (ref,  index: 1)
        ContentProvider_upv_1 (copy, index: 2)
        RunService_upv_1 (copy, index: 3)
        styleBeams (copy, index: 4)
        LocalPlayer_upv_1 (copy, index: 5)
        bindArena (copy, index: 6)
        Workspace_upv_1 (copy, index: 7)
        u3 (ref,  index: 8)
        u4 (ref,  index: 9)
        step (copy, index: 10)
    ]]
    task.spawn(
        function()
            --[[
              line: 532
              upvalues:
                u13 (ref,  index: 1)
                ContentProvider_upv_1 (copy, index: 2)
                RunService_upv_1 (copy, index: 3)
                styleBeams (copy, index: 4)
            ]]
            local v71 = 0
            v71 = nil
            while u13 ~= "ok" do
                local u16 = nil
                local tbl_upv_19 = {}
                for _, value_13 in {"rbxassetid://82559613851503", "rbxassetid://109193145976179"} do
                    local v72 = Instance.new("Beam")
                    v72.Texture = value_13
                    table.insert(tbl_upv_19, v72)
                end
                pcall(
                    function()
                        --[[
                          line: 545
                          upvalues:
                            ContentProvider_upv_1 (copy, index: 1)
                            tbl_upv_19 (copy, index: 2)
                            u16 (ref,  index: 3)
                        ]]
                        ContentProvider_upv_1:PreloadAsync(
                            tbl_upv_19,
                            function(a1, a2)
                                --[[
                                  line: 546
                                  upvalues:
                                    u16 (ref, index: 1)
                                ]]
                                if a1 ~= "rbxassetid://82559613851503" then
                                    return
                                end
                                u16 = a2
                            end
                        )
                    end
                )
                for _, value_14 in tbl_upv_19 do
                    value_14:Destroy()
                end
                v71 = v71 + 1
                if u16 == Enum.AssetFetchStatus.Success then
                    u13 = "ok"
                elseif v71 == 3 then
                    u13 = "failed"
                    local v73 = RunService_upv_1:IsStudio()
                    if v73 then
                        print("[RingOfFire] wall texture not loaded yet; the ring shows particles until it does")
                    end
                end
                styleBeams()
                if u13 ~= "ok" then
                    task.wait((math.min(30, v71 * 3)))
                end
            end
        end
    )
    LocalPlayer_upv_1:GetAttributeChangedSignal("MatchId"):Connect(bindArena)
    LocalPlayer_upv_1:GetAttributeChangedSignal("State"):Connect(bindArena)
    LocalPlayer_upv_1:GetAttributeChangedSignal("Spectating"):Connect(bindArena)
    task.spawn(
        function()
            --[[
              line: 573
              upvalues:
                Workspace_upv_1 (copy, index: 1)
                bindArena (copy, index: 2)
            ]]
            Workspace_upv_1:WaitForChild("Arenas", 60)
            bindArena()
        end
    )
    RunService_upv_1.Heartbeat:Connect(
        function()
            --[[
              line: 577
              upvalues:
                u3 (ref,  index: 1)
                u4 (ref,  index: 2)
                step (copy, index: 3)
            ]]
            if not u3 and not u4 then
                return
            end
            step()
        end
    )
end
return tbl_1