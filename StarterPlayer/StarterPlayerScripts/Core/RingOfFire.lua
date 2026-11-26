local contentProvider = game:GetService("ContentProvider")
local lighting = game:GetService("Lighting")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local workspace = game:GetService("Workspace")
local v7 = {}
local localPlayer = players.LocalPlayer
local v9 = {{height = 16, tile = 34, speed = 0.045, transparency = 0.3}, {height = 10.5, tile = 21, speed = -0.07, transparency = 0.38}}
local folder = nil
local part = nil
local v12 = {}
local v13 = {}
local v14 = {}
local v15 = {}
local v16 = {}
local v17 = {}
local v18 = {}
local v19 = {}
local child = nil
local v21 = {}
local v22 = false
local v23 = -1
local timestamp = 0
local timestamp2 = 0
local v26 = -1
local v27 = -1
local colorCorrectionEffect = nil
local v29 = false
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.RespectCanCollide = true
local v31 = "pending"

local function num(a33, a34, a35)
    --[[
      name: num
      line: 88
    ]]
    local v36 = a33:GetAttribute(a34)

    if type(v36) == "number" and v36 == v36 then
        return v36
    end

    return a35
end

local function styleBeams()
    --[[
      name: styleBeams
      line: 93
      upvalues:
        v17 (copy, index: 1)
        v31 (ref,  index: 2)
        v15 (copy, index: 3)
        v16 (copy, index: 4)
    ]]
    for v38, v39 in v17 do
        local enabled = v39.visible and v31 == "ok"

        for _, v42 in v15 do
            v42[v38].Enabled = enabled
        end

        v16[v38].Enabled = v39.visible
    end
end

local function emitter(parent: Instance?, properties)
    --[[
      name: emitter
      line: 103
    ]]
    local particleEmitter = Instance.new("ParticleEmitter")

    for v47, v48 in properties do
        particleEmitter[v47] = v48
    end

    particleEmitter.Parent = parent

    return particleEmitter
end

local function invisiblePart(name: string)
    --[[
      name: invisiblePart
      line: 112
    ]]
    local part = Instance.new("Part")
    part.Name = name
    part.Anchored = true
    part.CanCollide = false
    part.CanQuery = false
    part.CanTouch = false
    part.CastShadow = false
    part.Transparency = 1
    part.Size = Vector3.new(8, 1, 1.5)
    return part
end

local function makeSegment(parent: Folder)
    --[[
      name: makeSegment
      line: 125
    ]]
    local ringSegment = Instance.new("Part")
    ringSegment.Name = "RingSegment"
    ringSegment.Anchored = true
    ringSegment.CanCollide = false
    ringSegment.CanQuery = false
    ringSegment.CanTouch = false
    ringSegment.CastShadow = false
    ringSegment.Transparency = 1
    ringSegment.Size = Vector3.new(8, 1, 1.5)
    local v55 = {
        Name = "Licks",
        Texture = "rbxassetid://109193145976179",
        Drag = 1,
        LightEmission = 0.35,
        LightInfluence = 0,
        ZOffset = 1,
        Shape = Enum.ParticleEmitterShape.Box,
        EmissionDirection = Enum.NormalId.Top,
        Orientation = Enum.ParticleOrientation.FacingCameraWorldUp,
        Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 236, 214)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 190, 150)), ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 120, 90))}),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(0.18, 0.05), NumberSequenceKeypoint.new(0.7, 0.25), NumberSequenceKeypoint.new(1, 1)}),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 4), NumberSequenceKeypoint.new(0.35, 7, 1.5), NumberSequenceKeypoint.new(1, 2.5)}),
        Squash = NumberSequence.new(-0.35),
        Lifetime = NumberRange.new(0.8, 1.25),
        Speed = NumberRange.new(6, 10),
        SpreadAngle = Vector2.new(5, 5),
        Rotation = NumberRange.new(-8, 8),
        RotSpeed = NumberRange.new(-10, 10)
    }
    local licks = Instance.new("ParticleEmitter")

    for v57, v58 in v55 do
        licks[v57] = v58
    end

    licks.Parent = ringSegment
    local v59 = {
        Name = "Embers",
        Acceleration = Vector3.new(0, 1.5, 0),
        Drag = 0.6,
        LightEmission = 0.4,
        LightInfluence = 0,
        Shape = Enum.ParticleEmitterShape.Box,
        EmissionDirection = Enum.NormalId.Top,
        Color = ColorSequence.new(Color3.fromRGB(255, 150, 60), Color3.fromRGB(230, 70, 30)),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.8, 0.2), NumberSequenceKeypoint.new(1, 1)}),
        Size = NumberSequence.new(0.25, 0.08),
        Lifetime = NumberRange.new(1.6, 2.8),
        Speed = NumberRange.new(10, 18),
        SpreadAngle = Vector2.new(22, 22)
    }
    local embers = Instance.new("ParticleEmitter")

    for v61, v62 in v59 do
        embers[v61] = v62
    end

    embers.Parent = ringSegment
    local ringSmoke = Instance.new("Part")
    ringSmoke.Name = "RingSmoke"
    ringSmoke.Anchored = true
    ringSmoke.CanCollide = false
    ringSmoke.CanQuery = false
    ringSmoke.CanTouch = false
    ringSmoke.CastShadow = false
    ringSmoke.Transparency = 1
    ringSmoke.Size = Vector3.new(8, 1, 1.5)
    local v64 = {
        Name = "Smoke",
        Texture = "rbxassetid://8030839542",
        Drag = 0.35,
        LightEmission = 0,
        LightInfluence = 1,
        ZOffset = -1,
        Shape = Enum.ParticleEmitterShape.Box,
        EmissionDirection = Enum.NormalId.Top,
        Color = ColorSequence.new(Color3.fromRGB(70, 55, 48), Color3.fromRGB(46, 40, 38)),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0.55), NumberSequenceKeypoint.new(0.7, 0.7), NumberSequenceKeypoint.new(1, 1)}),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 7), NumberSequenceKeypoint.new(1, 16)}),
        Lifetime = NumberRange.new(2.6, 3.6),
        Speed = NumberRange.new(5, 7),
        SpreadAngle = Vector2.new(12, 12),
        Rotation = NumberRange.new(-180, 180),
        RotSpeed = NumberRange.new(-15, 15)
    }
    local smoke = Instance.new("ParticleEmitter")

    for v66, v67 in v64 do
        smoke[v66] = v67
    end

    smoke.Parent = ringSmoke
    ringSegment.Parent = parent
    ringSmoke.Parent = parent

    return {visible = true, part = ringSegment, smokePart = ringSmoke, licks = licks, embers = embers, smoke = smoke}
end

local function clear()
    --[[
      name: clear
      line: 212
      upvalues:
        folder (ref,  index: 1)
        part (ref,  index: 2)
        v12 (copy, index: 3)
        v13 (copy, index: 4)
        v14 (copy, index: 5)
        v15 (copy, index: 6)
        v16 (copy, index: 7)
        v17 (copy, index: 8)
        v18 (copy, index: 9)
        v19 (copy, index: 10)
        v23 (ref,  index: 11)
        v27 (ref,  index: 12)
        v26 (ref,  index: 13)
    ]]
    if folder then
        folder:Destroy()
    end

    folder = nil
    part = nil
    table.clear(v12)
    table.clear(v13)
    table.clear(v14)
    table.clear(v15)
    table.clear(v16)
    table.clear(v17)
    table.clear(v18)
    table.clear(v19)
    v23 = -1
    v27 = -1
    v26 = -1
end

local function makeBeam(attachment0: Attachment?, attachment1: Attachment?, name: string)
    --[[
      name: makeBeam
      line: 231
    ]]
    local beam = Instance.new("Beam")
    beam.Name = name
    beam.Attachment0 = attachment0
    beam.Attachment1 = attachment1
    beam.FaceCamera = false
    beam.Segments = 1
    return beam
end

local function build(clampedValue: number, vector3: Vector3)
    --[[
      name: build
      line: 241
      upvalues:
        part (ref,  index: 1)
        v9 (copy, index: 2)
        v12 (copy, index: 3)
        v14 (copy, index: 4)
        v15 (copy, index: 5)
        v13 (copy, index: 6)
        v16 (copy, index: 7)
        v17 (copy, index: 8)
        makeSegment (copy, index: 9)
        v18 (copy, index: 10)
        v19 (copy, index: 11)
        workspace (copy, index: 12)
        folder (ref,  index: 13)
        styleBeams (copy, index: 14)
    ]]
    local coreRingOfFire = Instance.new("Folder")
    coreRingOfFire.Name = "CoreRingOfFire"

    local ringAnchor = Instance.new("Part")
    ringAnchor.Name = "RingAnchor"
    ringAnchor.Anchored = true
    ringAnchor.CanCollide = false
    ringAnchor.CanQuery = false
    ringAnchor.CanTouch = false
    ringAnchor.CastShadow = false
    ringAnchor.Transparency = 1
    ringAnchor.Size = Vector3.new(8, 1, 1.5)
    ringAnchor.Size = Vector3.new(1, 1, 1)
    ringAnchor.CFrame = CFrame.new(vector3)
    ringAnchor.Parent = coreRingOfFire
    part = ringAnchor

    for v79, v80 in v9 do
        local v81 = {}

        for index = 1, clampedValue do
            local attachment = Instance.new("Attachment")
            attachment.Name = `L{v79}_{index}`
            attachment.Parent = ringAnchor
            v81[index] = attachment
        end

        v12[v79] = v81
        local v84 = {}

        for index = 1, clampedValue do
            local attachment0 = v81[index]
            local attachment1 = v81[(index % clampedValue) + 1]
            local formattedText = `Wall{v79}_{index}`
            local beam = Instance.new("Beam")
            beam.Name = formattedText
            beam.Attachment0 = attachment0
            beam.Attachment1 = attachment1
            beam.FaceCamera = false
            beam.Segments = 1
            beam.Width0 = v80.height
            beam.Width1 = v80.height
            beam.Texture = "rbxassetid://82559613851503"
            beam.TextureMode = Enum.TextureMode.Wrap
            beam.TextureLength = v80.tile
            beam.TextureSpeed = v80.speed
            beam.Color = ColorSequence.new(Color3.fromRGB(255, 240, 228))
            beam.Transparency = NumberSequence.new(v80.transparency)
            beam.LightEmission = 0.25
            beam.LightInfluence = 0
            beam.Brightness = 1
            beam.ZOffset = v79 - 1
            beam.Enabled = false
            beam.Parent = ringAnchor
            v84[index] = beam
            table.insert(v14, beam)
        end

        v15[v79] = v84
    end

    for index = 1, clampedValue do
        local attachment = Instance.new("Attachment")
        attachment.Name = `S_{index}`
        attachment.Parent = ringAnchor
        v13[index] = attachment
    end

    for index = 1, clampedValue do
        local attachment0 = v13[index]
        local attachment1 = v13[(index % clampedValue) + 1]
        local formattedText = `Scorch{index}`
        local beam = Instance.new("Beam")
        beam.Name = formattedText
        beam.Attachment0 = attachment0
        beam.Attachment1 = attachment1
        beam.FaceCamera = false
        beam.Segments = 1
        beam.Width0 = 3
        beam.Width1 = 3
        beam.Color = ColorSequence.new(Color3.fromRGB(36, 28, 25))
        beam.Transparency = NumberSequence.new(0.12)
        beam.LightEmission = 0
        beam.LightInfluence = 1
        beam.Parent = ringAnchor
        v16[index] = beam
    end

    for _ = 1, clampedValue do
        table.insert(v17, (makeSegment(coreRingOfFire)))
        table.insert(v18, 0)
        table.insert(v19, false)
    end

    coreRingOfFire.Parent = workspace
    folder = coreRingOfFire
    styleBeams()
end

local function currentRadius(child: Instance?)
    --[[
      name: currentRadius
      line: 308
      upvalues:
        workspace (copy, index: 1)
    ]]
    local ringRadius
    local v101
    local v102
    local ringShrinkStart
    local ringShrinkEnd
    local ringRadius2 = child:GetAttribute("RingRadius")

    if type(ringRadius2) ~= "number" or ringRadius2 ~= ringRadius2 then
        ringRadius = 0
    else
        ringRadius = ringRadius2
    end

    if ringRadius <= 0 then
        return 0
    end

    local ringStartRadius = child:GetAttribute("RingStartRadius")

    if type(ringStartRadius) ~= "number" or ringStartRadius ~= ringStartRadius then
        v101 = ringRadius
    else
        v101 = ringStartRadius
    end

    local ringMinRadius = child:GetAttribute("RingMinRadius")

    if type(ringMinRadius) ~= "number" or ringMinRadius ~= ringMinRadius then
        v102 = ringRadius
    else
        v102 = ringMinRadius
    end

    local ringShrinkStart2 = child:GetAttribute("RingShrinkStart")

    if type(ringShrinkStart2) ~= "number" or ringShrinkStart2 ~= ringShrinkStart2 then
        ringShrinkStart = 0
    else
        ringShrinkStart = ringShrinkStart2
    end

    local ringShrinkEnd2 = child:GetAttribute("RingShrinkEnd")

    if type(ringShrinkEnd2) ~= "number" or ringShrinkEnd2 ~= ringShrinkEnd2 then
        ringShrinkEnd = 0
    else
        ringShrinkEnd = ringShrinkEnd2
    end

    if ringShrinkStart < ringShrinkEnd then
        local clampedValue = math.clamp((workspace:GetServerTimeNow() - ringShrinkStart) / (ringShrinkEnd - ringShrinkStart), 0, 1)
        return (math.clamp(v101 + ((v102 - v101) * clampedValue), ringRadius - 3, ringRadius + 3))
    end

    return ringRadius
end

local function setTint(tint: boolean)
    --[[
      name: setTint
      line: 326
      upvalues:
        v29 (ref,  index: 1)
        colorCorrectionEffect (ref,  index: 2)
        lighting (copy, index: 3)
        tweenService (copy, index: 4)
    ]]
    if tint == v29 then
        return
    end

    v29 = tint

    if not colorCorrectionEffect then
        local coreRingHeat = Instance.new("ColorCorrectionEffect")
        coreRingHeat.Name = "CoreRingHeat"
        coreRingHeat.TintColor = Color3.new(1, 1, 1)
        coreRingHeat.Enabled = false
        coreRingHeat.Parent = lighting
        colorCorrectionEffect = coreRingHeat
    end

    local colorCorrectionEffect2 = colorCorrectionEffect
    colorCorrectionEffect2.Enabled = true
    local tweenInfo = TweenInfo.new(0.4)
    local propertyTable = {TintColor = if tint then Color3.fromRGB(255, 226, 206) else Color3.new(1, 1, 1)}
    propertyTable.Saturation = tint and 0.08 or 0
    local tween = tweenService:Create(colorCorrectionEffect2, tweenInfo, propertyTable)

    tween.Completed:Connect(
        function(playbackState: Enum.PlaybackState)
            --[[
              line: 345
              upvalues:
                v29 (ref,  index: 1)
                colorCorrectionEffect2 (copy, index: 2)
            ]]
            if playbackState == Enum.PlaybackState.Completed and not v29 then
                colorCorrectionEffect2.Enabled = false
            end
        end
    )

    tween:Play()
end

local function sampleGround(vector3: Vector3, x, z)
    --[[
      name: sampleGround
      line: 354
      upvalues:
        workspace (copy, index: 1)
        raycastParams (copy, index: 2)
    ]]
    local raycastResult = workspace:Raycast(Vector3.new(x, vector3.Y + 110, z), Vector3.new(0, -150, 0), raycastParams)
    if not raycastResult then
        return 0, false
    end

    local v124 = raycastResult.Position.Y - vector3.Y

    if v124 <= 6 then
        return math.max(v124, -12), false
    end

    local instance = raycastResult.Instance

    if instance:IsA("BasePart") and 0.8 < raycastResult.Normal.Y then
        local size = instance.Size
        local v127 = {size.X, size.Y, size.Z}
        table.sort(v127)

        if 14 <= v127[2] then
            return v124, false
        end
    end

    return v124, true
end

local function sampleAll(child: Instance?, vector3: Vector3, a131, size: number)
    --[[
      name: sampleAll
      line: 375
      upvalues:
        raycastParams (copy, index: 1)
        sampleGround (copy, index: 2)
        v18 (copy, index: 3)
        v19 (copy, index: 4)
    ]]
    local map = child:FindFirstChild("Map")
    raycastParams.FilterDescendantsInstances = map and {map} or {}
    local values = table.create(size, false)

    for valueKey = 1, size do
        local v136 = ((valueKey - 1) / size) * 2 * math.pi
        local v137, v138 = sampleGround(vector3, vector3.X + (math.cos(v136) * a131), vector3.Z + (math.sin(v136) * a131))
        v18[valueKey] = v137
        values[valueKey] = v138
    end

    for valueKey = 1, size do
        local v140 = ((valueKey - 0.5) / size) * 2 * math.pi
        local _, v142 = sampleGround(vector3, vector3.X + (math.cos(v140) * a131), vector3.Z + (math.sin(v140) * a131))
        local valueKey2 = valueKey % size + 1
        v19[valueKey] = v142 or values[valueKey] or values[valueKey2]
    end
end

local function layout(child: Instance?, a146, a147: boolean)
    --[[
      name: layout
      line: 393
      upvalues:
        folder (ref,  index: 1)
        clear (copy, index: 2)
        build (copy, index: 3)
        v17 (copy, index: 4)
        part (ref,  index: 5)
        timestamp2 (ref,  index: 6)
        v26 (ref,  index: 7)
        sampleAll (copy, index: 8)
        v19 (copy, index: 9)
        styleBeams (copy, index: 10)
        v9 (copy, index: 11)
        v12 (copy, index: 12)
        v18 (copy, index: 13)
        v13 (copy, index: 14)
        workspace (copy, index: 15)
        v27 (ref,  index: 16)
        localPlayer (copy, index: 17)
        setTint (copy, index: 18)
    ]]
    local ringCenterX
    local ringCenterY
    local ringCenterZ
    local v151
    local ringCenterX2 = child:GetAttribute("RingCenterX")

    if type(ringCenterX2) ~= "number" or ringCenterX2 ~= ringCenterX2 then
        ringCenterX = 0
    else
        ringCenterX = ringCenterX2
    end

    local ringCenterY2 = child:GetAttribute("RingCenterY")

    if type(ringCenterY2) ~= "number" or ringCenterY2 ~= ringCenterY2 then
        ringCenterY = 0
    else
        ringCenterY = ringCenterY2
    end

    local ringCenterZ2 = child:GetAttribute("RingCenterZ")

    if type(ringCenterZ2) ~= "number" or ringCenterZ2 ~= ringCenterZ2 then
        ringCenterZ = 0
    else
        ringCenterZ = ringCenterZ2
    end

    local vector3 = Vector3.new(ringCenterX, ringCenterY, ringCenterZ)

    if not folder or not folder.Parent then
        local v156
        clear()
        local ringStartRadius = child:GetAttribute("RingStartRadius")

        if type(ringStartRadius) ~= "number" or ringStartRadius ~= ringStartRadius then
            v156 = a146
        else
            v156 = ringStartRadius
        end

        build(math.clamp(math.floor((math.tau * math.max(a146, v156) / 10) + 0.5), 16, 48), vector3)
        v151 = true
    else
        v151 = a147
    end

    local endIndex = #v17
    local part2 = part

    if 0.01 < (part2.Position - vector3).Magnitude then
        part2.CFrame = CFrame.new(vector3)
    end

    local timestamp = os.clock()
    local v161 = 0.1 <= timestamp - timestamp2 and (0.25 < math.abs(a146 - v26) or 1 <= timestamp - timestamp2)

    if v151 or v161 then
        timestamp2 = timestamp
        v26 = a146
        sampleAll(child, vector3, a146, endIndex)
        local v162 = false

        for v163, v164 in v17 do
            local v165 = not v19[v163]

            if v164.visible ~= v165 then
                v164.visible = v165
                v164.licks.Enabled = v165
                v164.embers.Enabled = v165
                v164.smoke.Enabled = v165
                v162 = true
            end
        end

        if v162 or v151 then
            styleBeams()
        end
    end

    for v166, v167 in v9 do
        local v168 = v12[v166]
        local v169 = v167.height * 0.5 - 0.6

        for index = 1, endIndex do
            local v171 = ((index - 1) / endIndex) * 2 * math.pi
            local z = math.cos(v171)
            local v173 = math.sin(v171)
            v168[index].CFrame = CFrame.fromMatrix(Vector3.new(z * a146, v18[index] + v169, v173 * a146), Vector3.new(-v173, 0, z), Vector3.new(0, 1, 0))
        end
    end

    local v174 = a146 + 1.5 + 0.3

    for index = 1, endIndex do
        local v176 = ((index - 1) / endIndex) * 2 * math.pi
        local v177 = math.cos(v176)
        local z = math.sin(v176)
        v13[index].CFrame = CFrame.fromMatrix(Vector3.new(v177 * v174, v18[index] + 0.12, z * v174), Vector3.new(-z, 0, v177), (Vector3.new(v177, 0, z)))
    end

    local x = a146 * 2 * math.sin(math.pi / endIndex)
    local v180 = a146 * math.cos(math.pi / endIndex)
    local partList = table.create(endIndex * 2)
    local cframeList = table.create(endIndex * 2)

    for v183, v184 in v17 do
        local v185 = ((v183 - 0.5) / endIndex) * 2 * math.pi
        local z = math.cos(v185)
        local v187 = math.sin(v185)
        local v188 = (v18[v183] + v18[(v183 % endIndex) + 1]) * 0.5
        local vector32 = vector3 + Vector3.new(z * v180, v188 + 0.6, v187 * v180)
        local v190 = CFrame.fromMatrix(Vector3.new(0, 0, 0), Vector3.new(-v187, 0, z), Vector3.new(0, 1, 0))
        table.insert(partList, v184.part)
        table.insert(cframeList, v190 + vector32)
        table.insert(partList, v184.smokePart)
        table.insert(cframeList, (v190 + vector32) + Vector3.new(0, 11, 0))
    end

    workspace:BulkMoveTo(partList, cframeList, Enum.BulkMoveMode.FireCFrameChanged)

    if 0.4 < math.abs(x - v27) then
        v27 = x

        for _, v192 in v17 do
            v192.part.Size = Vector3.new(x, 1, 1.5)
            v192.smokePart.Size = Vector3.new(x, 1, 2)
            v192.licks.Rate = x * 0.8
            v192.embers.Rate = x * 0.08
            v192.smoke.Rate = x * 0.12
        end
    end

    local character = localPlayer.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
        local alive = a146 < Vector2.new(humanoidRootPart.Position.X - vector3.X, humanoidRootPart.Position.Z - vector3.Z).Magnitude
            and localPlayer:GetAttribute("Alive") == true
        setTint(alive)
    end
end

local function step()
    --[[
      name: step
      line: 481
      upvalues:
        child (ref,  index: 1)
        currentRadius (copy, index: 2)
        v22 (ref,  index: 3)
        clear (copy, index: 4)
        setTint (copy, index: 5)
        v23 (ref,  index: 6)
        timestamp (ref,  index: 7)
        layout (copy, index: 8)
    ]]
    local child2 = child
    local v198 = if child2 and child2.Parent then currentRadius(child2) else 0

    if not (v198 <= 0) and child2 then
        v22 = true
        local timestamp2 = os.clock()
        local v200 = 0.05 <= math.abs(v198 - v23)
        local v201 = timestamp2 - timestamp
        local v202 = v200 and 0.03333333333333333 or 0.1

        if v201 < v202 then
            return
        end

        timestamp = timestamp2
        v23 = v198
        layout(child2, v198, false)

        return
    end

    if v22 then
        v22 = false
        clear()
        setTint(false)
    end
end

local function bindArena()
    --[[
      name: bindArena
      line: 503
      upvalues:
        v21 (copy, index: 1)
        child (ref,  index: 2)
        clear (copy, index: 3)
        v22 (ref,  index: 4)
        setTint (copy, index: 5)
        localPlayer (copy, index: 6)
        workspace (copy, index: 7)
    ]]
    for _, v205 in v21 do
        v205:Disconnect()
    end

    table.clear(v21)
    child = nil
    clear()
    v22 = false
    setTint(false)
    local v206 = localPlayer:GetAttribute("State") == "Match"
    local v207 = if v206 then localPlayer:GetAttribute("MatchId") else localPlayer:GetAttribute("Spectating")

    if type(v207) ~= "string" or v207 == "" then
        return
    end

    local arenas = workspace:FindFirstChild("Arenas")

    if const child2 = arenas and arenas:FindFirstChild(v207) then
        child = child2
        return
    end

    if arenas then
        table.insert(
            v21,
            arenas.ChildAdded:Connect(
                function(child2: Instance)
                    --[[
                      line: 523
                      upvalues:
                        v207 (copy, index: 1)
                        child (ref,  index: 2)
                    ]]
                    if child2.Name == v207 then
                        child = child2
                    end
                end
            )
        )
    end
end

function v7.Start()
    --[[
      name: Start
      line: 531
      upvalues:
        v31 (ref,  index: 1)
        contentProvider (copy, index: 2)
        runService (copy, index: 3)
        styleBeams (copy, index: 4)
        localPlayer (copy, index: 5)
        bindArena (copy, index: 6)
        workspace (copy, index: 7)
        child (ref,  index: 8)
        v22 (ref,  index: 9)
        step (copy, index: 10)
    ]]
    task.spawn(
        function()
            --[[
              line: 532
              upvalues:
                v31 (ref,  index: 1)
                contentProvider (copy, index: 2)
                runService (copy, index: 3)
                styleBeams (copy, index: 4)
            ]]
            local count = 0

            while v31 ~= "ok" do
                local v212 = nil
                local contentIdList = {}

                for _, texture in {"rbxassetid://82559613851503", "rbxassetid://109193145976179"} do
                    local beam = Instance.new("Beam")
                    beam.Texture = texture
                    table.insert(contentIdList, beam)
                end

                pcall(
                    function()
                        --[[
                          line: 545
                          upvalues:
                            contentProvider (copy, index: 1)
                            contentIdList (copy, index: 2)
                            v212 (ref,  index: 3)
                        ]]
                        contentProvider:PreloadAsync(
                            contentIdList,
                            function(a217, a218)
                                --[[
                                  line: 546
                                  upvalues:
                                    v212 (ref, index: 1)
                                ]]
                                if a217 == "rbxassetid://82559613851503" then
                                    v212 = a218
                                end
                            end
                        )
                    end
                )

                for _, v220 in contentIdList do
                    v220:Destroy()
                end

                count += 1
                local success = Enum.AssetFetchStatus.Success

                if v212 == success then
                    v31 = "ok"
                elseif count == 3 then
                    v31 = "failed"

                    if runService:IsStudio() then
                        print("[RingOfFire] wall texture not loaded yet; the ring shows particles until it does")
                    end
                end

                styleBeams()

                if v31 ~= "ok" then
                    task.wait((math.min(30, count * 3)))
                end
            end
        end
    )

    localPlayer:GetAttributeChangedSignal("MatchId"):Connect(bindArena)
    localPlayer:GetAttributeChangedSignal("State"):Connect(bindArena)
    localPlayer:GetAttributeChangedSignal("Spectating"):Connect(bindArena)

    task.spawn(
        function()
            --[[
              line: 573
              upvalues:
                workspace (copy, index: 1)
                bindArena (copy, index: 2)
            ]]
            workspace:WaitForChild("Arenas", 60)
            bindArena()
        end
    )

    runService.Heartbeat:Connect(
        function()
            --[[
              line: 577
              upvalues:
                child (ref,  index: 1)
                v22 (ref,  index: 2)
                step (copy, index: 3)
            ]]
            if child or v22 then
                step()
            end
        end
    )
end

return v7