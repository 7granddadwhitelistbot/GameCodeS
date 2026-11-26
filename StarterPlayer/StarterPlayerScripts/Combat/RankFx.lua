local debris = game:GetService("Debris")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local Util = require(script.Parent.Util)
local Effects = require(script.Parent.Effects)
local Quality = require(script.Parent.Quality)
local v8 = {}
local localPlayer = players.LocalPlayer
local vfx = Util.Assets:WaitForChild("VFX", 10)
local color3 = Color3.fromRGB(196, 70, 64)
local color32 = Color3.fromRGB(70, 132, 196)
local color33 = Color3.fromRGB(232, 172, 40)
local color = Color3.fromRGB(44, 34, 26)
local color34 = Color3.fromRGB(255, 214, 140)

local function fx()
    --[[
      name: fx
      line: 35
    ]]
    return workspace:FindFirstChild("FX") or workspace
end

local function anchored(name: string, size: Vector3, color: Color3, a21, a22)
    --[[
      name: anchored
      line: 39
    ]]
    local part = Instance.new("Part")
    part.Name = name
    part.Anchored = true
    part.CanCollide = false
    part.CanQuery = false
    part.CanTouch = false
    part.CastShadow = false
    part.Size = size
    part.Color = color
    part.Material = a21 or Enum.Material.SmoothPlastic
    part.Transparency = a22 or 0
    return part
end

local function modelOf(a25)
    --[[
      name: modelOf
      line: 54
    ]]
    if typeof(a25) == "Instance" and a25:IsA("Model") then
        return a25
    end

    return nil
end

local function rootOf(a27)
    --[[
      name: rootOf
      line: 61
      upvalues:
        Util (copy, index: 1)
    ]]
    if not a27 then
        return nil
    end

    local v28 = Util.Drawn(a27)
    local v29 = if v28 and v28:IsA("Model") then v28 else a27
    local humanoidRootPart = v29:FindFirstChild("HumanoidRootPart") or a27:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
        return humanoidRootPart
    end

    return nil
end

local function camDistance(a32)
    --[[
      name: camDistance
      line: 71
    ]]
    return if const camera = workspace.CurrentCamera then (camera.CFrame.Position - a32).Magnitude else 0
end

local v34 = {}
local heartbeatConnection = nil
local v36 = 0

local function beeTemplate()
    --[[
      name: beeTemplate
      line: 105
      upvalues:
        vfx (copy, index: 1)
    ]]
    return vfx and vfx:FindFirstChild("Bee")
end

local function newBee(parent: Folder, a40)
    --[[
      name: newBee
      line: 111
      upvalues:
        vfx (copy, index: 1)
        color33 (copy, index: 2)
        color (copy, index: 3)
    ]]
    local v41
    local bee2 = vfx and vfx:FindFirstChild("Bee")
    local v43 = {}
    local v44 = {}

    if not bee2 then
        local size = Vector3.new(0.1599999964237213, 0.1599999964237213, 0.25999999046325684) * a40
        local smoothPlastic = Enum.Material.SmoothPlastic
        local bee = Instance.new("Part")
        bee.Name = "Bee"
        bee.Anchored = true
        bee.CanCollide = false
        bee.CanQuery = false
        bee.CanTouch = false
        bee.CastShadow = false
        bee.Size = size
        bee.Color = color33
        bee.Material = smoothPlastic or Enum.Material.SmoothPlastic
        bee.Transparency = 0
        bee.Shape = Enum.PartType.Ball
        local size2 = Vector3.new(0.17000000178813934, 0.17000000178813934, 0.05999999865889549) * a40
        local band = Instance.new("Part")
        band.Name = "Band"
        band.Anchored = true
        band.CanCollide = false
        band.CanQuery = false
        band.CanTouch = false
        band.CastShadow = false
        band.Size = size2
        band.Color = color
        band.Material = Enum.Material.SmoothPlastic
        band.Transparency = 0
        band.Shape = Enum.PartType.Ball
        local size3 = Vector3.new(0.3199999928474426, 0.019999999552965164, 0.10000000149011612) * a40
        local color2 = Color3.fromRGB(196, 214, 226)
        local smoothPlastic2 = Enum.Material.SmoothPlastic
        local wings = Instance.new("Part")
        wings.Name = "Wings"
        wings.Anchored = true
        wings.CanCollide = false
        wings.CanQuery = false
        wings.CanTouch = false
        wings.CastShadow = false
        wings.Size = size3
        wings.Color = color2
        wings.Material = smoothPlastic2 or Enum.Material.SmoothPlastic
        wings.Transparency = 0.35
        bee.Parent = parent
        band.Parent = parent
        wings.Parent = parent
        local v54 = {bee, band, wings}
        local identityCFrame = CFrame.identity
        local cframe = CFrame.new(0, 0, a40 * 0.04)
        local v57 = {identityCFrame, cframe, CFrame.new(0, a40 * 0.08, a40 * -0.02)}

        return bee, v54, v57
    end

    local v58 = bee2:Clone()

    if v58:IsA("Model") then
        v41 = v58.PrimaryPart
    else
        v41 = if v58:IsA("BasePart") then v58 else nil
    end

    if v58:IsA("Model") and a40 ~= 1 then
        v58:ScaleTo(a40)
    end

    local v59 = v58:IsA("BasePart") and {v58} or v58:GetDescendants()

    for _, v61 in v59 do
        if v61:IsA("BasePart") then
            local v62
            v61.Anchored = true
            v61.CanCollide = false
            v61.CanQuery = false
            v61.CanTouch = false
            v61.CastShadow = false
            table.insert(v43, v61)

            if v41 then
                v62 = v41.CFrame:ToObjectSpace(v61.CFrame)
            else
                v62 = CFrame.identity
            end

            table.insert(v44, v62)
        end
    end

    v58.Parent = parent
    local v63 = v41 or v43[1]

    return v63, v43, v44
end

local function endSwarm(a65, a66: number)
    --[[
      name: endSwarm
      line: 148
      upvalues:
        v34 (copy, index: 1)
        tweenService (copy, index: 2)
        debris (copy, index: 3)
    ]]
    if v34[a65.id] ~= a65 then
        return
    end

    v34[a65.id] = nil
    a65.ending = true

    if a65.stopLoop then
        a65.stopLoop(a66)
        a65.stopLoop = nil
    end

    for _, bee in a65.bees do
        local v69 = bee.part.Position - a65.pos
        local v70 = not (0.01 < v69.Magnitude) and Vector3.new(0, 1, 0) or v69.Unit

        for _, instance in bee.parts do
            tweenService:Create(instance, TweenInfo.new(a66, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Transparency = 1, CFrame = instance.CFrame + (v70 * 2.5) + Vector3.new(0, 1, 0)}):Play()
        end
    end

    if a65.ring then
        local propertyTable = {Transparency = 1}
        tweenService:Create(a65.ring, TweenInfo.new(a66), propertyTable):Play()
    end

    debris:AddItem(a65.folder, a66 + 0.1)
    debris:AddItem(a65.anchor, a66 + 0.2)
end

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.IgnoreWater = true
local partList = {}
local cframeList = {}

local function stepSwarms(deltaTime: number)
    --[[
      name: stepSwarms
      line: 183
      upvalues:
        partList (copy, index: 1)
        cframeList (copy, index: 2)
        localPlayer (copy, index: 3)
        rootOf (copy, index: 4)
        v34 (copy, index: 5)
        endSwarm (copy, index: 6)
        raycastParams (copy, index: 7)
        v36 (ref,  index: 8)
        v8 (copy, index: 9)
        heartbeatConnection (ref,  index: 10)
    ]]
    local timestamp = os.clock()
    table.clear(partList)
    table.clear(cframeList)
    local character = localPlayer.Character
    local v81 = rootOf(character)
    local v82 = 0
    local v83 = false

    for _, v85 in v34 do
        local v86 = true

        if v85.untilT <= timestamp then
            endSwarm(v85, 0.35)
            v83 = v86
        else
            local magnitude
            local target = v85.target

            if const v89 = if target and target.Parent then rootOf(target) else nil then
                local v90 = v89.Position + Vector3.new(0, 0.6000000238418579, 0) - v85.pos
                local magnitude2 = v90.Magnitude
                local v92 = math.min(v85.speed * deltaTime, (math.max(0, magnitude2 - 0.6)))

                if 0.01 < magnitude2 and 0 < v92 then
                    v85.pos += (v90.Unit * v92)
                end
            end

            local v93 = 1 - math.exp(-deltaTime * 6)
            v85.pos += (v85.err * v93)
            v85.err *= (1 - v93)
            v85.anchor.CFrame = CFrame.new(v85.pos)
            local pos = v85.pos
            magnitude = if const camera = workspace.CurrentCamera then (camera.CFrame.Position - pos).Magnitude else 0

            if not (140 < magnitude) then
                for _, bee in v85.bees do
                    local v98 = timestamp * bee.speed + bee.phase
                    local v99 = bee.radius * ((math.sin((timestamp * 3.1) + bee.phase) * 0.15) + 0.85)
                    local vector3 = Vector3.new(math.cos(v98) * v99, (math.sin((timestamp * bee.bob) + bee.phase) * 0.45) + (math.sin(v98) * bee.tilt), math.sin(v98) * v99)
                    local vector32 = Vector3.new(-math.sin(v98), (math.cos(v98) * bee.tilt) * 0.6, (math.cos(v98)))
                    local v102 = v85.pos + vector3
                    local cframe = CFrame.lookAt(v102, v102 - vector32)

                    for v104, part in bee.parts do
                        table.insert(partList, part)
                        table.insert(cframeList, cframe * bee.rel[v104])
                    end
                end
            end

            local ring = v85.ring

            if ring and 0.1 < timestamp - v85.ringAt then
                v85.ringAt = timestamp
                local instance = workspace:FindFirstChild("FX") or workspace
                raycastParams.FilterDescendantsInstances = {instance, character}

                if const raycastResult = workspace:Raycast(v85.pos, Vector3.new(0, -14, 0), raycastParams) then
                    ring.CFrame = CFrame.lookAt(raycastResult.Position + (raycastResult.Normal * 0.06), raycastResult.Position + (raycastResult.Normal * 1.06)) * CFrame.Angles(0, 1.5707963267948966, 0)
                    ring.Transparency = 0.6
                else
                    ring.Transparency = 1
                end
            end

            if target then
                if target == character then
                    if v81 then
                        v82 = math.max(v82, (math.clamp(1 - (((v81.Position + Vector3.new(0, 0.6000000238418579, 0) - v85.pos).Magnitude - v85.reach) / 5), 0, 1)))
                        v83 = v86
                    else
                        v83 = v86
                    end
                else
                    v83 = v86
                end
            else
                v83 = v86
            end
        end
    end

    if 0 < #partList then
        workspace:BulkMoveTo(partList, cframeList, Enum.BulkMoveMode.FireCFrameChanged)
    end

    local v109 = v36
    local v110 = v82 - v36
    local v111 = -deltaTime
    local v112 = not (v36 < v82) and 3 or 10
    v36 = v109 + (v110 * (1 - math.exp(v111 * v112)))
    v8.StepBuzz(deltaTime, v36)

    if not v83 and v36 < 0.01 and heartbeatConnection then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
        v8.StepBuzz(deltaTime, 0)
    end
end

function v8.Swarm(a113)
    --[[
      name: Swarm
      line: 260
      upvalues:
        v34 (copy, index: 1)
        endSwarm (copy, index: 2)
        Util (copy, index: 3)
        color33 (copy, index: 4)
        color3 (copy, index: 5)
        color32 (copy, index: 6)
        Quality (copy, index: 7)
        newBee (copy, index: 8)
        Effects (copy, index: 9)
        heartbeatConnection (ref,  index: 10)
        runService (copy, index: 11)
        stepSwarms (copy, index: 12)
    ]]
    local number = tonumber(a113.id)
    local position = a113.position

    if not number or typeof(position) ~= "Vector3" then
        return
    end

    local attacker
    local rate
    local magnitude

    if const v119 = v34[number] then
        endSwarm(v119, 0)
    end

    local attacker2 = a113.attacker

    if typeof(attacker2) ~= "Instance" or not attacker2:IsA("Model") then
        attacker = nil
    else
        attacker = attacker2
    end

    local enemy = attacker ~= nil and Util.IsEnemy(attacker)
    local swarm = Instance.new("Folder")
    swarm.Name = "Swarm"
    local instance = workspace:FindFirstChild("FX") or workspace
    swarm.Parent = instance
    local swarmCore = Instance.new("Part")
    swarmCore.Name = "SwarmCore"
    swarmCore.Anchored = true
    swarmCore.CanCollide = false
    swarmCore.CanQuery = false
    swarmCore.CanTouch = false
    swarmCore.CastShadow = false
    swarmCore.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    swarmCore.Color = color33
    swarmCore.Material = Enum.Material.SmoothPlastic
    swarmCore.Transparency = 1
    swarmCore.CFrame = CFrame.new(position)
    swarmCore.Parent = swarm

    local haze = Instance.new("ParticleEmitter")
    haze.Name = "Haze"
    haze.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    local newColorSequence = ColorSequence.new
    local color34 = if enemy then color3 else color32
    haze.Color = newColorSequence(color34)
    haze.LightEmission = 0.25
    haze.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.38), NumberSequenceKeypoint.new(1, 0)})
    haze.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1)})
    haze.Lifetime = NumberRange.new(0.35, 0.6)
    haze.Rate = Quality.layers and 22 or 10
    haze.Speed = NumberRange.new(0.5, 2)
    haze.SpreadAngle = Vector2.new(180, 180)
    haze.Shape = Enum.ParticleEmitterShape.Sphere
    haze.Parent = swarmCore
    local specks = Instance.new("ParticleEmitter")
    specks.Name = "Specks"
    specks.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    specks.Color = ColorSequence.new(Color3.fromRGB(60, 44, 20), Color3.fromRGB(150, 110, 30))
    specks.LightEmission = 0
    specks.LightInfluence = 1
    specks.Size = NumberSequence.new(0.16, 0.12)
    specks.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(0.8, 0.25), NumberSequenceKeypoint.new(1, 1)})
    specks.Lifetime = NumberRange.new(0.25, 0.45)

    if Quality.layers then
        rate = 70
    else
        rate = 30
    end

    specks.Rate = rate
    specks.Speed = NumberRange.new(4, 8)
    specks.SpreadAngle = Vector2.new(180, 180)
    specks.Acceleration = Vector3.new(0, 0, 0)
    specks.Drag = 3
    specks.Shape = Enum.ParticleEmitterShape.Sphere
    specks.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
    specks.Parent = swarmCore
    swarmCore.Size = Vector3.new(2.5999999046325684, 2.5999999046325684, 2.5999999046325684)
    local v130 = if const camera = workspace.CurrentCamera then (camera.CFrame.Position - position).Magnitude else 0
    local v131 = 90 < v130 and 10 or Quality.layers and 22 or 14
    local random = Random.new(number)
    local bees = {}

    for _ = 1, v131 do
        local part, parts, rel = newBee(swarm, 1.5 * random:NextNumber(0.85, 1.15))
        local v138 = {part = part, parts = parts, rel = rel, radius = random:NextNumber(0.9, 2.4)}
        local v139 = random:NextNumber(5, 9)
        local v140 = not (random:NextNumber() < 0.5) and 1 or -1
        v138.speed = v139 * v140
        v138.phase = random:NextNumber(0, math.tau)
        v138.tilt = random:NextNumber(-0.5, 0.5)
        v138.bob = random:NextNumber(5, 9)
        table.insert(bees, v138)
    end

    local color = if enemy then color3 else color32
    local swarmRing = Instance.new("Part")
    swarmRing.Name = "SwarmRing"
    swarmRing.Anchored = true
    swarmRing.CanCollide = false
    swarmRing.CanQuery = false
    swarmRing.CanTouch = false
    swarmRing.CastShadow = false
    swarmRing.Size = Vector3.new(0.05000000074505806, 5, 5)
    swarmRing.Color = color
    swarmRing.Material = Enum.Material.SmoothPlastic
    swarmRing.Transparency = 1
    swarmRing.Shape = Enum.PartType.Cylinder
    swarmRing.Parent = swarm
    local number2 = tonumber(a113.duration) or 4.5
    local v144 = {err = Vector3.new(0, 0, 0), target = nil, ringAt = 0, stopLoop = nil, ending = false, id = number, pos = position, speed = tonumber(a113.speed)
        or 18, reach = tonumber(a113.reach) or 4, untilT = os.clock() + number2, enemy = enemy, bees = bees, ring = swarmRing, folder = swarm, anchor = swarmCore}
    v34[number] = v144
    magnitude = if const camera2 = workspace.CurrentCamera then (camera2.CFrame.Position - position).Magnitude else 0

    if magnitude <= 160 then
        Util.Sound("Beehive_Break", position)
        v144.stopLoop = Util.Loop("Bees_Loop", swarmCore)
        Effects.Puff(position, Color3.fromRGB(196, 160, 96), 8, 0.9, 6, 0.5)
    end

    heartbeatConnection = heartbeatConnection or runService.Heartbeat:Connect(stepSwarms)
end

function v8.SwarmTarget(a146)
    --[[
      name: SwarmTarget
      line: 359
      upvalues:
        v34 (copy, index: 1)
        localPlayer (copy, index: 2)
        Util (copy, index: 3)
    ]]
    local v147 = v34[tonumber(a146.id) or -1]
    if not v147 then
        return
    end

    local target

    if typeof(a146.position) == "Vector3" then
        v147.err = a146.position - v147.pos
    end

    local target2 = a146.target

    if typeof(target2) ~= "Instance" or not target2:IsA("Model") then
        target = nil
    else
        target = target2
    end

    v147.target = target

    if target and target == localPlayer.Character then
        Util.Sound("Bees_Angry", v147.anchor)
    end
end

function v8.SwarmSync(a150)
    --[[
      name: SwarmSync
      line: 375
      upvalues:
        v34 (copy, index: 1)
    ]]
    local v151 = v34[tonumber(a150.id) or -1]

    if v151 and typeof(a150.position) == "Vector3" then
        v151.err = a150.position - v151.pos
    end
end

function v8.SwarmEnd(a152)
    --[[
      name: SwarmEnd
      line: 382
      upvalues:
        v34 (copy, index: 1)
        endSwarm (copy, index: 2)
    ]]
    if const v153 = v34[tonumber(a152.id) or -1] then
        endSwarm(v153, 0.3)
    end
end

local screenGui = nil
local v155 = {}
local v156 = {}

local function buildGui()
    --[[
      name: buildGui
      line: 396
      upvalues:
        localPlayer (copy, index: 1)
        screenGui (ref,  index: 2)
        v155 (copy, index: 3)
        color33 (copy, index: 4)
        color (copy, index: 5)
        v156 (copy, index: 6)
    ]]
    local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
    if not playerGui then
        return
    end

    local tribesSwarm = Instance.new("ScreenGui")
    tribesSwarm.Name = "TribesSwarm"
    tribesSwarm.IgnoreGuiInset = true
    tribesSwarm.ResetOnSpawn = false
    tribesSwarm.DisplayOrder = 4
    tribesSwarm.Enabled = false
    tribesSwarm.Parent = playerGui
    screenGui = tribesSwarm
    local v160 = {{UDim2.new(1, 0, 0.22, 0), UDim2.fromScale(0.5, 0), Vector2.new(0.5, 0), 90}, {UDim2.new(1, 0, 0.22, 0), UDim2.fromScale(0.5, 1), Vector2.new(0.5, 1), -90}, {UDim2.new(0.18, 0, 1, 0), UDim2.fromScale(0, 0.5), Vector2.new(0, 0.5), 0}, {UDim2.new(0.18, 0, 1, 0), UDim2.fromScale(1, 0.5), Vector2.new(1, 0.5), 180}}

    for _, v162 in v160 do
        local edge = Instance.new("Frame")
        edge.Name = "Edge"
        edge.Size = v162[1]
        edge.Position = v162[2]
        edge.AnchorPoint = v162[3]
        edge.BorderSizePixel = 0
        edge.BackgroundColor3 = Color3.fromRGB(196, 136, 30)
        edge.BackgroundTransparency = 1

        local uiGradient = Instance.new("UIGradient")
        uiGradient.Rotation = v162[4]
        uiGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)})
        uiGradient.Parent = edge
        edge.Parent = tribesSwarm
        table.insert(v155, edge)
    end

    local random = Random.new()

    for index = 1, 12 do
        local frame = Instance.new("Frame")
        frame.Name = "Bee" .. index
        frame.AnchorPoint = Vector2.new(0.5, 0.5)
        frame.BackgroundColor3 = color33
        frame.BorderSizePixel = 0
        frame.BackgroundTransparency = 1
        local v168 = random:NextInteger(10, 18)
        frame.Size = UDim2.fromOffset(v168, (math.floor(v168 * 0.66)))
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0.5, 0)
        uiCorner.Parent = frame

        local uiGradient = Instance.new("UIGradient")
        uiGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, color), ColorSequenceKeypoint.new(0.22, color), ColorSequenceKeypoint.new(0.23, color33), ColorSequenceKeypoint.new(0.44, color33), ColorSequenceKeypoint.new(0.45, color), ColorSequenceKeypoint.new(0.6, color), ColorSequenceKeypoint.new(0.61, color33), ColorSequenceKeypoint.new(1, color33)})
        uiGradient.Parent = frame

        local wing = Instance.new("Frame")
        wing.Name = "Wing"
        wing.AnchorPoint = Vector2.new(0.5, 1)
        wing.Position = UDim2.fromScale(0.45, 0.15)
        wing.Size = UDim2.fromScale(0.55, 0.9)
        wing.BackgroundColor3 = Color3.fromRGB(200, 216, 228)
        wing.BackgroundTransparency = 1
        wing.BorderSizePixel = 0

        local uiCorner2 = Instance.new("UICorner")
        uiCorner2.CornerRadius = UDim.new(0.5, 0)
        uiCorner2.Parent = wing
        wing.Parent = frame
        frame.Parent = tribesSwarm
        table.insert(v156, {vx = 0, vy = 0, f = frame, x = random:NextNumber(), y = random:NextNumber(), t = random:NextNumber(0, 10)})
    end
end

function v8.StepBuzz(a173, a174: number)
    --[[
      name: StepBuzz
      line: 475
      upvalues:
        screenGui (ref,  index: 1)
        buildGui (copy, index: 2)
        v155 (copy, index: 3)
        v156 (copy, index: 4)
    ]]
    if a174 < 0.02 then
        if screenGui and screenGui.Enabled then
            screenGui.Enabled = false
        end

        return
    end

    if not screenGui then
        buildGui()
    end

    local screenGui2 = screenGui
    if not screenGui2 then
        return
    end

    screenGui2.Enabled = true

    for _, frame in v155 do
        frame.BackgroundTransparency = 1 - (a174 * 0.4)
    end

    local ceilingValue = math.ceil(#v156 * math.clamp(a174, 0, 1))

    for v179, v180 in v156 do
        local backgroundTransparency, v182
        v180.t += a173
        local v183 = v179 <= ceilingValue
        local f = v180.f

        if v183 then
            backgroundTransparency = 0.05
            v182 = v180
        else
            backgroundTransparency = 1
            v182 = v180
        end

        f.BackgroundTransparency = backgroundTransparency

        if const wing = v182.f:FindFirstChild("Wing") then
            local backgroundTransparency2 = v183 and (math.floor(v182.t * 30) % 2 ~= 0 and 0.75 or 0.35) or 1
            wing.BackgroundTransparency = backgroundTransparency2
        end

        if v183 then
            local v187 = math.sin((v182.t * 1.7) + v179) * 0.38 * (1.15 - (a174 * 0.6)) + 0.5
            local v188 = math.cos((v182.t * 1.3) + (v179 * 2)) * 0.32 * (1.15 - (a174 * 0.6)) + 0.5
            v182.vx += (((v187 - v182.x) * 9 + ((math.random() - 0.5) * 6)) * a173)
            v182.vy += (((v188 - v182.y) * 9 + ((math.random() - 0.5) * 6)) * a173)
            v182.vx *= 0.94
            v182.vy *= 0.94
            v182.x = math.clamp(v182.x + (v182.vx * a173), -0.05, 1.05)
            v182.y = math.clamp(v182.y + (v182.vy * a173), -0.05, 1.05)
            v182.f.Position = UDim2.fromScale(v182.x, v182.y)
            v182.f.Rotation = math.deg((math.atan2(v182.vy, v182.vx)))
        end
    end
end

function v8.Stung()
    --[[
      name: Stung
      line: 521
      upvalues:
        v36 (ref,  index: 1)
        Util (copy, index: 2)
        heartbeatConnection (ref,  index: 3)
        runService (copy, index: 4)
        stepSwarms (copy, index: 5)
    ]]
    v36 = math.max(v36, 0.7)
    Util.Sound("Bees_Angry")
    heartbeatConnection = heartbeatConnection or runService.Heartbeat:Connect(stepSwarms)
end

local v189 = {}
local color35 = Color3.fromRGB(255, 176, 40)
local color36 = Color3.fromRGB(18, 20, 26)
local textColor3 = Color3.fromRGB(255, 255, 255)
local fontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy)
local v194 = nil
local screenGui2 = nil
local renderSteppedConnection = nil

local function clearMark(a198)
    --[[
      name: clearMark
      line: 561
      upvalues:
        v194 (ref, index: 1)
        renderSteppedConnection (ref, index: 2)
    ]]
    if const v199 = v194 then
        if not a198 or v199.key == a198 then
            v194 = nil
            v199.frame:Destroy()

            if v199.outline then
                v199.outline:Destroy()
            end

            if renderSteppedConnection then
                renderSteppedConnection:Disconnect()
                renderSteppedConnection = nil
            end
        end
    end
end

local function stepMark()
    --[[
      name: stepMark
      line: 577
      upvalues:
        v194 (ref,  index: 1)
        tweenService (copy, index: 2)
    ]]
    local v201 = v194
    local camera = workspace.CurrentCamera

    if not v201 or not camera then
        return
    end

    local viewportSize = camera.ViewportSize
    local v204 = camera:WorldToViewportPoint(v201.at)
    local v205 = v204.X
    local y = v204.Y

    if v204.Z <= 0 then
        v205 = viewportSize.X - v205
        y = viewportSize.Y
    end

    local maxValue = math.max(44, viewportSize.X - 44)
    local maxValue2 = math.max(84, viewportSize.Y - 44)
    local timestamp = os.clock()

    if timestamp - v201.born < 0.25 then
        return
    end

    if not v201.shown then
        v201.shown = true
        v201.frame.Visible = true
        local propertyTable = {Scale = 1}
        tweenService:Create(v201.scale, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), propertyTable):Play()
    end

    local x = math.clamp(v205, 44, maxValue)
    local clampedValue = math.clamp(y, 84, maxValue2)
    v201.frame.Position = UDim2.fromOffset(x, clampedValue)
    v201.pointer.Position = UDim2.new(0.5, 0, 1, -9 - (math.abs((math.sin((timestamp - v201.born) * 4))) * 2))
    local fade = math.clamp(1 - ((Vector2.new(x, clampedValue - 36) - (viewportSize / 2)).Magnitude / 110), 0, 1) * 0.75

    if 0.01 < math.abs(fade - v201.fade) then
        v201.fade = fade

        for _, fade2 in v201.fades do
            fade2.inst[fade2.prop] = fade2.base + ((1 - fade2.base) * fade)
        end
    end

    local v216 = v201.returnsAt - workspace:GetServerTimeNow()
    v201.bar.Size = UDim2.fromScale(math.clamp(v216 / v201.span, 0, 1), 1)
end

local function showMark(key, a219, position, returnsAt)
    --[[
      name: showMark
      line: 616
      upvalues:
        v194 (ref,  index: 1)
        renderSteppedConnection (ref,  index: 2)
        screenGui2 (ref,  index: 3)
        localPlayer (copy, index: 4)
        color36 (copy, index: 5)
        color35 (copy, index: 6)
        fontFace (copy, index: 7)
        textColor3 (copy, index: 8)
        runService (copy, index: 9)
        stepMark (copy, index: 10)
    ]]
    local v222

    if const v223 = v194 then
        v194 = nil
        v223.frame:Destroy()

        if v223.outline then
            v223.outline:Destroy()
        end

        if renderSteppedConnection then
            renderSteppedConnection:Disconnect()
            renderSteppedConnection = nil
        end
    end

    local tribesHatchetMark = screenGui2

    if not tribesHatchetMark or not tribesHatchetMark.Parent then
        local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
        if not playerGui then
            return
        end

        tribesHatchetMark = Instance.new("ScreenGui")
        tribesHatchetMark.Name = "TribesHatchetMark"
        tribesHatchetMark.ResetOnSpawn = false
        tribesHatchetMark.IgnoreGuiInset = true
        tribesHatchetMark.ScreenInsets = Enum.ScreenInsets.None
        tribesHatchetMark.DisplayOrder = 4
        tribesHatchetMark.Parent = playerGui
        screenGui2 = tribesHatchetMark
    end

    local mark = Instance.new("Frame")
    mark.Name = "Mark"
    mark.AnchorPoint = Vector2.new(0.5, 1)
    mark.Size = UDim2.fromOffset(96, 54)
    mark.BackgroundTransparency = 1
    mark.Visible = false

    local scale = Instance.new("UIScale")
    scale.Scale = 0.6
    scale.Parent = mark

    local pill = Instance.new("Frame")
    pill.Name = "Pill"
    pill.AnchorPoint = Vector2.new(0.5, 0)
    pill.Position = UDim2.new(0.5, 0, 0, 4)
    pill.Size = UDim2.fromOffset(84, 26)
    pill.BackgroundColor3 = color36
    pill.BackgroundTransparency = 0.25
    pill.BorderSizePixel = 0
    pill.Parent = mark

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 7)
    uiCorner.Parent = pill

    local inst = Instance.new("UIStroke")
    inst.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    inst.Thickness = 1.5
    inst.Color = color35
    inst.Transparency = 0.35
    inst.Parent = pill

    local inst2 = Instance.new("TextLabel")
    inst2.BackgroundTransparency = 1
    inst2.Size = UDim2.new(1, 0, 1, -4)
    inst2.FontFace = fontFace
    inst2.TextSize = 15
    inst2.TextColor3 = textColor3
    inst2.Text = "PICK UP"
    inst2.AutoLocalize = false
    inst2.Parent = pill

    local timer = Instance.new("Frame")
    timer.Name = "Timer"
    timer.AnchorPoint = Vector2.new(0, 1)
    timer.Position = UDim2.new(0, 10, 1, -4)
    timer.Size = UDim2.new(1, -20, 0, 2)
    timer.BackgroundTransparency = 1
    timer.Parent = pill

    local left = Instance.new("Frame")
    left.Name = "Left"
    left.Size = UDim2.fromScale(1, 1)
    left.BackgroundColor3 = color35
    left.BorderSizePixel = 0
    left.Parent = timer

    local pointer = Instance.new("Frame")
    pointer.Name = "Pointer"
    pointer.AnchorPoint = Vector2.new(0.5, 0.5)
    pointer.Size = UDim2.fromOffset(10, 10)
    pointer.Rotation = 45
    pointer.BackgroundColor3 = color35
    pointer.BorderSizePixel = 0
    pointer.Parent = mark

    local uiCorner2 = Instance.new("UICorner")
    uiCorner2.CornerRadius = UDim.new(0, 2)
    uiCorner2.Parent = pointer

    local inst3 = Instance.new("UIStroke")
    inst3.Thickness = 1.5
    inst3.Color = color36
    inst3.Transparency = 0.3
    inst3.Parent = pointer
    mark.Parent = tribesHatchetMark
    local pickUpOutline = Instance.new("Highlight")
    pickUpOutline.Name = "PickUpOutline"
    pickUpOutline.FillColor = color35
    pickUpOutline.FillTransparency = 0.8
    pickUpOutline.OutlineColor = color35
    pickUpOutline.OutlineTransparency = 0.15
    pickUpOutline.DepthMode = Enum.HighlightDepthMode.Occluded
    pickUpOutline.Adornee = a219
    pickUpOutline.Parent = a219
    local serverTimeNow = workspace:GetServerTimeNow()

    if type(returnsAt) ~= "number" or not (serverTimeNow < returnsAt) then
        v222 = serverTimeNow + 5
    else
        v222 = returnsAt
    end

    local fades = {{prop = "BackgroundTransparency", inst = pill, base = pill.BackgroundTransparency}, {prop = "Transparency", inst = inst, base = inst.Transparency}, {prop = "TextTransparency", base = 0, inst = inst2}, {prop = "BackgroundTransparency", base = 0, inst = left}, {prop = "BackgroundTransparency", base = 0, inst = pointer}, {prop = "Transparency", inst = inst3, base = inst3.Transparency}}
    v194 = {shown = false, fade = 0, key = key, at = position + Vector3.new(0, 1.600000023841858, 0), frame = mark, bar = left, pointer = pointer, scale = scale, born = os.clock(), returnsAt = v222, span = math.max(0.5, v222 - serverTimeNow), outline = pickUpOutline, fades = fades}
    renderSteppedConnection = renderSteppedConnection or runService.RenderStepped:Connect(stepMark)
    stepMark()
end

local function hatchetModel()
    --[[
      name: hatchetModel
      line: 727
      upvalues:
        vfx (copy, index: 1)
    ]]
    local hatchet = vfx
        and (vfx:FindFirstChild("Hatchet")
            or vfx:FindFirstChild("Projectiles") and vfx.Projectiles:FindFirstChild("Hatchet"))
    if not hatchet then
        local parent = Instance.new("Model")
        local color = Color3.fromRGB(150, 104, 66)
        local wood = Enum.Material.Wood
        local haft = Instance.new("Part")
        haft.Name = "Haft"
        haft.Anchored = true
        haft.CanCollide = false
        haft.CanQuery = false
        haft.CanTouch = false
        haft.CastShadow = false
        haft.Size = Vector3.new(0.18000000715255737, 2.200000047683716, 0.18000000715255737)
        haft.Color = color
        haft.Material = wood or Enum.Material.SmoothPlastic
        haft.Transparency = 0
        haft.CFrame = CFrame.new(0, 1.1, 0.3)
        haft.Parent = parent
        local color2 = Color3.fromRGB(80, 80, 86)
        local metal = Enum.Material.Metal
        local head = Instance.new("Part")
        head.Name = "Head"
        head.Anchored = true
        head.CanCollide = false
        head.CanQuery = false
        head.CanTouch = false
        head.CastShadow = false
        head.Size = Vector3.new(0.11999999731779099, 0.800000011920929, 0.75)
        head.Color = color2
        head.Material = metal or Enum.Material.SmoothPlastic
        head.Transparency = 0
        head.CFrame = CFrame.new(0, 0.2, 0)
        head.Parent = parent
        parent.PrimaryPart = head

        return parent
    end

    local v249 = hatchet:Clone()
    local v250 = v249:IsA("BasePart") and {v249} or v249:GetDescendants()

    for _, v252 in v250 do
        if v252:IsA("BasePart") then
            v252.Anchored = true
            v252.CanCollide = false
            v252.CanQuery = false
            v252.CanTouch = false
        elseif v252:IsA("Trail") or v252:IsA("ParticleEmitter") then
            v252.Enabled = false
        end
    end

    return v249
end

local function place(a254, cFrame)
    --[[
      name: place
      line: 755
    ]]
    if a254:IsA("Model") then
        a254:PivotTo(cFrame)
        return
    end

    if a254:IsA("BasePart") then
        a254.CFrame = cFrame
    end
end

function v8.HatchetDrop(a256)
    --[[
      name: HatchetDrop
      line: 763
      upvalues:
        v189 (copy, index: 1)
        hatchetModel (copy, index: 2)
        Util (copy, index: 3)
        Effects (copy, index: 4)
        localPlayer (copy, index: 5)
        showMark (copy, index: 6)
        v194 (ref,  index: 7)
        renderSteppedConnection (ref,  index: 8)
    ]]
    local key = a256.key
    local cframe = a256.cframe

    if type(key) ~= "string" or typeof(cframe) ~= "CFrame" then
        return
    end

    local owner

    if const v260 = v189[key] then
        v260.model:Destroy()
    end

    local model = hatchetModel()

    if model:IsA("Model") then
        model:PivotTo(cframe)
    elseif model:IsA("BasePart") then
        model.CFrame = cframe
    end

    local instance = workspace:FindFirstChild("FX") or workspace
    model.Parent = instance
    local owner2 = a256.owner

    if typeof(owner2) ~= "Instance" or not owner2:IsA("Model") then
        owner = nil
    else
        owner = owner2
    end

    v189[key] = {model = model, owner = owner}
    local position = cframe.Position
    local v266 = if const camera = workspace.CurrentCamera then (camera.CFrame.Position - position).Magnitude else 0

    if v266 <= 120 then
        Util.Sound("Hatchet_Thunk", cframe.Position)
        Effects.Puff(cframe.Position, Color3.fromRGB(150, 132, 108), 5, 0.6, 4, 0.4)
    end

    if owner and owner == localPlayer.Character then
        showMark(key, model, cframe.Position, a256.returnsAt)
    end

    task.delay(
        10,
        function()
            --[[
              line: 786
              upvalues:
                v189 (copy, index: 1)
                key (copy, index: 2)
                model (copy, index: 3)
                v194 (ref,  index: 4)
                renderSteppedConnection (ref,  index: 5)
            ]]
            local v267 = v189[key]

            if v267 and v267.model == model then
                v189[key] = nil
                local key2 = key
                local v269 = v194

                if v269 and (not key2 or v269.key == key2) then
                    v194 = nil
                    v269.frame:Destroy()

                    if v269.outline then
                        v269.outline:Destroy()
                    end

                    if renderSteppedConnection then
                        renderSteppedConnection:Disconnect()
                        renderSteppedConnection = nil
                    end
                end

                model:Destroy()
            end
        end
    )
end

function v8.HatchetEnd(a270)
    --[[
      name: HatchetEnd
      line: 796
      upvalues:
        v189 (copy, index: 1)
        v194 (ref,  index: 2)
        renderSteppedConnection (ref,  index: 3)
        rootOf (copy, index: 4)
        runService (copy, index: 5)
        tweenService (copy, index: 6)
        debris (copy, index: 7)
        localPlayer (copy, index: 8)
        Util (copy, index: 9)
    ]]
    local key = a270.key

    if type(key) ~= "string" then
        return
    end

    local owner
    local v273
    local v274 = v189[key]
    v189[key] = nil
    local v275 = v194

    if v275 and (not key or v275.key == key) then
        v194 = nil
        v275.frame:Destroy()

        if v275.outline then
            v275.outline:Destroy()
        end

        if renderSteppedConnection then
            renderSteppedConnection:Disconnect()
            renderSteppedConnection = nil
        end
    end

    local owner2 = a270.owner

    if typeof(owner2) ~= "Instance" or not owner2:IsA("Model") then
        owner = nil
    else
        owner = owner2
    end

    if owner then
        local _ = rootOf(owner)
    else
        v273 = nil
    end

    if v274 then
        local model = v274.model

        if v273 and a270.how == "pickup" then
            local v279 = if model:IsA("Model") then model:GetPivot() else model.CFrame
            local timestamp = os.clock()
            local heartbeatConnection = nil

            heartbeatConnection = runService.Heartbeat:Connect(
                function()
                    --[[
                      line: 813
                      upvalues:
                        timestamp (copy, index: 1)
                        model (copy, index: 2)
                        v273 (copy, index: 3)
                        heartbeatConnection (ref,  index: 4)
                        v279 (copy, index: 5)
                    ]]
                    local clampedValue = math.clamp((os.clock() - timestamp) / 0.12, 0, 1)

                    if not model.Parent or not v273.Parent or 1 <= clampedValue then
                        if heartbeatConnection then
                            heartbeatConnection:Disconnect()
                        end

                        model:Destroy()

                        return
                    end

                    local cFrame = v279:Lerp(v273.CFrame * CFrame.new(0.8, 0.6, -0.6), clampedValue * clampedValue)

                    if model:IsA("Model") then
                        model:PivotTo(cFrame)
                        return
                    end

                    if model:IsA("BasePart") then
                        model.CFrame = cFrame
                    end
                end
            )
        else
            local instances = model:IsA("BasePart") and {model} or model:GetDescendants()

            for _, instance in instances do
                if instance:IsA("BasePart") then
                    local propertyTable = {Transparency = 1}
                    tweenService:Create(instance, TweenInfo.new(0.25), propertyTable):Play()
                end
            end

            debris:AddItem(model, 0.3)
        end
    end

    local v288 = false

    if a270.how ~= "reset" and owner and v273 then
        if owner == localPlayer.Character then
            v288 = true
        else
            local position = v273.Position
            local camera = workspace.CurrentCamera

            if ((not camera and 0) or (camera.CFrame.Position - position).Magnitude) <= 80 then
                v288 = true
            end
        end
    end

    if v288 then
        Util.Sound("Hatchet_Catch", v273)
    end
end

function v8.ParryStart(a291)
    --[[
      name: ParryStart
      line: 840
      upvalues:
        localPlayer (copy, index: 1)
        rootOf (copy, index: 2)
        Util (copy, index: 3)
        Effects (copy, index: 4)
    ]]
    local attacker
    local attacker2 = a291.attacker

    if typeof(attacker2) ~= "Instance" or not attacker2:IsA("Model") then
        attacker = nil
    else
        attacker = attacker2
    end

    if attacker and attacker ~= localPlayer.Character then
        if const v294 = rootOf(attacker) then
            local position = v294.Position
            local camera = workspace.CurrentCamera

            if not (150 < ((not camera and 0) or (camera.CFrame.Position - position).Magnitude)) then
                Util.Sound("Katana_Flick", v294)
                local tool = attacker:FindFirstChildOfClass("Tool")

                if const v298 = Util.ToolPoint(tool, "Tip") then
                    Effects.Burst("Charge_Sparkle", CFrame.new(v298), 0.6, Color3.fromRGB(170, 210, 240))
                end
            end
        end
    end
end

function v8.Parried(a299)
    --[[
      name: Parried
      line: 860
      upvalues:
        Util (copy, index: 1)
        Effects (copy, index: 2)
        color34 (copy, index: 3)
        rootOf (copy, index: 4)
        tweenService (copy, index: 5)
        debris (copy, index: 6)
    ]]
    local position = a299.position

    if typeof(position) == "Vector3" then
        local camera = workspace.CurrentCamera

        if not (160 < ((not camera and 0) or (camera.CFrame.Position - position).Magnitude)) then
            local target
            local ranged = a299.ranged == true
            local sound = Util.Sound
            local v305 = ranged and "Katana_Deflect" or "Katana_Parry"
            sound(v305, position)
            local burst = Effects.Burst
            local cframe = CFrame.new(position)
            local v308 = ranged and 1.2 or 1.6
            burst("Block_Spark", cframe, v308, color34)
            Effects.Burst("Impact_Sparks", CFrame.new(position), 0.8, color34)
            local target2 = a299.target

            if typeof(target2) ~= "Instance" then
                target = nil
            elseif target2:IsA("Model") then
                target = target2
            else
                target = nil
            end

            local v311 = if const v310 = rootOf(target) then v310.CFrame.LookVector else Vector3.new(0, 0, 1)
            local color = Color3.fromRGB(176, 214, 240)
            local parryRing = Instance.new("Part")
            parryRing.Name = "ParryRing"
            parryRing.Anchored = true
            parryRing.CanCollide = false
            parryRing.CanQuery = false
            parryRing.CanTouch = false
            parryRing.CastShadow = false
            parryRing.Size = Vector3.new(0.05000000074505806, 0.6000000238418579, 0.6000000238418579)
            parryRing.Color = color
            parryRing.Material = Enum.Material.SmoothPlastic
            parryRing.Transparency = 0.3
            parryRing.Shape = Enum.PartType.Cylinder
            parryRing.CFrame = CFrame.lookAt(position, position + v311) * CFrame.Angles(0, 1.5707963267948966, 0)
            local instance = workspace:FindFirstChild("FX") or workspace
            parryRing.Parent = instance
            local tweenInfo = TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            local propertyTable = {Transparency = 1}
            local y = ranged and 3.2 or 4.2
            local z = ranged and 3.2 or 4.2
            propertyTable.Size = Vector3.new(0.05, y, z)
            tweenService:Create(parryRing, tweenInfo, propertyTable):Play()
            debris:AddItem(parryRing, 0.3)
        end
    end
end

return v8